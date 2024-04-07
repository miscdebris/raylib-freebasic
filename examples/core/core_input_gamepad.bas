/'*******************************************************************************************
*
*   raylib [core] example - Gamepad input
*
*   NOTE: This example requires a Gamepad connected to the system
*         raylib is configured to work with the following gamepads:
*                - Xbox 360 Controller (Xbox 360, Xbox One)
*                - PLAYSTATION(R)3 Controller
*         Check raylib.h for buttons configuration
*
*   Example originally created with raylib 1.1, last time updated with raylib 4.2
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

'' NOTE: Gamepad name ID depends on drivers and OS
#define XBOX360_LEGACY_NAME_ID  "Xbox Controller"
#define XBOX360_NAME_ID     "Xbox 360 Controller"
#define PS3_NAME_ID         "PLAYSTATION(R)3 Controller"

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450

SetConfigFlags( FLAG_MSAA_4X_HINT )      ' Set MSAA 4X hint before windows creation

InitWindow( screenWidth, screenHeight, "raylib-freebasic [core] example - gamepad input" )

dim as Texture2D _
  texPs3Pad = LoadTexture( "resources/ps3.png" ), _
  texXboxPad = LoadTexture( "resources/xbox.png" )

SetTargetFPS( 60 )         ' Set our game to run at 60 frames-per-second

dim as long gamepad = 0         ' which gamepad to display

