extends Node2D


onready var _player := find_node("Player")
onready var _bullet_spawner := find_node("BulletSpawner")

func _ready() -> void:
# warning-ignore:return_value_discarded
	_player.connect("bullet_fired", self, "_on_bullet_fired")


func _on_bullet_fired(id: int, fired_from) -> void:
	var spawn_location = fired_from.position
	_bullet_spawner.spawn_bullet(Vector3(spawn_location.x, spawn_location.y, id))
