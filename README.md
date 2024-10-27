# Godot 4.x Simple MP3 SoundManager

## Usage

Load as a global/singleton, and update the path and groups as needed.

## Methods / Functions

add_sound( filename ) - Adds a file into the manager - returns the unique ID of the loaded file.

play_sound( ID ) - Plays a sound with the given ID.

stop_sound( ID ) - Stops a sound playing with the given ID.

pause_sound( ID ) - Pause a sound with a given ID.

resume_sound( ID ) - Resume a sound with a given ID.

clear_all_sounds() - Clears the sound manager database.

load_mp3( filename ) - used by the add_sound function.

## Notes

Loaded sounds are persistant across scenes when changed.
