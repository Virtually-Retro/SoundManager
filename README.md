# Godot 4.x Simple MP3 SoundManager
### Version 1.4

# Usage

Load as a global/singleton, and update the path and groups as needed.

# Methods / Functions

    func play_sound_by_name(filename: String, pitch_shift: bool) -> void:
    func play_sound(soundID: int, pitch_shift: bool) -> void:
    func stop_sound_by_name(filename: String) -> void:
    func stop_sound(soundID: int) -> void:
    func pause_sound_by_name(filename: String) -> void:
    func pause_sound(soundID: int) -> void:
    func resume_sound_by_name(filename: String) -> void:
    func resume_sound(soundID: int) -> void:
    func set_volume(vol_level: int) -> void:
    func add_sound(filename: String) -> int: # Returns the unique ID of the loaded sound -1 is an error
    func clear_all_sounds() -> void:
    func get_sound_id_by_name(filename: String) -> int:
    func get_sound_status_by_name(filename: String) -> int:
    func get_sound_status(soundID: int) -> int:
    func _load_mp3_audio_stream(filename: String) -> AudioStream:

# Methods / Functions

    Sounds are persistant between scenes once loaded.
