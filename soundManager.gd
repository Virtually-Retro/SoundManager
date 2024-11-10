#----------------------------------------------------
# MP3 Simple SoundManager by Ryn (c) 2024 Version 1.3
# MIT License
#----------------------------------------------------
extends Node


@onready var soundNodeNames: Array[String] = []
@onready var soundDefaultVolume: float = 0.5
@onready var soundFilesPath: String = "res://sounds/" # Change path to suit 
@onready var soundGroupName: String = "sounds" # Change group to suit


# Adds a sound stream to the database check for prior existance
# and loading if required.
func add_sound(filename: String) -> int: # Returns the unique ID of the loaded sound -1 is an error
	filename = filename.to_lower()
	if not filename.ends_with("mp3"): # Check for MP3 extension
		return -1 # You should check for -1 return as an error
	
	var soundNodeName: String = filename.replacen(".","_")
	if soundNodeNames.find(soundNodeName) > -1:  # Stops loading multiples of same file
		return soundNodeNames.find(soundNodeName) # Returns the ID of existing loaded file
	
	var soundNode: AudioStreamPlayer = AudioStreamPlayer.new()
	soundNode.stream = _load_mp3_audio_stream(filename);
	if soundNode.stream != null: # check for no valid MP3 data
		soundNode.name = soundNodeName
		soundNode.volume_db = linear_to_db(soundDefaultVolume)
		soundNode.add_to_group(soundGroupName, true)
		soundNodeNames.append(soundNodeName)
		add_child(soundNode)
		return soundNodeNames.size() - 1
	else:
		return -1 # You should check for -1 return as an error


# For clearing all streams and the database when needed
func clear_all_sounds() -> void:
	if is_inside_tree(): get_tree().call_group(soundGroupName, "queue_free")
	soundNodeNames.clear()


# For playing an audio file by name.  If the stream is not loaded
# it will load and play the sound, you should use the ID from that
# point onward.  This function is useful so all streams can be loaded
# as needed.
func play_sound_by_name(filename: String, pitch_shift: bool) -> void:
	var soundID: int = get_sound_id_by_name(filename)
	if soundID > -1: # Sound Stream found
		play_sound(soundID, pitch_shift)
	else: # Sound stream not loaded
		soundID = add_sound(filename)
		if soundID > -1:
			play_sound(soundID, pitch_shift)


# For returning the unique ID of a loaded Sound
# Improved using array search method
func get_sound_id_by_name(filename: String) -> int:
	var soundNodeName: String = filename.to_lower().replacen(".","_")
	return soundNodeNames.find(soundNodeName)


# For getting the play status of a loaded stream
func get_sound_status(soundID: int) -> int:
	if soundID not in range(soundNodeNames.size()): return -1
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null:
		if soundNode.playing: return 1
		if soundNode.stream_paused: return 2
		if not soundNode.playing : return 0
		return -1
	else:
		return -1


# Play a loaded stream with a given ID, note the pitch shift
# and additional functions if the stream is playing or paused
func play_sound(soundID: int, pitch_shift: bool) -> void:
	if soundID not in range(soundNodeNames.size()): return
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null: 
		if soundNode.playing: 
			soundNode.stream_paused = true
			return
		if soundNode.stream_paused:
			soundNode.stream_paused = false
			return
		if pitch_shift:
			soundNode.pitch_scale = randf_range(0.8, 1.2)
			soundNode.play()
		else:
			soundNode.pitch_scale = 1
			soundNode.play()


# Used to set the  volume level of all loaded streams.
# Also corrects and adjusts the volume level to linear DB
func set_volume(vol_level: int) -> void:
	# Check / Correct / Calc volume for liner_to_db
	if vol_level not in range(0,101):
		vol_level = 50
	soundDefaultVolume = 0.01 * vol_level
	# Set volume or all audio nodes
	for i: int in soundNodeNames.size():
		var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[i])
		if soundNode != null:
			soundNode.volume_db = linear_to_db(soundDefaultVolume)


# Stops a loaded audio stream from playing
func stop_sound(soundID: int) -> void:
	if soundID not in range(soundNodeNames.size()): return
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null: 
		soundNode.stop()


# Pauses a loaded audio stream
func pause_sound(soundID: int) -> void:
	if soundID not in range(soundNodeNames.size()): return
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null: 
		soundNode.stream_paused = true


# Resumes playing a loaded audio stream
func resume_sound(soundID: int) -> void:
	if soundID not in range(soundNodeNames.size()): return
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null: 
		soundNode.stream_paused = false


# Load the MP3 audio stream data, only used internaly.
func _load_mp3_audio_stream(filename: String) -> AudioStream:
	var file: Object = FileAccess.open(soundFilesPath + filename, FileAccess.READ)
	if file != null: # Check for valid file
		if file.get_length() == 0: # Check for data
			return null
		else:
			var sounddata: AudioStream = AudioStreamMP3.new()
			sounddata.data = file.get_buffer(file.get_length())
			return sounddata
	else:
		return null
