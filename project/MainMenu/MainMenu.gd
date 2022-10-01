extends Control


onready var _world := preload("res://World/World.tscn")


func _on_StartButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(_world)
