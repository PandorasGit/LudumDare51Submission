extends KinematicBody2D


signal bullet_fired(id, fired_from)


var _velocity := Vector2.ZERO
var _speed := 500
var bullet_id := 1


func _physics_process(_delta: float) -> void:
	var x_movement := _get_x_input()
	_velocity = move_and_slide(Vector2(x_movement, 0) * _speed, Vector2.UP)
	
	if Input.is_action_just_pressed("shoot"):
		emit_signal("bullet_fired", bullet_id, self)


func _get_x_input() -> float:
	return Input.get_axis("move_left", "move_right")
