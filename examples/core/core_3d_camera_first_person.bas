/'*******************************************************************************************
*
*   raylib [core] example - 3d camera first person
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
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

#include once "raylib.bi"

#define MAX_COLUMNS 20

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib-freelib [core] example - 3d camera first person")

'' Define the camera to look into our 3d world (position, target, up vector)
dim as Camera cam

with cam
  .position = Vector3( 0.0f, 2.0f, 4.0f )  ' Camera position
  .target = Vector3( 0.0f, 2.0f, 0.0f )    ' Camera looking at point
  .up = Vector3( 0.0f, 1.0f, 0.0f )        ' Camera up vector (rotation towards target)
  .fovy = 60.0f                            ' Camera field-of-view Y
  .projection = CAMERA_PERSPECTIVE         ' Camera projection type
end with

dim as long cameraMode = CAMERA_FIRST_PERSON

'' Generates some random columns
dim as single heights( 0 to MAX_COLUMNS - 1 )
dim as vector3 positions( 0 to MAX_COLUMNS - 1 )
dim as rlcolor colors( 0 to MAX_COLUMNS - 1 )

for i as integer = 0 to MAX_COLUMNS - 1
  heights( i ) = GetRandomValue( 1, 12 )
  positions( i ) = Vector3( GetRandomValue( -15, 15 ), heights( i ) / 2.0f, GetRandomValue( -15, 15 ) )
  colors( i ) = rlcolor( GetRandomValue( 20, 255 ), GetRandomValue( 10, 55 ), 30, 255 )
next i

DisableCursor()                   ' Limit cursor to relative movement inside the window

SetTargetFPS( 60 )                ' Set our game to run at 60 frames-per-second

