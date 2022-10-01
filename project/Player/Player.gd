extends KinematicBody2D


signal fired(id, fired_from)


var _velocity := Vector2.ZERO
var _speed := 500
var _bullet_id := 1
var _has_fired := false


onready var _reload_timer := find_node("ReloadTimer")


func _ready() -> void:
# warning-ignore:return_value_discarded
	_reload_timer.connect("timeout", self, "_on_reload_timer_timeout")


func _physics_process(_delta: float) -> void:
	var x_movement := _get_x_input()
	_velocity = move_and_slide(Vector2(x_movement, 0) * _speed, Vector2.UP)
	
	if Input.is_action_just_pressed("shoot") and not _has_fired:
		emit_signal("fired", _bullet_id, self)
		_has_fired = true
		_reload_timer.start()


func _get_x_input() -> float:
	return Input.get_axis("move_left", "move_right")


func _on_reload_timer_timeout() -> void:
	_has_fired = false


func _on_killed() -> void:
	queue_free()
