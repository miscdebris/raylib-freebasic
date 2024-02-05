/'*******************************************************************************************
*
*   raylib [core] example - Generate random values
*
*   Example originally created with raylib 1.1, last time updated with raylib 1.1
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

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - generate random values" )

dim as ulong framesCounter = 0     ' Variable used to count frames
dim as long randValue = GetRandomValue( -8, 5 )    ' Get a random integer number between -8 and 5 (both included)

SetTargetFPS( 60 )     ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()
    '' Update
  framesCounter += 1

  '' Every two seconds (120 frames) a new random value is generated
  if ( ( framesCounter / 120 ) mod 2 ) = 1 then
    randValue = GetRandomValue( -8, 5 )
    framesCounter = 0
  end if

  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    DrawText( "Every 2 seconds a new random value is generated:", 130, 100, 20, MAROON )
    DrawText( TextFormat( "%i", randValue ), 360, 180, 80, LIGHTGRAY )
  EndDrawing()
wend

'' De-Initialization
CloseWindow()      ' Close window and OpenGL context
