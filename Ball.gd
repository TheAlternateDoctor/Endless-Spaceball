extends Sprite


# Base pos = 278 353
# Hit pos = 434 239
# Base scale = 0.315

var rng = RandomNumberGenerator.new()

var fireCount = 0
var hit = false
var step

var xDir:float
var yDir:float
var rotationDir:float
var flyStart

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = OS.get_ticks_msec()*2
	step = get_node("../Song").getStep()
	pass # Replace with function body.

 
func _process(delta):
	if hit == true:
		scale.x += 0.050
		scale.y += 0.050
		var xSpeed:float = OS.get_ticks_msec() - flyStart
		position.x += xDir* (xSpeed/750)
		position.y += yDir*1.5
		rotation += rotationDir/100
	pass


func _on_Cues_fire():
	if fireCount == 0:
		xDir = rng.randi_range(25,50)
		yDir = rng.randi_range(-10,10)
		var dir = rng.randi()
		rotationDir = rng.randi_range(-3,3)
		flyStart = OS.get_ticks_msec()
		visible = true
		fireCount = 1
		position.x = 278
		position.y = 353
		scale.x = 0.315
		scale.y = 0.315
		hit = false
		var cue = get_node("../Cues").getCueType()
		if cue == 1:
			$AnimationPlayer.playback_speed = (1000/step)-(1000/(step*10))
			$AnimationPlayer.play("shortThrow")
		else:
			$AnimationPlayer.playback_speed = ((1000/step)/2)-(1000/(step*20))
			$AnimationPlayer.play("longThrow")
	else:
		fireCount = 0

func _on_Cues_scored():
	if fireCount == 1:
		#if position.x >
		hit = true
		$AnimationPlayer.stop()


func _on_AnimationPlayer_animation_finished(anim_name):
	visible=false
