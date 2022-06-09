extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var health = 0;

var heart = preload("res://Prefabs/Heart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var index = 0
	
	var heart_amount = health/3
	
	for n in heart_amount:
		var heart_index = heart.instance();
		
		heart_index.frame = 5;
		heart_index.position.x = n * 16
		
		add_child(heart_index)
		pass
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
