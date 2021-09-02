extends Label


func _process(delta):
	self.text = str(self.get_parent().get_parent().get_child(2).transform)
