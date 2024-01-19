/'*******************************************************************************************
*
*   raylib [core] example - Initialize 3d camera free
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
*   translated to FreeBASIC by:
*     Copyright (c) 2021 glasyalabolas (MIT)
*     Copyright (c) 2024 miscdebris (MIT)
*
********************************************************************************************'/

#include "raylib.bi"

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - 3d camera free" )

'' Define the camera to look into our 3d world
dim as Camera3D camera

with camera
  .position = Vector3( 10.0f, 10.0f, 10.0f )  ' Camera position
  .target = Vector3( 0.0f, 0.0f, 0.0f )       ' Camera looking at point
  .up = Vector3( 0.0f, 1.0f, 0.0f )           ' Camera up vector (rotation towards target)
  .fovy = 45.0f                               ' Camera field-of-view Y
  .projection = CAMERA_PERSPECTIVE            ' Camera projection type
end with

var cubePosition = Vector3( 0.0f, 0.0f, 0.0f )

DisableCursor()                    ' Limit cursor to relative movement inside the window


SetTargetFPS( 60 )                 ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()      ' Detect window close button or ESC key
  '' Update
  UpdateCamera( @camera, CAMERA_FREE )
  
  if IsKeyPressed( ASC("Z") ) then camera.target = Vector3( 0.0f, 0.0f, 0.0f )
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    BeginMode3D( camera )
      DrawCube( cubePosition, 2.0f, 2.0f, 2.0f, RED )
      DrawCubeWires( cubePosition, 2.0f, 2.0f, 2.0f, MAROON )
      DrawGrid( 10, 1.0f )
    EndMode3D()
    
    DrawRectangle( 10, 10, 320, 133, Fade( SKYBLUE, 0.5f ) )
    DrawRectangleLines( 10, 10, 320, 93, BLUE )
    
    DrawText( "Free camera default controls:", 20, 20, 10, BLACK )
    DrawText( "- Mouse Wheel to Zoom in-out", 40, 40, 10, DARKGRAY )
    DrawText( "- Mouse Wheel Pressed to Pan", 40, 60, 10, DARKGRAY )
    DrawText( "- Z to zoom to (0, 0, 0)", 40, 80, 10, DARKGRAY )
  EndDrawing()
wend

'' De-Initialization
CloseWindow()              ' Close window and OpenGL context
