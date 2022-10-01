extends Control


onready var _world := preload("res://World/World.tscn")


func _on_StartButton_pressed():
	get_tree().change_scene_to(_world)
