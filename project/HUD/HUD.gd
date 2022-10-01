extends Control


onready var _score := find_node("Score")


func _on_score_updated(new_score: float) -> void:
	_score.text = "Score: %d" % new_score 
