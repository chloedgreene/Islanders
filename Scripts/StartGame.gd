extends Button


var thread

# Activate Button
func _ready():
	self.connect("pressed", self, "_button_pressed")
	self.get_parent().get_child(3).hide()
	

func _button_pressed():
	#When button is pressed start loading Island! 
	
	load_scene();
	

func load_scene():
	
	get_tree().change_scene("res://Scenes/Game.tscn")

