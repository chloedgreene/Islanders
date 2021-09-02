extends Camera

var DEFAULT_X = 0
var DEFAULT_Y = -90

var current_y = DEFAULT_Y
var current_x = DEFAULT_X

func map(value, istart, istop, ostart, ostop):
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))


func _ready():
	pass 
	
func _input(event):
	
	if event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)
		current_x = map(event.position.x,0,get_viewport().size.x,-180,180)
		
		
	

func _process(delta):
	self.rotation.x = current_x
