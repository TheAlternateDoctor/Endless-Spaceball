extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (AudioStream) var loop
export (AudioStream) var start

var tempo = 105
var step:float = 60*1000/tempo

var start_time
# Called when the node enters the scene tree for the first time.
func _ready():
	print(step)
	start_time = OS.get_ticks_msec()
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !is_playing():
		stream = loop
		play()

func getStep():
	return step

func toNextBeat():
	var elapsedTime = OS.get_ticks_msec()-start_time
	var nextBeat = ceil(elapsedTime/step)
	return nextBeat*step+step

func currentTime():
	return OS.get_ticks_msec()-start_time
