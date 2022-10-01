class_name FriendlyBullet
extends Bullet


func _ready() -> void:
	_id = 1
	_texture = load("res://Bullets/FriendlyBullet/FriendlyBullet.png")
	_sprite.texture = _texture
