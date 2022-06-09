
tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var heart_count = 5;
export var health = 5;

var heart = preload("res://Prefabs/Heart.tscn")

func _ready():
	update_heart()

# Called when the node enters the scene tree for the first time.
func update_heart():
	
	var current_health = health;
	
	var index = 0
	var doextrahalfheart = false
	
	if heart_count % 2 != 0:
		doextrahalfheart = true
		heart_count=heart_count-1;
	
	for n in heart_count/2:
		
		
		var hearthnode = heart.instance()
		hearthnode.frame = health_calcualtion(current_health)
		hearthnode.position.x = n*16
		index = index +1;
		current_health = current_health - 2;
		add_child(hearthnode)
	
	if doextrahalfheart:
		var hearthnode = heart.instance()
		hearthnode.frame = health_calcualtion(current_health)
		hearthnode.position.x = index*16
		add_child(hearthnode)
	
	
	
	pass # Replace with function body.

func health_calcualtion(current_health):
	
	print(current_health)
	
	if current_health < 0:
		return 0
	
	if current_health == 1:
		return 1
	elif current_health == 0:
		return 0;
	else:
		return 2;
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


