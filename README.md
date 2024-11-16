# Godot 4.x Simple MP3 SoundManager
### Version 1.7.3

# Usage

Load as a global/singleton, and update the path and groups as needed.

# Functions

    func play_sound_by_name(filename: String, pitch_shift: bool) -> void:
    func play_sound(soundID: int, pitch_shift: bool) -> void:
    func stop_sound_by_name(filename: String) -> void:
    func stop_sound(soundID: int) -> void:
    func pause_sound_by_name(filename: String) -> void:
    func pause_sound(soundID: int) -> void:
    func resume_sound_by_name(filename: String) -> void:
    func resume_sound(soundID: int) -> void:
    func set_sound_enabled(enabled_state: bool) -> void:
    func stop_all_sounds() -> void:
    func set_volume(vol_level: int) -> void:
    func set_sound_autopause(enabled_state: bool) -> void:
    func set_sound_allow_polyphony(enabled_state: bool) -> void:
    func set_sound_max_polyphony(polyphony_max: int) -> void:
    func add_sound(filename: String) -> int:
    func clear_all_sounds() -> void:
    func get_sound_id_by_name(filename: String) -> int:
    func get_sound_status_by_name(filename: String) -> int:
    func get_sound_status(soundID: int) -> int:
    func _load_mp3_audio_stream(filename: String) -> AudioStream:

# Globals

    @onready var soundNodeNames: Array[String] = []
    @onready var soundDefaultVolume: float = 0.5
    @onready var soundEnabled: bool = true
    @onready var soundAutoPause: bool = false
    @onready var soundAllowPolyphony: bool = false
    @onready var soundMaxPolyphony: int = 2
    @onready var soundFilesPath: String = "res://Audio/" # Change if needed
    @onready var soundGroupName: String = "sounds" # Change if needed

# Notes

    Sounds are persistant between scenes once loaded.
    'by_name' Functions use the internal functions to get the sound ID
    _load_mp3_audio_stream is an internal fuction called by add_sound
