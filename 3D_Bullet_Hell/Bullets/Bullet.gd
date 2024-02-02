class_name Bullet extends MeshInstance3D

@export var BulletOwner : Node3D
@export var speed : float
@export var damage : float

var prev 


func check_collision():
	var next_pos = position - (global_transform.basis.z*speed*get_physics_process_delta_time())
	var query = PhysicsRayQueryParameters3D.create(prev,next_pos)
	query.collide_with_bodies = true
	query.set_collision_mask(1)
	prev = next_pos
	var world = get_tree().get_root().get_world_3d()
	
	return world.direct_space_state.intersect_ray(query)
