extends AudioStreamPlayer

var files = []
var songCache = []
var playlistPosition = 0
var autoPlay = true

func _ready() -> void:
	files = getMusic()
	songCache = cacheSongs()
	#playMusic(songCache[playlistPosition])
	pass
func cacheSongs():
	var Cache = []
	for i in range(files.size()):
		Cache.append(load("res://Audio/Songs/"+files[i]))
		pass
	return Cache
	
func getMusic():
	var files = []
	var dir = Directory.new()
	dir.open("res://Audio/Songs/")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if ".wav" in file && !".import" in file:
				files.append(file)
	dir.list_dir_end()
	return files
	pass

func playMusic(song):
	self.stream=song
	self.play(0)
	self.volume_db = -28
	autoPlay = true
	pass

func nextSong():
	autoPlay = false
	playlistPosition += 1
	playMusic(songCache[playlistPosition])
	pass

func previousSong():
	autoPlay = false
	playlistPosition -= 1
	playMusic(songCache[playlistPosition])
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right") && playlistPosition < songCache.size():
		nextSong()
		pass
	if Input.is_action_just_pressed("ui_left") && playlistPosition > 0:
		previousSong()
		pass
	pass

func _on_MusicManager_finished() -> void:
	if autoPlay:
		nextSong()
		pass
	pass
