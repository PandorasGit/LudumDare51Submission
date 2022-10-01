extends KinematicBody2D


signal fired(id, fired_from)
signal super_state_changed(new_state)


var _velocity := Vector2.ZERO
var _speed := 1000
var _normal_bullet_id := 1
var _super_bullet_id := 2
var _has_fired := false
var _has_supered := false
var _is_alive := true

onready var _reload_timer := find_node("ReloadTimer")
onready var _super_timer := find_node("SuperTimer")
onready var _collider := find_node("Collider")
onready var _death_tween := find_node("DeathTween")
onready var _sprite := find_node("Sprite")
onready var _death_particles := find_node("DeathParticles")
onready var _death_timer := find_node("DeathAnimationTimer")
onready var _death_sound := find_node("DeathSound")

func _ready() -> void:
	# warning-ignore:return_value_discarded
	_reload_timer.connect("timeout", self, "_on_reload_timer_timeout")
	# warning-ignore:return_value_discarded
	_super_timer.connect("timeout", self, "_on_super_timer_timeout")
	# warning-ignore:return_value_discarded
	_death_timer.connect("timeout", self, "_on_death_timer_timeout")


func _physics_process(_delta: float) -> void:
	if _is_alive:
		var x_movement := _get_x_input()
		_velocity = move_and_slide(Vector2(x_movement, 0) * _speed, Vector2.UP)
		_shoot()


func _shoot() -> void:
	if Input.is_action_just_pressed("shoot") and not _has_fired:
		if not _has_supered:
			_shoot_super()
		else:
			_shoot_normal()


func _shoot_normal() -> void:
	emit_signal("fired", _normal_bullet_id, position)
	_has_fired = true
	_reload_timer.start()


func _shoot_super():
	emit_signal("fired", _super_bullet_id, position)
	_has_supered = true
	emit_signal("super_state_changed", false)
	_super_timer.start()


func _get_x_input() -> float:
	return Input.get_axis("move_left", "move_right")


func _on_reload_timer_timeout() -> void:
	_has_fired = false


func _on_super_timer_timeout() -> void:
	_has_supered = false
	emit_signal("super_state_changed", true)


func _on_killed() -> void:
	_is_alive = false
	_die()
	_death_timer.start()

func _on_death_timer_timeout() -> void:
	queue_free()

func _die() -> void:
	_death_sound.play()
	_collider.disabled = true
	_death_tween.interpolate_property(_sprite, "modulate",
		Color("ffffff"), Color("000000"), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_death_tween.interpolate_property(_sprite, "rotation",
		0, 360, 10,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_death_tween.interpolate_property(_sprite, "scale",
		Vector2(5,5), Vector2(0,0), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_death_particles.emitting = true
	_death_tween.start()
	_death_timer.start()