'' Main game loop
while not WindowShouldClose()     ' Detect window close button or ESC key
  '' Update
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    if IsKeyPressed(KEY_LEFT) and gamepad > 0 then gamepad = gamepad - 1
    if IsKeyPressed(KEY_RIGHT) then gamepad = gamepad + 1
    
    
    if IsGamepadAvailable(gamepad) then
      DrawText( TextFormat( "GP1: %s", GetGamepadName(gamepad) ), 10, 10, 10, BLACK )
      
      if true then
        DrawTexture( texXboxPad, 0, 0, DARKGRAY )
        
        '' Draw buttons: xbox home
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_MIDDLE ) then DrawCircle( 394, 89, 19, RED )
        
        '' Draw buttons: basic
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_MIDDLE_RIGHT) then DrawCircle( 436, 150, 9, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_MIDDLE_LEFT) then DrawCircle( 352, 150, 9, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_LEFT) then DrawCircle( 501, 151, 15, BLUE )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_DOWN) then DrawCircle( 536, 187, 15, LIME )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_RIGHT) then DrawCircle( 572, 151, 15, MAROON )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_UP) then DrawCircle( 536, 115, 15, GOLD )
        
        '' Draw buttons: d-pad
        DrawRectangle( 317, 202, 19, 71, BLACK )
        DrawRectangle( 293, 228, 69, 19, BLACK )
        
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_UP) then DrawRectangle( 317, 202, 19, 26, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_DOWN) then DrawRectangle( 317, 202 + 45, 19, 26, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_LEFT) then DrawRectangle( 292, 228, 25, 19, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_RIGHT) then DrawRectangle( 292 + 44, 228, 26, 19, RED )
        
        '' Draw buttons: left-right back
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_TRIGGER_1) then DrawCircle( 259, 61, 20, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_TRIGGER_1) then DrawCircle( 536, 61, 20, RED )
        
        '' Draw axis: left joystick
        dim as RLColor leftGamepadColor = BLACK
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_THUMB) then leftGamepadColor = RED
        DrawCircle( 259, 152, 39, BLACK )
        DrawCircle( 259, 152, 34, LIGHTGRAY )
        DrawCircle( 259 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_LEFT_X ) * 20 ), _
                    152 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_LEFT_Y ) * 20 ), 25, leftGamepadColor )
        
        '' Draw axis: right joystick
        dim as RLColor rightGamepadColor = BLACK
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_THUMB) then rightGamepadColor = RED
        DrawCircle( 461, 237, 38, BLACK )
        DrawCircle( 461, 237, 33, LIGHTGRAY )
        DrawCircle( 461 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_RIGHT_X ) * 20 ), _
                    237 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_RIGHT_Y ) * 20 ), 25, rightGamepadColor )
        
        '' Draw axis: left-right triggers
        DrawRectangle( 170, 30, 15, 70, GRAY )
        DrawRectangle( 604, 30, 15, 70, GRAY )
        DrawRectangle( 170, 30, 15, ( ( ( 1.0f + GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_LEFT_TRIGGER ) ) / 2.0f ) * 70 ), RED )
        DrawRectangle( 604, 30, 15, ( ( ( 1.0f + GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_RIGHT_TRIGGER ) ) / 2.0f ) * 70 ), RED )
      elseif TextIsEqual(GetGamepadName(gamepad), PS3_NAME_ID) then
        DrawTexture( texPs3Pad, 0, 0, DARKGRAY )
        
        '' Draw buttons: ps
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_MIDDLE) then DrawCircle(396, 222, 13, RED )
        
        '' Draw buttons: basic
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_MIDDLE_LEFT) then DrawRectangle( 328, 170, 32, 13, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_MIDDLE_RIGHT) then DrawTriangle( Vector2( 436, 168 ), Vector2( 436, 185 ), Vector2( 464, 177 ), RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_UP) then DrawCircle( 557, 144, 13, LIME )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_RIGHT) then DrawCircle( 586, 173, 13, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_DOWN) then DrawCircle( 557, 203, 13, VIOLET )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_FACE_LEFT) then DrawCircle( 527, 173, 13, PINK )
        
        '' Draw buttons: d-pad
        DrawRectangle( 225, 132, 24, 84, BLACK )
        DrawRectangle( 195, 161, 84, 25, BLACK )
        
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_UP) then DrawRectangle( 225, 132, 24, 29, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_DOWN) then DrawRectangle( 225, 132 + 54, 24, 30, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_LEFT) then DrawRectangle( 195, 161, 30, 25, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_FACE_RIGHT) then DrawRectangle( 195 + 54, 161, 30, 25, RED )
        
        '' Draw buttons: left-right back buttons
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_TRIGGER_1) then DrawCircle( 239, 82, 20, RED )
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_TRIGGER_1) then DrawCircle( 557, 82, 20, RED )
        
        '' Draw axis: left joystick
        dim as RLColor leftGamepadColor = BLACK
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_LEFT_THUMB) then leftGamepadColor = RED
        DrawCircle( 319, 255, 35, BLACK )
        DrawCircle( 319, 255, 31, LIGHTGRAY )
        DrawCircle( 319 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_LEFT_X ) * 20 ), _
                    255 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_LEFT_Y ) * 20 ), 25, leftGamepadColor )
        
        '' Draw axis: right joystick
        dim as RLColor rightGamepadColor = BLACK
        if IsGamepadButtonDown(gamepad, GAMEPAD_BUTTON_RIGHT_THUMB) then rightGamepadColor = RED
        DrawCircle( 475, 255, 35, BLACK )
        DrawCircle( 475, 255, 31, LIGHTGRAY )
        DrawCircle( 475 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_RIGHT_X ) * 20 ), _
                    255 + ( GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_RIGHT_Y ) * 20 ), 25, rightGamepadColor )
        
        '' Draw axis: left-right triggers
        DrawRectangle( 169, 48, 15, 70, GRAY )
        DrawRectangle( 611, 48, 15, 70, GRAY )
        DrawRectangle( 169, 48, 15, ( ( ( 1.0f - GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_LEFT_TRIGGER ) ) / 2.0f ) * 70 ), RED )
        DrawRectangle( 611, 48, 15, ( ( ( 1.0f - GetGamepadAxisMovement(gamepad, GAMEPAD_AXIS_RIGHT_TRIGGER ) ) / 2.0f ) * 70 ), RED )
      else
        DrawText( "- GENERIC GAMEPAD -", 280, 180, 20, GRAY )
        '' TODO: Draw generic gamepad
      end if
      
      DrawText( TextFormat( "DETECTED AXIS [%i]:", GetGamepadAxisCount(0) ), 10, 50, 10, MAROON )
      
      for i as integer = 0 to GetGamepadAxisCount(0) - 1
        DrawText( TextFormat( "AXIS %i: %.02f", i, GetGamepadAxisMovement(0, i ) ), 20, 70 + 20 * i, 10, DARKGRAY )
      next

      if GetGamepadButtonPressed() <> GAMEPAD_BUTTON_UNKNOWN then
        DrawText( TextFormat( "DETECTED BUTTON: %i", GetGamepadButtonPressed() ), 10, 430, 10, RED )
      else
        DrawText( "DETECTED BUTTON: NONE", 10, 430, 10, GRAY )
      end if
    else
      DrawText(TextFormat("GP%d: NOT DETECTED", gamepad), 10, 10, 10, GRAY )
      DrawTexture( texXboxPad, 0, 0, LIGHTGRAY )
    end if
  EndDrawing()
wend

'' De-Initialization
UnloadTexture( texPs3Pad )
UnloadTexture( texXboxPad )

CloseWindow()            ' Close window and OpenGL context
