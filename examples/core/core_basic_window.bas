/'*******************************************************************************************
*
*   raylib [core] example - Basic window
*
*   Welcome to raylib!
*
*   To test examples, just press F5 (in WinFBE)
*   Note that compiled executable is placed in the same folder as .bas file
*
*   You can find all basic examples on C:\raylib\raylib\examples folder or
*   raylib official webpage: www.raylib.com
*
*   Enjoy using raylib. :)
*
*   Example originally created with raylib 1.0, last time updated with raylib 1.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2013-2024 Ramon Santamaria (@raysan5)
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

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - basic window" )

SetTargetFPS( 60 )      ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()     ' Detect window close button or ESC key
  '' Update
  ''----------------------------------------------------------------------------------
  '' TODO: Update your variables here
  ''----------------------------------------------------------------------------------
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    DrawText( "Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY )
  EndDrawing()
wend

'' De-Initialization
CloseWindow()      ' Close window and OpenGL context
