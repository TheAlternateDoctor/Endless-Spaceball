extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (AudioStream) var hit
export (AudioStream) var bat

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Cues_scored():
	stream = hit
	play()


func _on_Cues_whiff():
	stream = bat
	play()
