/'*******************************************************************************************
*
*   raylib [core] example - Keyboard input
*
*   Example originally created with raylib 1.0, last time updated with raylib 1.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
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

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - keyboard input" )

var ballPosition = Vector2( screenWidth / 2, screenHeight / 2 )

SetTargetFPS( 60 )           ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()
  '' Update
  if IsKeyDown( KEY_RIGHT ) then ballPosition.x += 2.0f
  if IsKeyDown( KEY_LEFT ) then ballPosition.x -= 2.0f
  if IsKeyDown( KEY_UP ) then ballPosition.y -= 2.0f
  if IsKeyDown( KEY_DOWN ) then ballPosition.y += 2.0f
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    DrawText( "move the ball with arrow keys", 10, 10, 20, DARKGRAY )
    DrawCircleV( ballPosition, 50, MAROON)
  EndDrawing()
wend

'' De-Initialization
CloseWindow()           ' Close window and OpenGL context
