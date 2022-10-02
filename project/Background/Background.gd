extends Node2D


var _star_count := 40


onready var _star := load("res://Background/Star/Star.tscn")


func _ready() -> void:
	randomize()
	for i in _star_count:
		#Instances do not have set types so type cannot be inferred
		var new_star = _star.instance()
		add_child(new_star)
		var random_position_x := rand_range(0, 1024)
		var random_position_y := rand_range(0, 600)
		new_star.position = Vector2(random_position_x, random_position_y)
