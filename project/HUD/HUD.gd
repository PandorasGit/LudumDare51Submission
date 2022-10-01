extends Control


signal restart


var bullet_spawner setget _set_bullet_spawner
var player setget _set_player


onready var _score := find_node("Score")
onready var _restart_button := find_node("RestartButton")
onready var _super_button := find_node("CanSuperButton")


func _set_player(value: KinematicBody2D) -> void:
	player = value
	# warning-ignore:return_value_discarded
	player.connect("super_state_changed", self, "_on_super_state_changed")


func _set_bullet_spawner(value: Node2D) -> void:
	bullet_spawner = value
	# warning-ignore:return_value_discarded
	bullet_spawner.connect("player_killed", self, "_on_player_killed")
	# warning-ignore:return_value_discarded
	bullet_spawner.connect("score_updated", self, "_on_score_updated")


func _on_score_updated(new_score: float) -> void:
	_score.text = "Score: %d" % new_score 


func _on_player_killed() -> void:
	_restart_button.visible = true


func _on_super_state_changed(state: bool) -> void:
	_super_button.pressed = state


func _on_RestartButton_pressed() -> void:
	emit_signal("restart")
