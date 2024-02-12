/'*******************************************************************************************
*
*   raylib [core] example - Scissor test
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.0
*
*   Example contributed by Chris Dill (@MysteriousSpace) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Chris Dill (@MysteriousSpace)
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

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - scissor test" )

var scissorArea = Rectangle( 0, 0, 300, 300 )
dim as boolean scissorMode = true

SetTargetFPS( 60 )      ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()    ' Detect window close button or ESC key
  '' Update
  if IsKeyPressed( KEY_S ) then scissorMode = not scissorMode 

  '' Centre the scissor area around the mouse position
  scissorArea.x = GetMouseX() - scissorArea.width_ / 2
  scissorArea.y = GetMouseY() - scissorArea.height_ / 2

  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    if( scissorMode ) then
      BeginScissorMode( scissorArea.x, scissorArea.y, scissorArea.width_, scissorArea.height_ )
    end if
    
    '' Draw full screen rectangle and some text
    '' NOTE: Only part defined by scissor area will be rendered
    DrawRectangle( 0, 0, GetScreenWidth(), GetScreenHeight(), RED )
    DrawText( "Move the mouse around to reveal this text!", 190, 200, 20, LIGHTGRAY )
    
    if( scissorMode ) then EndScissorMode()
    
    DrawRectangleLinesEx( scissorArea, 1, BLACK )
    DrawText( "Press S to toggle scissor test", 10, 10, 20, BLACK )
  EndDrawing()
wend

'' De-Initialization
CloseWindow()     ' Close window and OpenGL context
