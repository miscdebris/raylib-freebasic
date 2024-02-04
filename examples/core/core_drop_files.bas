/'*******************************************************************************************
*
*   raylib [core] example - Windows drop files
*
*   NOTE: This example only works on platforms that support drag & drop (Windows, Linux, OSX, Html5?)
*
*   Example originally created with raylib 1.3, last time updated with raylib 4.2
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

#define MAX_FILEPATH_RECORDED   4096
#define MAX_FILEPATH_SIZE       2048

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - drop files" )

  dim as long filePathCounter = 0
  dim as zstring ptr filePaths(MAX_FILEPATH_RECORDED-1)   ' We will register a maximum of filepaths

  '' Allocate space for the required file paths
  for i as long = 0 to MAX_FILEPATH_RECORDED-1
    filePaths(i) = allocate(MAX_FILEPATH_SIZE)
  next i

SetTargetFPS( 60 )             ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()    ' Detect window close button or ESC key
  '' Update
  if IsFileDropped() then
    var droppedFiles = LoadDroppedFiles()

    dim as long offset = filePathCounter
    for i as long = 0 to droppedFiles.count-1
      if filePathCounter < MAX_FILEPATH_RECORDED - 1 then
          TextCopy(filePaths(offset + i), droppedFiles.paths[i])
          filePathCounter+=1
      end if
    next i

    UnloadDroppedFiles(droppedFiles)    ' Unload filepaths from memory    
  end if
  
  '' Draw
  BeginDrawing()
    ClearBackground(RAYWHITE)
    
    if filePathCounter = 0 then
      DrawText( "Drop your files to this window!", 100, 40, 20, DARKGRAY )
    else
      DrawText( "Dropped files:", 100, 40, 20, DARKGRAY )
      
      for i as long = 0 to filePathCounter - 1
        if i mod 2 = 0 then
          DrawRectangle( 0, 85 + 40 * i, screenWidth, 40, Fade( LIGHTGRAY, 0.5f ) )
        else
          DrawRectangle( 0, 85 + 40 * i, screenWidth, 40, Fade( LIGHTGRAY, 0.3f ) )
        end if
        
        DrawText( filePaths(i), 120, 100 + 40 * i, 10, GRAY )
      next
      
      DrawText( "Drop new files...", 100, 110 + 40 * filePathCounter, 20, DARKGRAY )
    end if
  EndDrawing()
wend

'' De-Initialization
for i as long = 0 to MAX_FILEPATH_RECORDED-1
  deallocate(filePaths(i))    ' Free allocated memory for all filepaths
next i

CloseWindow()       ' Close window and OpenGL context
