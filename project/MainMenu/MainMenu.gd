extends Control


onready var _world := preload("res://World/World.tscn")
onready var _start_button := find_node("StartButton")


func _ready() -> void:
	_start_button.grab_focus()
	# warning-ignore:return_value_discarded
	_start_button.connect("pressed", self, "_on_StartButton_pressed")


func _on_StartButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(_world)
