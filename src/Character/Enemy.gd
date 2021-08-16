extends Character


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type = "enemy"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall() || !$RayCast2D.is_colliding():
		$RayCast2D.position.x *= -1
		$RayCast2D.rotation *= -1
		_velocity.x *= -1.0
		if $AnimatedSprite.flip_h == false:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y




func _on_StompArea_body_entered(body):
	if body.global_position.y > get_node("StompArea").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()
