extends Control


signal restart


onready var _score := find_node("Score")
onready var _restart_button := find_node("RestartButton")


func _on_score_updated(new_score: float) -> void:
	_score.text = "Score: %d" % new_score 


func _on_player_killed() -> void:
	_restart_button.visible = true



func _on_RestartButton_pressed():
	emit_signal("restart")
