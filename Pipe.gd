extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var readyIdle = false
var step
var swingTime

# Called when the node enters the scene tree for the first time.
func _ready():
	step = get_node("../../Song").getStep()

func _process(_delta):
	if readyIdle && OS.get_ticks_msec() - swingTime > step/2:
		animation = "Idle"
		play()
		readyIdle = false

func _on_Cues_fire():
	animation = "Fire"
	play()


func _on_Pipe_animation_finished():
	swingTime = OS.get_ticks_msec()
	readyIdle = true
