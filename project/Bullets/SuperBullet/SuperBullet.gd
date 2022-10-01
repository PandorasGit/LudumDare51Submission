extends Bullet

func _ready() -> void:
	_id = 2
	_texture = load("res://Bullets/SuperBullet/SuperBullet.png")
	_sprite.texture = _texture
