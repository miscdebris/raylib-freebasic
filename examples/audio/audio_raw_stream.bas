/'*******************************************************************************************
*
*   raylib [audio] example - Raw audio streaming
*
*   This example has been created using raylib 1.6 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Example created by Ramon Santamaria (@raysan5) and reviewed by James Hofmann (@triplefox)
*
*   Copyright (c) 2015-2019 Ramon Santamaria (@raysan5) and James Hofmann (@triplefox)
*
*   translated to FreeBASIC by:
*     Copyright (c) 2021 glasyalabolas (MIT)
*     Copyright (c) 2024 miscdebris (MIT)
*
********************************************************************************************'/

#include "raylib.bi"
#include "crt.bi"        '' Required for: memcpy()

#define MAX_SAMPLES               512
#define MAX_SAMPLES_PER_UPDATE   4096

'' Cycles per second (hz)
dim shared as single frequency = 440.0f

'' Audio frequency, for smoothing
dim shared as single audioFrequency = 440.0f

'' Previous value, used to test if sine needs to be rewritten, and to smoothly modulate frequency
dim shared as single oldFrequency = 1.0f

'' Index for audio rendering
dim shared as single sineIdx = 0.0f

'' Audio input processing callback
sub AudioInputCallback cdecl (byval buffer as any ptr, byval frames as ulong)
  audioFrequency = frequency + (audioFrequency - frequency)*0.95f

  dim as single incr = audioFrequency/44100.0f
  dim as short ptr d = buffer

  for i as ulong = 0 to frames - 1
    d[i] = 32000.0f*sin(2*PI*sineIdx)
    sineIdx += incr
    if sineIdx > 1.0f then sineIdx -= 1.0f
  next
end sub

'' Initialization
const as long _
  screenWidth = 800, screenHeight = 450

InitWindow( screenWidth, screenHeight, "raylib-freebasic [audio] example - raw audio streaming" )

InitAudioDevice()                ' Initialize audio device

SetAudioStreamBufferSizeDefault(MAX_SAMPLES_PER_UPDATE)

'' Init raw audio stream (sample rate: 44100, sample size: 16bit-short, channels: 1-mono)
dim as AudioStream stream = LoadAudioStream( 44100, 16, 1 )

SetAudioStreamCallback(stream, @AudioInputCallback)

'' Buffer for the single cycle waveform we are synthesizing
dim as short ptr data_ = allocate( sizeof( short ) * MAX_SAMPLES )

'' Frame buffer, describing the waveform when repeated over the course of a frame
dim as short ptr writeBuf = allocate( sizeof( short ) * MAX_SAMPLES_PER_UPDATE )

PlayAudioStream( stream )              ' Start processing stream buffer (no data loaded currently)

dim as Vector2 mousePosition = Vector2( -100.0f, -100.0f )        ' Position read in to determine next frequency

'' Computed size in samples of the sine wave
dim as long waveLength = 1

dim as Vector2 position = Vector2( 0, 0 )

SetTargetFPS( 30 )      ' Set our game to run at 30 frames-per-second

'' Main game loop
while not WindowShouldClose()
  '' Update
  '' Sample mouse input.
  mousePosition = GetMousePosition()
  
  if IsMouseButtonDown( MOUSE_LEFT_BUTTON ) then
    dim as single fp = mousePosition.y
    frequency = 40.0f + fp
    
    dim as single pan = mousePosition.x / screenWidth
    SetAudioStreamPan(stream, pan)
  end if
  
  '' Rewrite the sine wave.
  '' Compute two cycles to allow the buffer padding, simplifying any modulation, resampling, etc.
  if frequency <> oldFrequency then
    '' Compute wavelength. Limit size in both directions
    waveLength = 22050 / frequency
    
    if waveLength > MAX_SAMPLES / 2  then waveLength = MAX_SAMPLES / 2
    if waveLength < 1  then waveLength = 1

    '' Write sine wave
    for i as long = 0 to ( waveLength * 2 ) - 1
      data_[i] = sin( ( ( 2 * PI * i / waveLength ) ) ) * 32000
    next i
    
    '' Make sure the rest of the line is flat
    for j as long = waveLength*2 to j < MAX_SAMPLES - 1
        data_[j] = 0
    next j    

    '' Scale read cursor's position to minimize transition artifacts
    oldFrequency = frequency
  end if
  
  '' Draw
  BeginDrawing()
    ClearBackground( RAYWHITE )
    
    DrawText( TextFormat( "sine frequency: %i", cast(long, frequency) ), GetScreenWidth() - 220, 10, 20, RED )
    DrawText( "click mouse button to change frequency", 10, 10, 20, DARKGRAY )
    
    '' Draw the current buffer state proportionate to the screen
    for i as long = 0 to screenWidth - 1
      position.x = i
      position.y = 250 + 50 * data_[ i * MAX_SAMPLES / screenWidth ] / 32000
      
      DrawPixelV( position, RED )
    next
  EndDrawing()
wend

'' De-Initialization
deallocate( data_ )          ' Unload sine wave data
deallocate( writeBuf )       ' Unload write buffer

UnloadAudioStream(stream)    ' Close raw audio stream and delete buffers from RAM
CloseAudioDevice()           ' Close audio device (music streaming is automatically stopped)

CloseWindow()                ' Close window and OpenGL context
