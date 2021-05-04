extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lockAction = false
signal swing



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_key_pressed(KEY_SPACE):
		if lockAction == false:
			emit_signal("swing")
			animation = "Swing"
			play()
			lockAction = true
	if not Input.is_key_pressed(KEY_SPACE) and lockAction == true:
		lockAction = false


func _on_AnimatedSprite_animation_finished():
	animation = "Idle"
	play()
