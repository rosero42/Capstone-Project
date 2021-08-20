extends Node2D

#export (PackedScene) var Food
#export (PackedScene) var Coin
signal back_to_menu
signal game_over
var roundnum = 1
var speedinc = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(10):
		$ItemPathGround/ItemGroundSpawnLocation.offset = randi()
		var coin = preload("res://src/Coin.tscn").instance()
		add_child(coin)
		coin.position = $ItemPathGround/ItemGroundSpawnLocation.position
	for i in range(10):
		$ItemPathPlatform/ItemPathPlatformSpawn.offset = randi()
		var coin = preload("res://src/Coin.tscn").instance()
		add_child(coin)
		coin.position = $ItemPathPlatform/ItemPathPlatformSpawn.position
	for i in range(15):
		$ItemPathGround/ItemGroundSpawnLocation.offset = randi()
		var food = preload("res://src/Food.tscn").instance()
		add_child(food)
		food.position = $ItemPathGround/ItemGroundSpawnLocation.position
	for i in range(15):
		$ItemPathPlatform/ItemPathPlatformSpawn.offset = randi()
		var food = preload("res://src/Food.tscn").instance()
		add_child(food)
		food.position = $ItemPathPlatform/ItemPathPlatformSpawn.position
	for i in range(10):
		$EnemyPath/EnemySpawnLocation.offset = randi()
		var enemy= preload("res://src/Character/Enemy.tscn").instance()
		enemy.speed.x += speedinc
		add_child(enemy)
		enemy.position = $EnemyPath/EnemySpawnLocation.position
	speedinc += 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.y > $EndPosition.position.y:
		$Player.position = $StartPosition.position
		roundnum += 1
		_ready()
	elif $Player.position.x < $StartPosition.position.x:
		$Player.position = $StartPosition.position


func _on_BackButton_pressed():
	emit_signal("back_to_menu")


func _on_Player_game_over(score):
	emit_signal("game_over", score)
