extends Control


signal restart


var bullet_spawner setget _set_bullet_spawner


onready var _score := find_node("Score")
onready var _restart_button := find_node("RestartButton")


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



func _on_RestartButton_pressed() -> void:
	emit_signal("restart")
