extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type


# Called when the node enters the scene tree for the first time.
func _ready():
	var animation = randi() % 3 + 1
	match animation:
		1:
			$AnimatedSprite.animation = "apple"
			type = "apple"
		2:
			$AnimatedSprite.animation = "chicken"
			type = "chicken"
		3:
			$AnimatedSprite.animation = "pretzel"
			type = "pretzel"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Food_area_entered(area):
	get_node("CollisionShape2D").disabled = true
	queue_free()
