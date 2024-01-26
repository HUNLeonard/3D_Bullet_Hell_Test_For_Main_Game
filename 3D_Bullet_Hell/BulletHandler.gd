extends Node

@onready var enemy_basic_bullet_RIDS := []
@onready var enemy_basic_bullet_instantiator
@onready var enemy_basic_bullet_mesh = preload("res://bullet_mesh.tres")
var result

func _ready():
	enemy_basic_bullet_instantiator = MultiMeshInstance3D.new()
	add_child(enemy_basic_bullet_instantiator)
	var multimesh = MultiMesh.new()
	enemy_basic_bullet_instantiator.multimesh = multimesh
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = enemy_basic_bullet_mesh.duplicate()


func _physics_process(delta):
	var removal_queue = []
	if Engine.get_physics_frames() % 2 == 0:
		var how_many = enemy_basic_bullet_RIDS.size()
		var mm = enemy_basic_bullet_instantiator.multimesh
		if mm != null:
			mm.instance_count = how_many
			if how_many != 0:
				for projectile in enemy_basic_bullet_RIDS:
					var i = enemy_basic_bullet_RIDS.find(projectile)
					var bullet = projectile[0]
					var bullet_mesh = projectile[1]
					var prev_pos = projectile[2]
					var target_pos = projectile[3]
					var bullet_speed = projectile[4]
					
					var pos = PhysicsServer3D.body_get_state(bullet, PhysicsServer3D.BODY_STATE_TRANSFORM)
					RenderingServer.instance_set_transform(bullet_mesh,pos)
					mm.set_instance_transform(i,pos)
					var new_pos = pos.origin - (prev_pos.direction_to(target_pos)*bullet_speed*delta)
					result = check_collision(bullet,prev_pos,new_pos)
					if result:
						if result.collider.has_method("damage"):
							result.collider.damage(10)
					if pos.origin.x < -10 or result:
						PhysicsServer3D.free_rid(projectile[0])
						RenderingServer.free_rid(projectile[1])
						removal_queue.append(projectile)
					projectile[2] = new_pos
				if removal_queue.size():
					for asd in removal_queue:
						enemy_basic_bullet_RIDS.erase(asd)

func check_collision(bullet,prev, next):
	var space = PhysicsServer3D.body_get_space(bullet)
	var space_state = PhysicsServer3D.space_get_direct_state(space)
	var query = PhysicsRayQueryParameters3D.create(prev,next)
	query.collide_with_bodies = true
	query.set_collision_mask(1)
	
	return space_state.intersect_ray(query)
					

func _exit_tree():
	for obj in enemy_basic_bullet_RIDS:
		PhysicsServer3D.free_rid(obj[0])
		RenderingServer.free_rid(obj[1])

