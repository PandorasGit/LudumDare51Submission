extends Node2D


onready var _player := find_node("Player")
onready var _bullet_spawner := find_node("BulletSpawner")


func _ready() -> void:
# warning-ignore:return_value_discarded
	_player.connect("fired", self, "_on_fired")
# warning-ignore:return_value_discarded
	_bullet_spawner.connect("player_killed", self, "_on_player_killed")


func _on_fired(id: int, fired_from: KinematicBody2D) -> void:
	var spawn_location := fired_from.position
	_bullet_spawner.spawn_bullet(Vector3(spawn_location.x, spawn_location.y, id))


func _on_player_killed() -> void:
	_player.die()
