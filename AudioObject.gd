extends AudioStreamPlayer2D


func PlaySound(audiostream):
	stream = audiostream
	play()
	yield(self, "finished")
	queue_free()
