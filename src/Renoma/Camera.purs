module Renoma.Camera where

import Data.Matrix4
import Data.Vector3
import Math
import Prelude

import Renoma.Types (Meters (), Scalar ())

type Camera =
  { pos         :: Vec3 Meters
  , pitch       :: Radians
  , heading     :: Radians
  , fov         :: Radians
  }

toMat4 :: Camera -> Mat4
toMat4 cam =
  let
    a = cam.pitch
    b = cam.heading
    --transMat = makeTranslate cam.pos
    rotMat = mat4 -- unsure if correct!
      [  (cos b),           0.0,    (sin b),           0.0
      ,  (sin a) * (sin b), cos a, -(cos b) * (sin a), 0.0
      , -(cos a) * (sin b), sin a,  (cos a) * (cos b), 0.0
      ,   0.0,              0.0,     0.0,              1.0
      ]
  in
    rotMat --mulM rotMat transMat


defaultCamera :: Camera
defaultCamera =
  { pos     : vec3 0.2 0.0 (-10.0)
  , pitch   : pi / 16.0
  , heading : pi / 8.0
  , fov     : 0.0
  }
