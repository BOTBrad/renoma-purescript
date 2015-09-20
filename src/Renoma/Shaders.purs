module Renoma.Shaders where

vertexShaderString :: String
vertexShaderString = """
attribute vec4 a_Position;
uniform mat4 u_perspective;

void main() {
  gl_Position = u_perspective * a_Position;
}
"""

fragmentShaderString :: String
fragmentShaderString = """
void main() {
  gl_FragColor = vec4(0.0, 1.0, 1.0, 1.0);
}
"""
