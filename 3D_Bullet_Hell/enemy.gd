extends Node3D

var Bullet_Speed = 20

@export var player : CharacterBody3D
@onready var mesh
@onready var box_mesh = BoxMesh.new()
@onready var box_shape

# THIS GOES TO ENEMY.GD
func create_objects(pos:Vector3,target:Vector3):
	global_transform.origin = pos
	box_mesh.set_size(Vector3(.1,.1,.3))

	box_shape = PhysicsServer3D.box_shape_create()
	PhysicsServer3D.shape_set_data(box_shape, box_mesh.get_size())
	var bullet = PhysicsServer3D.body_create()
	PhysicsServer3D.body_set_mode(bullet,PhysicsServer3D.BODY_MODE_RIGID)
	var trans = Transform3D(Basis(),global_transform.origin).looking_at(target,Vector3.UP)
	PhysicsServer3D.body_set_state(bullet,PhysicsServer3D.BODY_STATE_TRANSFORM,trans)
	look_at(target,Vector3.UP)

	var direction_to_player = (target - global_transform.origin).normalized()
	var bullet_tip = global_transform.origin + direction_to_player * (box_mesh.get_size().z / 2)
	
	
	PhysicsServer3D.body_apply_impulse(bullet,-transform.basis.z * Bullet_Speed,-transform.basis.z)
	PhysicsServer3D.body_set_space(bullet,get_world_3d().get_space())
	PhysicsServer3D.body_add_shape(bullet,box_shape)
	PhysicsServer3D.body_set_shape_transform(bullet,0,Transform3D(Basis.IDENTITY,Vector3.ZERO))
	PhysicsServer3D.body_set_collision_mask(bullet, 0)
	PhysicsServer3D.body_set_collision_layer(bullet, 0)

	PhysicsServer3D.body_set_param(bullet,PhysicsServer3D.BODY_PARAM_GRAVITY_SCALE,0)
	var rs = RenderingServer

	mesh = rs.instance_create2(box_mesh,get_world_3d().scenario)
	rs.instance_set_transform(mesh,trans)
	
	
	
	BulletHandler.enemy_basic_bullet_RIDS.append([bullet,mesh,bullet_tip,target,Bullet_Speed])
