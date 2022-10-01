class_name Bullet
extends KinematicBody2D


export var _direction_fired: = Vector2.DOWN
export var _speed := 100
export var _color:= Color("ffffff")


var _id := 0
var _velocity := Vector2.ZERO


onready var _sprite := find_node("Sprite")
onready var _texture := load("res://Bullets/DefaultBullet.png")


func _ready() -> void:
	_sprite.texture = _texture
	_sprite.modulate = _color


func _physics_process(_delta: float) -> void:
	_velocity = move_and_slide(_direction_fired * _speed, Vector2.UP)
	
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		if collision.collider.is_in_group("target"):
			print("Hit a target")
