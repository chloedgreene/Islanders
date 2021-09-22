extends Spatial

const SIZE = 320;

func _ready():
	generate_island()
	
	
func generate_island():
	#OLD CODE DONT USE
	randomize()
	
	var surface_tool = SurfaceTool.new()
	var data_tool = MeshDataTool.new()
	var noise = OpenSimplexNoise.new()
	
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(SIZE,SIZE)
	plane_mesh.subdivide_depth = SIZE / 2;
	plane_mesh.subdivide_width = SIZE / 2;
	
	noise.seed = randi()
	
	noise.octaves = 5;
	noise.period  = 120;
	
	
	surface_tool.create_from(plane_mesh,0)
	var array_mesh = surface_tool.commit()
	data_tool.create_from_surface(array_mesh,0)
	
	
	
	var gradient_mask = CustomGradientTexture.new()
	gradient_mask.gradient = Gradient.new()
	gradient_mask.type = CustomGradientTexture.GradientType.RADIAL
	gradient_mask.size = Vector2(SIZE+1, SIZE+1)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	#$WaterLevel.scale = Vector3(SIZE,1,SIZE)
	
	for i in range(data_tool.get_vertex_count()):
		
		var vertex = data_tool.get_vertex(i)
		var value = noise.get_noise_3d(vertex.x,vertex.y,vertex.z);
		
		var data = gradient_mask.get_data()
		data.lock();
		var gradient_value = data.get_pixel(vertex.x + SIZE * 0.5,vertex.z+ SIZE * 0.5).g * 1.5
		value -= gradient_value
		
		vertex.y = value * 50
		data.unlock()
		
		if(vertex.y > -47):
			var grass = load("res://Prefabs/Grass.tscn")
			var grass_resource = grass.instance()
			grass_resource.translation = Vector3(vertex.x + rng.randf_range(-0.5, 0.5),vertex.y,vertex.z + rng.randf_range(-0.5, 0.5) )
			
		
		data_tool.set_vertex(i,vertex)
	
	for s in range(array_mesh.get_surface_count()):
		array_mesh.surface_remove(s)
	
	data_tool.commit_to_surface(array_mesh)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.create_from(array_mesh,0)
	surface_tool.generate_normals()
	
	var material = SpatialMaterial.new()
	
	var mesh_instance = MeshInstance.new()
	mesh_instance.mesh = surface_tool.commit()
	mesh_instance.create_trimesh_collision()
	material.albedo_color = Color.darkgreen
	mesh_instance.material_override = material
	
	#mesh_instance.scale = Vector3(256,mesh_instance.scale.y,256)
	
	self.add_child(mesh_instance)
	
	$WaterLevel.scale = Vector3(512,$WaterLevel.scale.y,512)
	
	
