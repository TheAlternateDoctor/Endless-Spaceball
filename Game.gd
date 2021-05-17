extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var score = 0
var lives = 3
var lockAction = false
var stop = false

signal swing
signal stop

#Emit Signals for Cues

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	if Input.is_key_pressed(KEY_SPACE):
		if lockAction == false:
			emit_signal("swing")
			lockAction = true
	if not Input.is_key_pressed(KEY_SPACE) and lockAction == true and !stop:
		lockAction = false


func _on_Cues_cueEnded():
	if !stop:
		var randomType = rng.randi_range(0,100)
		if randomType <15: randomType = -1
		if randomType >=15 && randomType < 30: randomType = 2
		if randomType >=30: randomType = 1
		$Cues.newCue(randomType) # Replace with function body.
	else:
		$Cues.newCue(-1)


func _on_Ball_scored():
	score+=1
	$CanvasLayer/Score.text = "SCORE: "+str(score)

func _on_Ball_missed():
	lives-=1
	if lives == 0:
		emit_signal("stop")
		stop = true
		lockAction = true
		$CanvasLayer/GameOver.visible = true
	$CanvasLayer/Life.text = "LIVES: "+str(lives)

