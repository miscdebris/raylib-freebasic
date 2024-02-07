/'*******************************************************************************************
*
*   raylib [core] example - Custom logging
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example contributed by Pablo Marcos Oltra (@pamarcos) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Pablo Marcos Oltra (@pamarcos) and Ramon Santamaria (@raysan5)
*
*   translated to FreeBASIC by:
*     Copyright (c) 2024 miscdebris (MIT)
*
********************************************************************************************'/

#include "raylib.bi"
#include "datetime.bi"
#include "string.bi"
#include "crt/stdio.bi"

'' Custom logging function
'' see https://freebasic.net/forum/viewtopic.php?t=27194
sub CustomLog cdecl (byval msgType as long, byval fmt as const zstring ptr, byval args as va_list)
  dim as string timeStr
  
  timeStr = format(now(), "yyyy-mm-dd hh:nn:ss")
  print("[" + timeStr + "] ");

  select case msgType
    case LOG_INFO
      print("[INFO] : ");
    case LOG_ERROR
      print("[ERROR]: ");
    case LOG_WARNING
      print("[WARN] : ");
    case LOG_DEBUG:
      print("[DEBUG]: ");
  end select
  
  '' dim as cva_list args
  '' cva_start(args, fmt)
	vprintf(fmt, args)  
  '' cva_end(args)

  print
end sub


'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450


'' Set custom logger
SetTraceLogCallback(@CustomLog)

InitWindow(screenWidth, screenHeight, "raylib-freebasic [core] example - custom logging")

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()    ' Detect window close button or ESC key
  '' Update
  '' TODO: Update your variables here

  '' Draw
  BeginDrawing()

  ClearBackground(RAYWHITE)

  DrawText("Check out the console output to see the custom logger in action!", 60, 200, 20, LIGHTGRAY)

  EndDrawing()
wend

'' De-Initialization
CloseWindow()        ' Close window and OpenGL context
