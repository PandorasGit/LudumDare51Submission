extends KinematicBody2D


var _velocity := Vector2.ZERO
var _speed := 500


func _physics_process(_delta: float) -> void:
	var x_movement := _get_x_input()
	_velocity = move_and_slide(Vector2(x_movement, 0) * _speed, Vector2.UP)


func _get_x_input() -> float:
	return Input.get_axis("move_left", "move_right")
