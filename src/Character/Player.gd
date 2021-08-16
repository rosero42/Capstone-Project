extends Character


# member variables
var direction: = Vector2.ZERO
var score = 0
var health = 1000
var timer_arr = []
signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = str(score)
	$Stuck.hide()
	$GameOver.hide()

func _physics_process(_delta: float) -> void:
	if health > 0:
		update_health(-0.5)
		if health == 0:
			game_over()
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
	else:
		print("enemy collision")

func handle_item(type):
	if type == "coin":
		score += 1
		$Score.text = str(score)
	elif type == "enemy":
		pass
	else:
		update_health(200)

func update_health(value):
	health += value
	if health <= $HealthBar.max_value:
		$HealthBar.set_value(health)
	else:
		health -= value


func _on_EnemyDetector_body_entered(_body):
	print("Enemy Detected")
	$AnimatedSprite.animation = "hit"
	if speed.x -100 >= 0:
		var timer = Timer.new()
		timer.connect("timeout", self, "_remove_penalty")
		add_child(timer)
		timer.start(30)
		add_child(timer)
		speed.x -= 100
		if speed.x == 0:
			$Stuck.show()
		timer_arr.append(timer)
	else:
		$Stuck.show()

func _remove_penalty():
	speed.x += 100
	print("penalty removed")
	timer_arr.front().stop()
	timer_arr.pop_front()
	$Stuck.hide()

func game_over():
	$GameOver.show()
	$Stuck.hide()
	#get_tree().paused = true
	set_physics_process(false)
	$GameOverTimer.start()


func _on_GameOverTimer_timeout():
	$GameOverTimer.stop()
	emit_signal("game_over", score)
