extends KinematicBody2D


export var _direction_fired: = Vector2.DOWN
export var _speed := 100

var _velocity := Vector2.ZERO

onready var _sprite := find_node("Sprite")
onready var _texture := load("res://Bullets/DefaultBullet.png")

func _ready():
	_sprite.texture = _texture


func _physics_process(_delta: float) -> void:
	_velocity = move_and_slide(_direction_fired * _speed, Vector2.UP)
