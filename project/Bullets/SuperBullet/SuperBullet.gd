extends Bullet

func _ready() -> void:
	_id = 2
	_texture = load("res://Bullets/SuperBullet/SuperBullet.png")
	_sprite.texture = _texture

func _setup_tween() -> void:
	_tween.interpolate_property(_sprite, "scale",
		Vector2(3, 4), Vector2(4, 4), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT )
