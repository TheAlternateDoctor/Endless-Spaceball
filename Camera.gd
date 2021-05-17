extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed:float
var limit = 0
var addedBeforeLimit = -0.5
var way = 0
var minimum = 1
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if addedBeforeLimit < limit && zoom.x >= minimum:
		zoom.x += speed*way
		zoom.y += speed*way
		addedBeforeLimit += speed
	if zoom.x <minimum:
		zoom.x = minimum
		zoom.y = minimum


func _on_Cues_fire():
	var cueType = get_node("../Cues").getCueType()
	if cueType == 2:
		speed = .02
		limit = 1
		way = 1
	elif cueType == 1:
		speed = 0.3
		limit = 0.5
		way = -1
	addedBeforeLimit = 0
