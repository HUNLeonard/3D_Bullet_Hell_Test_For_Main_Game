extends MeshInstance3D

@export var player : Node

func _physics_process(delta):
	var direction_to_player = (player.global_transform.origin - global_transform.origin).normalized()
	if direction_to_player.cross(Vector3(0, 1, 0)).length() > 0.0001:
		var rotation_matrix = Transform3D().looking_at(direction_to_player, Vector3(0, 1, 0))
		global_transform.basis = rotation_matrix.basis
	else:
		var rotation_matrix = Transform3D(Basis(Vector3(-1, 0, 0), PI/2))
		global_transform.basis = rotation_matrix.basis
		
