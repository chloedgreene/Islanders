extends ColorRect


func _ready():
	self.get_viewport().connect("change_filter_size",self,"size_changed")
	pass # Replace with function body.

func _process(delta):
	
	if(self.get_parent().get_parent().is_in_water()):
		self.set_size(self.get_viewport().size)
		self.material.set_shader_param ( "use_shader", true )
	else:
		self.material.set_shader_param ( "use_shader", false )
		
