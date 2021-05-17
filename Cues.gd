extends AudioStreamPlayer

#Next Cue
var cueType = -1 #-1 for silence, 1 for short, 2 for long
var startType = -1 #-1 for silence, 1 for short, 2 for long
var currentBeat
var isInput = false
var step
var alreadyHit = false

export (AudioStream) var miss
export (AudioStream) var short
export (AudioStream) var long

signal cueEnded
signal scored
signal missed
signal fire
signal whiff
#signal hit

func _ready():
	currentBeat = get_node("../Song").toNextBeat()
	step = get_node("../Song").getStep()
	startType = -1
	cueType = 7


func _process(_delta):
	if currentBeat+step/7-step < get_node("../Song").currentTime() && cueType != 0:
		if cueType == 2 && startType == 2:
			emit_signal("fire")
			stream = long
			play()
		elif cueType == 1 && startType == 1:
			emit_signal("fire")
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
			emit_signal("missed")
			stream = miss
			play()
		isInput = false
		currentBeat = get_node("../Song").toNextBeat()
		emit_signal("cueEnded")

func newCue(type):
	cueType = type
	startType = type


func _on_Game_swing():
	if(analyzeInput() && !isInput):
		emit_signal("scored")
		isInput = true
	else:
		emit_signal("whiff")
		isInput = false

func analyzeInput():
	if(get_node("../Song").currentTime() > currentBeat-step/3 && 
	   get_node("../Song").currentTime() < currentBeat-step/4 && 
	   cueType == 0 && startType in [1,2]): # Too early
		alreadyHit = true
		return false
	elif(get_node("../Song").currentTime() > currentBeat+step/3 && 
		 get_node("../Song").currentTime() < currentBeat+step/4 && 
		 cueType == 0 && startType  in[1,2]): # Too late
		alreadyHit = true
		return false
	elif(get_node("../Song").currentTime() > currentBeat-step/4 && 
		 get_node("../Song").currentTime() < currentBeat+step/4 && 
		 cueType == 0 && startType in [1,2] &&
		 !alreadyHit):
		return true
	else:
		return false
		
func getCueType():
	return startType


func _on_Song_newLoop():
	currentBeat = get_node("../Song").toNextBeat()
	pass


func _on_Game_stop():
	cueType = -2
	startType = -2
