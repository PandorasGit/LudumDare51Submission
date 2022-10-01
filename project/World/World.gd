extends Node2D


onready var _player := find_node("Player")
onready var _bullet_spawner := find_node("BulletSpawner")
###TODO replace this connection with a way to connect per enemy spawn. This is for testing
onready var _enemy := find_node("Enemy")

func _ready() -> void:
# warning-ignore:return_value_discarded
	_player.connect("fired", self, "_on_fired")
# warning-ignore:return_value_discarded
	_bullet_spawner.connect("player_killed", _player, "_on_killed")
	
# warning-ignore:return_value_discarded
	_bullet_spawner.connect("enemy_killed", _enemy, "_on_killed")
	_enemy.connect("fired", self, "_on_fired")


func _on_fired(id: int, fired_from: KinematicBody2D) -> void:
	var spawn_location := fired_from.position
	_bullet_spawner.spawn_bullet(Vector3(spawn_location.x, spawn_location.y, id))
