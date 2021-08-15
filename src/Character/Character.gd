extends KinematicBody2D
class_name Character

#constants
const FLOOR_NORMAL = Vector2.UP
# member variables
export var gravity: = 3000.0
export var speed: = Vector2(300.0,1000.0)
var _velocity: = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
