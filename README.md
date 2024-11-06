# Godot 4.x Simple MP3 SoundManager
### Version 1.2

# Usage

Load as a global/singleton, and update the path and groups as needed.

# Methods / Functions

add_sound( filename: String ) -> int:

    Adds a file into the manager - returns the unique ID of the loaded file.
    Returns -1 if there was any error loading the audio stream.

play_sound( ID: Int , Pitch_Shift: Bool ) -> void:

    Plays a sound with the given ID.
    Pitch_Shift adds a small random shift in the pitch to add variance.
    play_sound will pause the sound if already playing and unpause if paused

stop_sound( ID: Int ) -> void:

    Stops a sound playing with the given ID.

pause_sound( ID: Int ) -> void:

    Pause a sound with a given ID.

resume_sound( ID: Int ) -> void:

    Resume a sound with a given ID.

clear_all_sounds() -> void:

    Clears the sound manager database.

_load_mp3_audio_stream( filename: String ) -> AudioStream

    Used by the add_sound function, should not be called externally.
    Returns NULL if the audio stream could not be loaded.

set_volume( Volume: Int ) -> void:

    Sets the volume of all audio streams. 0-100

get_sound_id_by_name( filename: String ) -> int:

    Returns the unique ID of the loaded sound.
    Returns -1 if the filename was not found

get_sound_status( ID: Int ) -> Int:

    Used to get the status of the audio stream.
    -1 = Error, reading stream or stream not found
    0 = Stopped
    1 = Playing
    2 = Paused

play_sound_by_name( filename: String, pitch_shift: bool ) -> void:
    
    Gets the ID of the stream and loads if not found, uses the internal load and play methods.

# Notes

Loaded sounds are persistant across scenes when changed.
