extends KinematicBody2D


signal fired(id, fired_from)


var _has_fired := false


onready var _reload_timer := find_node("ReloadTimer")


func _ready() -> void:
# warning-ignore:return_value_discarded
	_reload_timer.connect("timeout", self, "_on_reload_timer_timeout")


func _physics_process(_delta) -> void:
	if not _has_fired:
		_has_fired = true
		_reload_timer.start()
		emit_signal("fired", 0, self)


func _on_killed(_name: String) -> void:
	if _name == name:
		queue_free()


func _on_reload_timer_timeout() -> void:
	_has_fired = false
