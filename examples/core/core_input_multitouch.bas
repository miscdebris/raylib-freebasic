/'*******************************************************************************************
*
*   raylib [core] example - Input multitouch
*
*   Example originally created with raylib 2.1, last time updated with raylib 2.5
*
*   Example contributed by Berni (@Berni8k) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Berni (@Berni8k) and Ramon Santamaria (@raysan5)
*
*   translated to FreeBASIC by:
*     Copyright (c) 2021 glasyalabolas (MIT)
*     Copyright (c) 2024 miscdebris (MIT)
*
********************************************************************************************'/

#include "raylib.bi"

#define MAX_TOUCH_POINTS 10

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - input multitouch" )

dim as Vector2 touchPositions(0 to MAX_TOUCH_POINTS-1)

SetTargetFPS( 60 )      ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()
  '' Update
 
  '' Get the touch point count ( how many fingers are touching the screen )
  dim as long tCount = GetTouchPointCount()
  '' Clamp touch points available ( set the maximum touch points allowed )
  if tCount > MAX_TOUCH_POINTS then tCount = MAX_TOUCH_POINTS
  '' Get touch points positions
  for i as long = 0 to tCount -1 
    touchPositions(i) = GetTouchPosition(i)
  next i
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    '' Multitouch
    for i as long = 0 to tCount-1
      '' Make sure point is not (0, 0) as this means there is no touch for it
      if touchPositions(i).x > 0 andAlso touchPositions(i).y > 0 then
        '' Draw circle and touch index number
        DrawCircleV( touchPositions(i), 34, ORANGE )
        DrawText( TextFormat( "%d", i ), touchPositions(i).x - 10, touchPositions(i).y - 70, 40, BLACK )
      end if
    next

    DrawText( "touch the screen at multiple locations to get multiple balls", 10, 10, 20, DARKGRAY )
  EndDrawing()
wend

'' De-Initialization
CloseWindow()      ' Close window and OpenGL context
