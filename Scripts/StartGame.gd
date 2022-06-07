extends Button


var thread

# Activate Button
func _ready():
	self.connect("pressed", self, "_button_pressed")
	self.get_parent().get_child(3).hide()
	

func _button_pressed():
	print("Testing");
	get_tree().change_scene("res://Scenes/LoadingScene.tscn")
