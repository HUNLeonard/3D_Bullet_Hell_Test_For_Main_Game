extends Node3D

@export var bulletSpeed : int = 19
@export var bulletDamage : int = 10
@onready var mm: Node3D = get_tree().get_root().find_child("ActiveBullets",true,false)

# THIS GOES TO ENEMY.GD
func create_objects(pos:Vector3,target:Vector3):
	position = pos
	look_at(target)
	if BulletHandler._bullet_pool.size():
		BulletHandler.active_bullets.append(BulletHandler._bullet_pool[BulletHandler._bullet_pool.size()-1])
		mm.add_child(BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1])
		BulletHandler._bullet_pool.remove_at(BulletHandler._bullet_pool.size()-1)
		
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].visible = true
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].set_process(PROCESS_MODE_INHERIT)
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].BulletOwner = self
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].position = position
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].prev = position
		
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].look_at(target)
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].speed = bulletSpeed
		BulletHandler.active_bullets[BulletHandler.active_bullets.size()-1].damage = bulletDamage
