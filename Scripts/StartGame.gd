extends Button


var thread

# Activate Button
func _ready():
	self.connect("pressed", self, "_button_pressed")
	self.get_parent().get_child(3).hide()
	

func _button_pressed():
	#When button is pressed start loading Island! 
	self.text = 'Loading...' 
	self.hide();
	
	self.get_parent().get_child(3).show()
	
	
	thread = Thread.new()
	thread.start(self,"_load_scene","sus")


func _load_scene(data):
	
	get_tree().change_scene("res://Scenes/Game.tscn")

func _exit_tree():
	thread.wait_to_finish()