'' Main game loop
while not WindowShouldClose()     ' Detect window close button or ESC key
  '' Update

  '' Switch camera mode
  if IsKeyPressed(KEY_ONE) then
      cameraMode = CAMERA_FREE
      cam.up = Vector3( 0.0f, 1.0f, 0.0f ) ' Reset roll
  end if

  if IsKeyPressed(KEY_TWO) then
      cameraMode = CAMERA_FIRST_PERSON
      cam.up = Vector3( 0.0f, 1.0f, 0.0f ) ' Reset roll
  end if

  if IsKeyPressed(KEY_THREE) then
      cameraMode = CAMERA_THIRD_PERSON
      cam.up = Vector3( 0.0f, 1.0f, 0.0f ) ' Reset roll
  end if

  if IsKeyPressed(KEY_FOUR) then
      cameraMode = CAMERA_ORBITAL
      cam.up = Vector3( 0.0f, 1.0f, 0.0f ) ' Reset roll
  end if

  '' Switch camera projection
  if IsKeyPressed(KEY_P) then
    if cam.projection = CAMERA_PERSPECTIVE then
      '' Create isometric view
      cameraMode = CAMERA_THIRD_PERSON
      '' Note: The target distance is related to the render distance in the orthographic projection
      cam.position = Vector3( 0.0f, 2.0f, -100.0f )
      cam.target = Vector3( 0.0f, 2.0f, 0.0f )
      cam.up = Vector3( 0.0f, 1.0f, 0.0f )
      cam.projection = CAMERA_ORTHOGRAPHIC
      cam.fovy = 20.0f  ' near plane width in CAMERA_ORTHOGRAPHIC
      CameraYaw(@cam, -135 * DEG2RAD, true)
      CameraPitch(@cam, -45 * DEG2RAD, true, true, false)
    elseif cam.projection = CAMERA_ORTHOGRAPHIC then
      '' Reset to default view
      cameraMode = CAMERA_THIRD_PERSON
      cam.position = Vector3( 0.0f, 2.0f, 10.0f )
      cam.target = Vector3( 0.0f, 2.0f, 0.0f )
      cam.up = Vector3( 0.0f, 1.0f, 0.0f )
      cam.projection = CAMERA_PERSPECTIVE
      cam.fovy = 60.0f
    end if
  end if

  '' Update camera computes movement internally depending on the camera mode
  '' Some default standard keyboard/mouse inputs are hardcoded to simplify use
  '' For advance camera controls, it's reecommended to compute camera movement manuallyUpdate
  UpdateCamera( @cam, cameraMode )          ' Update camera
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    BeginMode3D( cam )
      DrawPlane( Vector3( 0.0f, 0.0f, 0.0f ), Vector2( 32.0f, 32.0f ), LIGHTGRAY ) '' Draw ground
      DrawCube( Vector3( -16.0f, 2.5f, 0.0f ), 1.0f, 5.0f, 32.0f, BLUE )     '' Draw a blue wall
      DrawCube( Vector3( 16.0f, 2.5f, 0.0f ), 1.0f, 5.0f, 32.0f, LIME )      '' Draw a green wall
      DrawCube( Vector3( 0.0f, 2.5f, 16.0f ), 32.0f, 5.0f, 1.0f, GOLD )      '' Draw a yellow wall
      
      '' Draw some cubes around
      for i as integer = 0 to MAX_COLUMNS - 1
        DrawCube( positions( i ), 2.0f, heights( i ), 2.0f, colors( i ) )
        DrawCubeWires( positions( i ), 2.0f, heights( i ), 2.0f, MAROON )
      next i
      
      '' Draw player cube
      if cameraMode = CAMERA_THIRD_PERSON then
          DrawCube(cam.target, 0.5f, 0.5f, 0.5f, PURPLE)
          DrawCubeWires(cam.target, 0.5f, 0.5f, 0.5f, DARKPURPLE)
      end if      
    EndMode3D()
    
    DrawRectangle( 5, 5, 330, 100, Fade( SKYBLUE, 0.5f ) )
    DrawRectangleLines( 5, 5, 330, 100, BLUE )
    
    DrawText("Camera controls:", 15, 15, 10, BLACK)
    DrawText("- Move keys: W, A, S, D, Space, Left-Ctrl", 15, 30, 10, BLACK)
    DrawText("- Look around: arrow keys or mouse", 15, 45, 10, BLACK)
    DrawText("- Camera mode keys: 1, 2, 3, 4", 15, 60, 10, BLACK)
    DrawText("- Zoom keys: num-plus, num-minus or mouse scroll", 15, 75, 10, BLACK)
    DrawText("- Camera projection key: P", 15, 90, 10, BLACK)

    DrawRectangle(600, 5, 195, 100, Fade(SKYBLUE, 0.5f))
    DrawRectangleLines(600, 5, 195, 100, BLUE)

    DrawText("Camera status:", 610, 15, 10, BLACK)
    DrawText(TextFormat("- Mode: %s", iif(cameraMode = CAMERA_FREE, "FREE", _
                                          iif(cameraMode = CAMERA_FIRST_PERSON, "FIRST_PERSON", _
                                              iif(cameraMode = CAMERA_THIRD_PERSON, "THIRD_PERSON", _
                                                  iif(cameraMode = CAMERA_ORBITAL, "ORBITAL", "CUSTOM"))))), 610, 30, 10, BLACK)
    DrawText(TextFormat("- Projection: %s", iif(cam.projection = CAMERA_PERSPECTIVE, "PERSPECTIVE", _
                                                iif(cam.projection = CAMERA_ORTHOGRAPHIC, "ORTHOGRAPHIC", "CUSTOM"))), 610, 45, 10, BLACK)
    DrawText(TextFormat("- Position: (%06.3f, %06.3f, %06.3f)", cam.position.x, cam.position.y, cam.position.z), 610, 60, 10, BLACK)
    DrawText(TextFormat("- Target: (%06.3f, %06.3f, %06.3f)", cam.target.x, cam.target.y, cam.target.z), 610, 75, 10, BLACK)
    DrawText(TextFormat("- Up: (%06.3f, %06.3f, %06.3f)", cam.up.x, cam.up.y, cam.up.z), 610, 90, 10, BLACK)
  EndDrawing()
wend

'' De-Initialization
CloseWindow()        ' Close window and OpenGL context
