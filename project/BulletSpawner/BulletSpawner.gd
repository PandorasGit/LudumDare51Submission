extends Node2D


signal player_killed
signal enemy_killed(name)
signal score_updated(new_score)


var _score := 0


onready var _default_bullet := load("res://Bullets/Bullet.tscn")
onready var _friendly_bullet := load("res://Bullets/FriendlyBullet/FriendlyBullet.tscn")


# The Z component is Used to store the id of the bullet
func spawn_bullet(fired_from: Vector3) -> void:
	if fired_from.z > 0:
		var friendly_bullet = _friendly_bullet.instance()
		add_child(friendly_bullet)
		friendly_bullet.position = Vector2(fired_from.x, fired_from.y)
		friendly_bullet.startTimer()
		friendly_bullet.connect("collided", self, "_on_friendly_bullet_collided")
		
	else:
		var default_bullet = _default_bullet.instance()
		add_child(default_bullet)
		default_bullet.position = Vector2(fired_from.x, fired_from.y)
		default_bullet.connect("collided", self, "_on_default_bullet_collided")


func _on_default_bullet_collided(_name: String) -> void:
	emit_signal("player_killed")


func _on_friendly_bullet_collided(_name: String) -> void:
	emit_signal("enemy_killed", _name)
	_score += 1
	emit_signal("score_updated", _score)
