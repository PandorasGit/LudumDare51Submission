extends Node2D


signal spawned(new_enemy)


onready var _respawn_timer := find_node("RespawnTimer")
onready var _enemy := load("res://Enemy/Enemy.tscn")


func _ready():
# warning-ignore:return_value_discarded
	_respawn_timer.connect("timeout", self, "_on_RespawnTimer_timeout")
	_respawn_timer.start()


func _on_RespawnTimer_timeout() -> void:
	_spawn_enemy()
	_respawn_timer.start()


func _spawn_enemy() -> void:
	var new_enemy = _enemy.instance()
	add_child(new_enemy)
	new_enemy.position = Vector2(-10, -10)
	new_enemy.despawn_timer.start()
	emit_signal("spawned", new_enemy)
