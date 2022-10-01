extends KinematicBody2D


signal fired(id, fired_from)


var _has_fired := false


onready var _collider := find_node("Collider")
onready var _reload_timer := find_node("ReloadTimer")
onready var despawn_timer := find_node("DespawnTimer")
onready var _death_tween := find_node("DeathTween")
onready var _sprite := find_node("Sprite")
onready var _death_particles := find_node("DeathParticles")
onready var _death_timer := find_node("DeathAnimationTimer")
onready var _death_sound := find_node("DeathSound")

func _ready() -> void:
	# warning-ignore:return_value_discarded
	_reload_timer.connect("timeout", self, "_on_reload_timer_timeout")
	# warning-ignore:return_value_discarded
	despawn_timer.connect("timeout", self, "_on_despawn_timer_timeout")
	# warning-ignore:return_value_discarded
	_death_timer.connect("timeout", self, "_on_death_timer_timeout")


func _physics_process(_delta) -> void:
	if not _has_fired:
		_has_fired = true
		_reload_timer.start(rand_range(0.6, 3))
		emit_signal("fired", 0, position)


func _on_killed(_name: String) -> void:
	if _name == name:
		_die()


func _on_reload_timer_timeout() -> void:
	_has_fired = false


func _on_despawn_timer_timeout() -> void:
	queue_free()


func _on_death_timer_timeout() -> void:
	queue_free()



func _die() -> void:
	_death_sound.play()
	_collider.disabled = true
	_death_tween.interpolate_property(_sprite, "modulate",
		Color("ffffff"), Color("000000"), 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_death_tween.interpolate_property(_sprite, "scale",
		Vector2(5,5), Vector2(0,0), 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_death_particles.emitting = true
	_death_tween.start()
	_death_timer.start()
