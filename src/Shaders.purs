module Shaders where

vertexShaderString :: String
vertexShaderString = """
attribute vec4 a_Position;

void main() {
  gl_Position = a_Position;
}
"""

fragmentShaderString :: String
fragmentShaderString = """
void main() {
  gl_FragColor = vec4(0.0, 1.0, 1.0, 1.0);
}
"""
