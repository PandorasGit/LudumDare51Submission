extends Node2D


onready var _default_bullet := load("res://Bullets/Bullet.tscn")
onready var _friendly_bullet := load("res://Bullets/FriendlyBullet/FriendlyBullet.tscn")


# The Z component is Used to store the id of the bullet
func spawn_bullet(fired_from: Vector3) -> void:
	
	if Vector3.AXIS_Z > 0:
		var new_bullet = _friendly_bullet.instance()
		add_child(new_bullet)
		new_bullet.position = Vector2(fired_from.x, fired_from.y)

	else:
		var new_bullet = _friendly_bullet.instance()
		add_child(new_bullet)
		new_bullet.position = Vector2(fired_from.x, fired_from.y)
