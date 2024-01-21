/'*******************************************************************************************
*
*   raylib [core] example - Mouse input
*
*   Example originally created with raylib 1.0, last time updated with raylib 4.0
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

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - mouse input" )

var ballPosition = Vector2( -100.0f, -100.0f )
dim as RlColor ballColor = DARKBLUE

SetTargetFPS( 60 )            ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()
  '' Update
  ballPosition = GetMousePosition()

  if IsMouseButtonPressed( MOUSE_BUTTON_LEFT ) then
    ballColor = MAROON
  elseif IsMouseButtonPressed( MOUSE_BUTTON_MIDDLE ) then
    ballColor = LIME
  elseif IsMouseButtonPressed( MOUSE_BUTTON_RIGHT ) then
    ballColor = DARKBLUE
  elseif IsMouseButtonPressed(MOUSE_BUTTON_SIDE) then
     ballColor = PURPLE
  elseif IsMouseButtonPressed(MOUSE_BUTTON_EXTRA) then
    ballColor = YELLOW
  elseif IsMouseButtonPressed(MOUSE_BUTTON_FORWARD) then
    ballColor = ORANGE
  elseif IsMouseButtonPressed(MOUSE_BUTTON_BACK) then
    ballColor = BEIGE
  end if
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    DrawCircleV( ballPosition, 40, ballColor)
    DrawText( "move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY )
  EndDrawing()
wend

'' De-Initialization
CloseWindow()            ' Close window and OpenGL context
