/'*******************************************************************************************
*
*   raylib [audio] example - Sound loading and playing
*
*   Example originally created with raylib 1.1, last time updated with raylib 3.5
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

InitWindow( screenWidth, screenHeight, "raylib-freebasic [audio] example - sound loading and playing" )

InitAudioDevice()        ' Initialize audio device

dim as Sound _
  fxWav = LoadSound( "resources/sound.wav" ), _    ' Load WAV audio file
  fxOgg = LoadSound( "resources/target.ogg" )      ' Load OGG audio file

SetTargetFPS( 60 )           ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()       ' Detect window close button or ESC key
  '' Update
  if IsKeyPressed( KEY_SPACE ) then PlaySound( fxWav )     ' Play WAV sound
  if IsKeyPressed( KEY_ENTER ) then PlaySound( fxOgg )     ' Play OGG sound
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    DrawText( "Press SPACE to PLAY the WAV sound!", 200, 180, 20, LIGHTGRAY )
    DrawText( "Press ENTER to PLAY the OGG sound!", 200, 220, 20, LIGHTGRAY )
  EndDrawing()
wend

'' De-Initialization
UnloadSound( fxWav )     ' Unload sound data
UnloadSound( fxOgg )     ' Unload sound data

CloseAudioDevice()       ' Close audio device

CloseWindow()            ' Close window and OpenGL context
