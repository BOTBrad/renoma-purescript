module Main where

import Prelude

import Control.Monad.Eff (Eff ())
import Control.Monad.Eff.Class (liftEff)
import Data.Maybe.Unsafe (fromJust)
import Graphics.Canvas (Canvas (), getCanvasElementById)
import Graphics.WebGL (runWebgl)
import Graphics.WebGL.Context (getWebglContext)
import Graphics.WebGL.Methods
import Graphics.WebGL.Types

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
  _ <- liftEff $ runWebgl wgl ctx
  return unit

wgl = do
  clearColor 0.0 1.0 0.0 1.0
  clear ColorBuffer
