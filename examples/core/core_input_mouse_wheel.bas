/'*******************************************************************************************
*
*   raylib [core] examples - Mouse wheel input
*
*   Example originally created with raylib 1.1, last time updated with raylib 1.3
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

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - input mouse wheel" )

dim as long _
  boxPositionY = screenHeight / 2 - 40, _
  scrollSpeed = 4            ' Scrolling speed in pixels

SetTargetFPS( 60 )           ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()      ' Detect window close button or ESC key
  '' Update
  boxPositionY -= ( GetMouseWheelMove() * scrollSpeed )
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    DrawRectangle( screenWidth / 2 - 40, boxPositionY, 80, 80, MAROON )
    DrawText( "Use mouse wheel to move the cube up and down!", 10, 10, 20, GRAY )
    DrawText( TextFormat("Box position Y: %03i", boxPositionY ), 10, 40, 20, LIGHTGRAY )
  EndDrawing()
wend

'' De-Initialization
CloseWindow()             ' Close window and OpenGL context
