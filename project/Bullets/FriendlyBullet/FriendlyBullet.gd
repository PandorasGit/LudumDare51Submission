class_name FriendlyBullet
extends Bullet


func _ready() -> void:
	_id = 1


func _setup_tween() -> void:
	_tween.interpolate_property(_sprite, "modulate",
		Color("0cddd8"), Color("061b6e"), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(_sprite, "scale",
		Vector2(3, 4), Vector2(4, 4), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT )
