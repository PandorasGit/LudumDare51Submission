class_name Bullet
extends KinematicBody2D


signal killed


export var _direction_fired: = Vector2.DOWN
export var _speed := 100
export var _color:= Color("ffffff")


var _id := 0
var _velocity := Vector2.ZERO


onready var _sprite := find_node("Sprite")
onready var _texture := load("res://Bullets/DefaultBullet.png")
onready var _despawn_timer := find_node("DespawnTimer")


func _ready() -> void:
	_sprite.texture = _texture
	_sprite.modulate = _color
# warning-ignore:return_value_discarded
	_despawn_timer.connect("timeout", self, "on_despawn_timer_timeout")


func _physics_process(_delta: float) -> void:
	_velocity = move_and_slide(_direction_fired * _speed, Vector2.UP)
	
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		if collision.collider.is_in_group("target"):
			emit_signal("killed")


func on_despawn_timer_timeout() -> void:
	queue_free()


func startTimer() -> void:
	_despawn_timer.start()
