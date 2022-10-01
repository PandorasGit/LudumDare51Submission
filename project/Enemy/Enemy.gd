extends KinematicBody2D



func _on_killed():
	queue_free()
