module Main where

import Prelude

import Control.Monad.Eff (Eff ())
import Control.Monad.Eff.Class (liftEff)
import Data.TypedArray (asFloat32Array)
import Data.Maybe.Unsafe (fromJust)
import Graphics.Canvas (Canvas (), getCanvasElementById)
import Graphics.WebGL (runWebgl, runWebglWithShaders)
import Graphics.WebGL.Context (getWebglContext)
import Graphics.WebGL.Methods
import Graphics.WebGL.Types

import Renoma.Shaders

type MyWebGLProgram a = forall eff. Eff (canvas :: Canvas | eff) a

main :: MyWebGLProgram Unit
main = getContext >>= runProgram

getContext :: MyWebGLProgram WebGLContext
getContext = do
  canvas <- fromJust <$> getCanvasElementById "glcanvas"
  context <- fromJust <$> getWebglContext canvas
  return context

runProgram :: WebGLContext -> MyWebGLProgram Unit
runProgram ctx = do
  _ <- liftEff $ runWebglWithShaders wgl ctx vertexShaderString fragmentShaderString
  return unit

wgl :: WebGLProgram -> { a_Position :: Attribute Vec4 } -> { u_perspective :: Uniform Mat4 } -> WebGL Unit
wgl _ attr unif =
  let
    --camera = defaultCamera
    perspective = asFloat32Array
      [ 9.0/16.0, 0.0, 0.0, 0.0
      , 0.0, 1.0, 0.0, 0.0
      , 0.0, 0.0, 1.0, 0.0
      , 0.0, 0.0, 0.0, 1.0
      ]
    vertices = DataSource $ asFloat32Array
      [ -0.1,  0.1
      ,  0.1,  0.1
      ,  0.1, -0.1
      , -0.1, -0.1
      ]
  in
    do
      triBuf <- createBuffer
      bindBuffer ArrayBuffer triBuf
      bufferData ArrayBuffer vertices StaticDraw

      vertexAttribPointer attr.a_Position 2 Float false 0 0
      enableVertexAttribArray attr.a_Position

      uniformMatrix4fv unif.u_perspective perspective

      clearColor 0.0 0.0 0.0 1.0
      clear ColorBuffer
      drawArrays TriangleFan 0 4
