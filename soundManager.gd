#----------------------------------------------------
# MP3 Simple SoundManager by Ryn (c) 2024 Version 1.1
# MIT License
#----------------------------------------------------
extends Node


@onready var soundNodeNames: Array[String] = []
@onready var soundFilesPath: String = "res://sounds/" # Change path to suit 
@onready var groupName: String = "sounds" # Change group to suit


func add_sound(filename: String) -> int: # Returns the unique ID of the loaded sound -1 is an error
	filename = filename.to_lower()
	if not filename.ends_with("mp3"): # Check for MP3 extension
		return -1 # You should check for -1 return as an error
	
	var soundNodeName: String = filename.replacen(".","_")
	if soundNodeNames.find(soundNodeName) > -1:  # Stops loading multiples of same file
		return soundNodeNames.find(soundNodeName) # Returns the ID of existing loaded file
	
	var soundNode: AudioStreamPlayer = AudioStreamPlayer.new()
	soundNode.stream = load_mp3(filename);
	if soundNode.stream != null: # check for no valid MP3 data
		soundNode.name = soundNodeName
		soundNode.add_to_group(groupName, true)
		soundNodeNames.append(soundNodeName)
		add_child(soundNode)
		return soundNodeNames.size() - 1
	else:
		return -1 # You should check for -1 return as an error


func clear_all_sounds() -> void: # For clearing all sound when needed
	if is_inside_tree(): get_tree().call_group(groupName, "queue_free")
	soundNodeNames.clear()


func get_sound_id_by_name(filename: String) -> int:
	filename = filename.to_lower().replacen(".","_")
	for i: int in range(soundNodeNames.size()):
		if soundNodeNames[i] == filename:
			return i
	return -1


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


func set_volume(vol_level: int) -> void:
	# Check / Correct / Calc volume for liner_to_db
	if vol_level < 0: vol_level = 0
	if vol_level > 100: vol_level = 100
	var set_vol_level: float = 0.01 * vol_level
	# Set volume or all audio nodes
	for i: int in soundNodeNames.size():
		var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[i])
		if soundNode != null:
			soundNode.volume_db = linear_to_db(set_vol_level)


func stop_sound(soundID: int) -> void:
	if soundID not in range(soundNodeNames.size()): return
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null: 
		soundNode.stop()


func pause_sound(soundID: int) -> void:
	if soundID not in range(soundNodeNames.size()): return
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null: 
		soundNode.stream_paused = true


func resume_sound(soundID: int) -> void:
	if soundID not in range(soundNodeNames.size()): return
	var soundNode: AudioStreamPlayer = get_node_or_null(soundNodeNames[soundID])
	if soundNode != null: 
		soundNode.stream_paused = false


func load_mp3(filename: String) -> AudioStream:
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
