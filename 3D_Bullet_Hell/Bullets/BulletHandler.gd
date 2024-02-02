extends Node

var BulletScene := load("res://Bullets/Bullet.tscn")
@onready var mm : Node3D = get_tree().get_root().find_child("ActiveBullets",true,false)
@export var pool_size := 10000

var _bullet_pool := []
var active_bullets := []

func _ready():
	for i in pool_size:
		var bullet = BulletScene.instantiate()
		bullet.visible = false
		bullet.set_process(PROCESS_MODE_DISABLED)
		
		_bullet_pool.append(bullet)
	
	#bullet_instantiator = MultiMeshInstance3D.new()
	#add_child(bullet_instantiator)
	#var multimesh = MultiMesh.new()
	#bullet_instantiator.multimesh = multimesh
	#multimesh.transform_format = MultiMesh.TRANSFORM_3D
	#multimesh.mesh = BulletScene.duplicate()


func _physics_process(delta):
	var deactivate_bullets := []
	if active_bullets.size():
		for bullet in active_bullets:
			bullet_mover(bullet)
			if Engine.get_physics_frames()%4 == 0:
				var result = bullet.check_collision()
				#if result:
				#	if result.collider.has_method("damage"):
				#		result.collider.damage(bullet.damage)
				if bullet.prev.x < -10 or result:
					back_to_pool(bullet)
	#if deactivate_bullets.size():
	#	for bullet in deactivate_bullets:
	#		back_to_pool(bullet)

func bullet_mover(bullet):
	#var tween = create_tween()
	#tween.tween_property(bullet, "position", bullet.position - (bullet.bulletFlyDirection*bullet.speed*get_physics_process_delta_time()),get_physics_process_delta_time())
	bullet.position = bullet.position - (bullet.global_transform.basis.z*bullet.speed*get_physics_process_delta_time())
	return
	
func back_to_pool(bullet):
	bullet.BulletOwner = null
	bullet.speed = 0
	bullet.damage = 0
	
	bullet.visible = false
	bullet.set_process(PROCESS_MODE_DISABLED)
	
	mm.remove_child(bullet)
	BulletHandler._bullet_pool.append(bullet)
	BulletHandler.active_bullets.remove_at(BulletHandler.active_bullets.find(bullet))
