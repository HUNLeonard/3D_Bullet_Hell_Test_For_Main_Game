extends Node


func _physics_process(_delta):

	%Label.text = str(Engine.get_frames_per_second())+" FPS\n"+str(BulletHandler._bullet_pool.size()) + " Bullet Pool\n"+str(BulletHandler.active_bullets.size()) + " Bullet ACtive"
	if Input.is_action_pressed("ui_accept"):
		for i in range(6):
			randomize()
			var random_pos = randf_range(-4,4)
			var random_p = randf_range(9,20)
			$"../Enemy".create_objects(Vector3(random_p,0,random_pos),Vector3(-10,0,random_pos))
		
	
	#if Input.is_action_pressed("ui_left"):
	#	var direction_to_player = (global_transform.origin - %MeshInstance3D.global_transform.origin).normalized()
	#	var def_pos = %MeshInstance3D.global_transform.origin
	#	%MeshInstance3D2.global_transform.origin = %MeshInstance3D.global_transform.origin + direction_to_player * (%MeshInstance3D.mesh.get_size().z / 2)
		
		



