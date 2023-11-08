extends AudioStreamPlayer2D

var song: int = 1

func get_song():
	return load("res://assets/music/FU/FU%d.mp3" % song)

func _on_finished():
	self.stream = get_song()
	self.play()
	
func _song_go_up():
	song = min(song + 1, 5)
	return song
	
func _song_go_down():
	song = max(song - 1, 1)
	return song

func queue_song(requested):
	song = requested
	return song
