/'*******************************************************************************************
*
*   raylib [core] example - 2d camera mouse zoom
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022-2024 Jeffery Myers (@JeffM2501)
*
*   translated to FreeBASIC by:
*     Copyright (c) 2024 miscdebris (MIT)
*
********************************************************************************************'/

#include "raylib.bi"

#include "rlgl.bi"
#include "raymath.bi"

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450


InitWindow(screenWidth, screenHeight, "raylib-freebasic [core] example - 2d camera mouse zoom")

dim as Camera2D camera
camera.zoom = 1.0f

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()        ' Detect window close button or ESC key
  '' Update
  '' Translate based on mouse right click
  if IsMouseButtonDown(MOUSE_BUTTON_RIGHT) then
    dim as Vector2 delta = GetMouseDelta()
    delta = Vector2Scale(delta, -1.0f/camera.zoom)

    camera.target = Vector2Add(camera.target, delta)
  end if

  '' Zoom based on mouse wheel
  dim as single wheel = GetMouseWheelMove()
  if wheel <> 0 then
    '' Get the world point that is under the mouse
    dim as Vector2 mouseWorldPos = GetScreenToWorld2D(GetMousePosition(), camera)
    
    '' Set the offset to where the mouse is
    camera.offset = GetMousePosition()

    '' Set the target to match, so that the camera maps the world space point 
    '' under the cursor to the screen space point under the cursor at any zoom
    camera.target = mouseWorldPos

    '' Zoom increment
    const as single zoomIncrement = 0.125f
    
    camera.zoom += wheel*zoomIncrement
    if camera.zoom < zoomIncrement then camera.zoom = zoomIncrement
  end if

  '' Draw
  BeginDrawing()
    ClearBackground(BLACK)

    BeginMode2D(camera)

      '' Draw the 3d grid, rotated 90 degrees and centered around 0,0 
      '' just so we have something in the XY plane
      rlPushMatrix()
        rlTranslatef(0, 25*50, 0)
        rlRotatef(90, 1, 0, 0)
        DrawGrid(100, 50)
      rlPopMatrix()

      '' Draw a reference circle
      DrawCircle(100, 100, 50, YELLOW)
      
    EndMode2D()

    DrawText("Mouse right button drag to move, mouse wheel to zoom", 10, 10, 20, WHITE)

  EndDrawing()
wend

'' De-Initialization
CloseWindow()        ' Close window and OpenGL context
