extends Node2D


signal player_killed
signal enemy_killed(name)
signal score_updated(new_score)


var player setget _set_player
var _score := 0


onready var _default_bullet := load("res://Bullets/Bullet.tscn")
onready var _friendly_bullet := load("res://Bullets/FriendlyBullet/FriendlyBullet.tscn")
onready var _super_bullet := load("res://Bullets/SuperBullet/SuperBullet.tscn")


func _set_player(value: KinematicBody2D) -> void:
	player = value
	# warning-ignore:return_value_discarded
	connect("player_killed", player, "_on_killed")


# The Z component is Used to store the id of the bullet
func spawn_bullet(fired_from: Vector3) -> void:
	if fired_from.z == 2:
		var new_position = Vector2(fired_from.x, fired_from.y)
		var new_bullet = _make_new_bullet(_super_bullet.instance(), new_position)
		new_bullet.connect("collided", self, "_on_super_bullet_collided")

	elif fired_from.z == 1:
		var new_position = Vector2(fired_from.x, fired_from.y)
		var new_bullet = _make_new_bullet(_friendly_bullet.instance(), new_position)
		new_bullet.connect("collided", self, "_on_friendly_bullet_collided")

	else:
		var new_position = Vector2(fired_from.x, fired_from.y)
		var new_bullet = _make_new_bullet(_default_bullet.instance(), new_position)
		new_bullet.connect("collided", self, "_on_default_bullet_collided")


#The Vector2 is passed from the X and y components of the Vector3 used in the spawn bullet function
func _make_new_bullet(new_bullet: Bullet, fired_from: Vector2) -> Bullet:
	add_child(new_bullet)
	new_bullet.position = fired_from
	new_bullet.startTimer()
	return new_bullet


func _on_default_bullet_collided(_name: String) -> void:
	emit_signal("player_killed")


func _on_friendly_bullet_collided(_name: String) -> void:
	emit_signal("enemy_killed", _name)
	_score += 1
	emit_signal("score_updated", _score)


func _on_super_bullet_collided(_name: String) -> void:
	emit_signal("enemy_killed", _name)
	_score += 10
	emit_signal("score_updated", _score)
