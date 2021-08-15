extends Character


# member variables
var direction: = Vector2.ZERO
var score = 0
var health = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = str(score)

func _physics_process(delta: float) -> void:
	if health > 0:
		update_health(-0.5)
		if health == 0:
			print("health depleted")
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	direction = get_direction()
	if direction.y == 1:
		$AnimatedSprite.animation = "jump"
	elif direction.x == 1:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = false
	elif direction.x == -1:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.animation = "default"
	_velocity = calc_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)


func calc_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity


func _on_ItemDetector_area_entered(area):
	if not area.get("type") == null:
		print(area.type)
		handle_item(area.type)

func handle_item(type):
	if type == "coin":
		score += 1
		$Score.text = str(score)
	else:
		update_health(200)

func update_health(value):
	health += value
	if health <= $HealthBar.max_value:
		$HealthBar.set_value(health)
	else:
		health -= value


func _on_EnemyDetector_body_entered(body):
	print("Enemy Detected")
