/'*******************************************************************************************
*
*   raylib [audio] example - Mixed audio processing
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example contributed by hkc (@hatkidchan) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 hkc (@hatkidchan)
*
*   translated to FreeBASIC by:
*     Copyright (c) 2024 miscdebris (MIT)
*
********************************************************************************************'/

#include "raylib.bi"

dim shared as single exponent = 1.0f                  ' Audio exponentiation value
dim shared as single averageVolume(0 to 399)          ' Average volume history

'' Audio processing function
sub ProcessAudio cdecl (byval buffer as any ptr, byval frames as ulong)
  dim as single ptr samples = buffer   ' Samples internally stored as <single>s
  dim as single average = 0.0f         ' Temporary average volume

  for frame as unsigned long = 0 to frames - 1
    dim as single ptr left_ = samples + (frame * 2 + 0)
    dim as single ptr right_ = samples + (frame * 2 + 1)

    *left_ = (abs(*left_) ^ exponent) * iif(*left_ < 0.0f, -1.0f, 1.0f)
    *right_ = (abs(*right_) ^ exponent) * iif(*right_ < 0.0f, -1.0f, 1.0f)

    average += abs(*left_) / frames   ' accumulating average volume
    average += abs(*right_) / frames
  next frame

  '' Moving history to the left
  for i as long = 0 to 398
    averageVolume(i) = averageVolume(i + 1)
  next i

  averageVolume(399) = average         ' Adding last average value
end sub

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib-freebasic [audio] example - processing mixed output")

InitAudioDevice()              ' Initialize audio device

AttachAudioMixedProcessor(@ProcessAudio)

dim as Music music = LoadMusicStream("resources/country.mp3")
dim as Sound sound = LoadSound("resources/coin.wav")

PlayMusicStream(music)

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second

while not WindowShouldClose()    ' Detect window close button or ESC key
  '' Update
  UpdateMusicStream(music)   ' Update music buffer with new stream data

  '' Modify processing variables
  if IsKeyPressed(KEY_LEFT) then exponent -= 0.05f
  if IsKeyPressed(KEY_RIGHT) then exponent += 0.05f

  if exponent <= 0.5f then exponent = 0.5f
  if exponent >= 3.0f then exponent = 3.0f

  if IsKeyPressed(KEY_SPACE) then PlaySound(sound)

  '' Draw
  BeginDrawing()

      ClearBackground(RAYWHITE)

      DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, LIGHTGRAY)

      DrawText(TextFormat("EXPONENT = %.2f", exponent), 215, 180, 20, LIGHTGRAY)

      DrawRectangle(199, 199, 402, 34, LIGHTGRAY)
      for i as long  = 0 to 399
          DrawLine(201 + i, 232 - averageVolume(i) * 32, 201 + i, 232, MAROON)
      next i
      
      DrawRectangleLines(199, 199, 402, 34, GRAY)

      DrawText("PRESS SPACE TO PLAY OTHER SOUND", 200, 250, 20, LIGHTGRAY)
      DrawText("USE LEFT AND RIGHT ARROWS TO ALTER DISTORTION", 140, 280, 20, LIGHTGRAY)

  EndDrawing()
wend

'' De-Initialization
UnloadMusicStream(music)   ' Unload music stream buffers from RAM

DetachAudioMixedProcessor(@ProcessAudio)  ' Disconnect audio processor

CloseAudioDevice()         ' Close audio device (music streaming is automatically stopped)

CloseWindow()             ' Close window and OpenGL context
