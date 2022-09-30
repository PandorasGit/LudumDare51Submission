extends "res://Bullets/Bullet.gd"


func _ready():
	_texture = load("res://Bullets/FriendlyBullet/FriendlyBullet.png")
	_sprite.texture = _texture
