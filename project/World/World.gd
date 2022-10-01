extends Node2D


onready var _player := find_node("Player")
onready var _bullet_spawner := find_node("BulletSpawner")
onready var _enemy_spawner := find_node("EnemySpawner")
onready var _hud := find_node("HUD")

func _ready() -> void:
# warning-ignore:return_value_discarded
	_player.connect("fired", self, "_on_fired")
# warning-ignore:return_value_discarded
	_bullet_spawner.connect("player_killed", _player, "_on_killed")
# warning-ignore:return_value_discarded
	_bullet_spawner.connect("score_updated", _hud, "_on_score_updated")
# warning-ignore:return_value_discarded
	_enemy_spawner.connect("spawned", self, "_on_spawned")


func _on_fired(id: int, fired_from: KinematicBody2D) -> void:
	var spawn_location := fired_from.position
	_bullet_spawner.spawn_bullet(Vector3(spawn_location.x, spawn_location.y, id))


func _on_spawned(enemy):
	# warning-ignore:return_value_discarded
	_bullet_spawner.connect("enemy_killed", enemy, "_on_killed")
	enemy.connect("fired", self, "_on_fired")
