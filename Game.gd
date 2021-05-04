extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var score = 0
var lives = 3

#Emit Signals for Cues

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Cues_cueEnded():
	var randomType = rng.randi_range(0,100)
	if randomType <10: randomType = -1
	if randomType >=10 && randomType < 30: randomType = 2
	if randomType >=30: randomType = 1
	$Cues.newCue(randomType) # Replace with function body.


func _on_Cues_scored():
	score+=1
	print("Score:"+str(score))


func _on_Cues_missed():
	lives-=1
	print("Lives:"+str(lives))
