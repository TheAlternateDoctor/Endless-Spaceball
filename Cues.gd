extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#Various Sound Effects
export (AudioStream) var bat
export (AudioStream) var miss
export (AudioStream) var hit
export (AudioStream) var short
export (AudioStream) var long

#Next Cue
var cueType = -1 #-1 for silence, 1 for short, 2 for long
var startType = -1 #-1 for silence, 1 for short, 2 for long
var currentBeat
var isInput = false
var step
var alreadyHit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	currentBeat = get_node("../Song").toNextBeat()
	step = get_node("../Song").getStep()
	pass # Replace with function body.

signal cueEnded
signal scored
signal missed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if currentBeat+step/7-step < get_node("../Song").currentTime() && cueType != 0:
		if cueType == 2 && startType == 2:
			stream = long
			play()
		elif cueType == 1 && startType == 1:
			stream = short
			play()
		elif cueType == -1 && startType == -1:
			cueType =1
		cueType-=1
		if cueType != 0:
			currentBeat = get_node("../Song").toNextBeat()
	elif currentBeat+step/2 < get_node("../Song").currentTime() && cueType == 0:
		alreadyHit = false
		if isInput == false && startType != -1:
			stream = miss
			play()
			emit_signal("missed")
		if isInput == true:
			emit_signal("scored")
		isInput = false
		currentBeat = get_node("../Song").toNextBeat()
		emit_signal("cueEnded")

func newCue(type):
	cueType = type
	startType = type

func _on_Player_swing():
	if(analyzeInput() && !isInput):
		stream = hit
		play()
		isInput = true
	else:
		stream = bat
		play()
		isInput = false

func analyzeInput():
	if(get_node("../Song").currentTime() > currentBeat-step/2 && 
	   get_node("../Song").currentTime() < currentBeat-step/4 && 
	   cueType == 0): # Too early
		alreadyHit = true
		return false
	elif(get_node("../Song").currentTime() > currentBeat+step/2 && 
		 get_node("../Song").currentTime() < currentBeat+step/4 && 
		 cueType == 0): # Too late
		alreadyHit = true
		return false
	elif(get_node("../Song").currentTime() > currentBeat-step/4 && 
		 get_node("../Song").currentTime() < currentBeat+step/4 && 
		 cueType == 0 &&
		 !alreadyHit):
		return true
	else:
		return false
