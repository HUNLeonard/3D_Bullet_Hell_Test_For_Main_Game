extends Node


func _physics_process(delta):
	var sizez = Vector3(.1,.1,.3)
	
	%Label.text = str(BulletHandler.enemy_basic_bullet_RIDS.size()) + "\n"+str(Engine.get_frames_per_second())+" FPS"
	if Input.is_action_pressed("ui_accept"):
		for i in range(2):
			randomize()
			var random_pos = randf_range(-4,4)
			var random_p = randf_range(9,20)
			$"../Enemy".create_objects(Vector3(random_p,0,random_pos),Vector3(-10,0,random_pos))
		
	
	#if Input.is_action_pressed("ui_left"):
	#	var direction_to_player = (global_transform.origin - %MeshInstance3D.global_transform.origin).normalized()
	#	var def_pos = %MeshInstance3D.global_transform.origin
	#	%MeshInstance3D2.global_transform.origin = %MeshInstance3D.global_transform.origin + direction_to_player * (%MeshInstance3D.mesh.get_size().z / 2)
		
		



