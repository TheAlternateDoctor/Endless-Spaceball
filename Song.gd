extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (AudioStream) var loop
export (AudioStream) var start
export (AudioStream) var fail

var song:AudioStreamSample = AudioStreamSample.new()
var tempo:float = 105
var step:float = 60*1000/tempo

var start_time
var songPos = 0
var firstLoop = true
var customSong = false

signal newLoop

# Called when the node enters the scene tree for the first time.
func _ready():
	var tempoFile = File.new()
	if tempoFile.file_exists("tempo.txt") and tempoFile.file_exists("song.wav"):
		tempoFile.open("tempo.txt", File.READ)
		tempo = float(tempoFile.get_line())
		step = 60*1000/tempo
		song = load("song.wav")
		stream = song
		firstLoop = false
		customSong = true
	else:
		stream = start

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !firstLoop:
		if songPos > get_playback_position():
			start_time = OS.get_ticks_msec()-80
			emit_signal("newLoop")
		songPos = get_playback_position()
	pass



func getStep():
	return step

func toNextBeat():
	var elapsedTime = OS.get_ticks_msec()-start_time
	var nextBeat = ceil(elapsedTime/step)
	return nextBeat*step+step

func currentTime():
	return OS.get_ticks_msec()-start_time


func _on_Song_finished():
	if firstLoop:
		stream = loop
		play() # Replace with function body.
		firstLoop = false
	if customSong:
		play()


func _on_Game_stop():
	stop()
	stream = fail
	play()


func _on_Game_start():
	start_time = OS.get_ticks_msec()
	if customSong:
		stream = song
	else:
		stream = start
		firstLoop = true
	play()
