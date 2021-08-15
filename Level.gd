extends Node2D

#export (PackedScene) var Food
export (PackedScene) var Coin
signal back_to_menu_level


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(20):
		$ItemPath/ItemSpawnLocation.offset = randi()
		var coin = preload("res://Coin.tscn").instance()
		add_child(coin)
		coin.position = $ItemPath/ItemSpawnLocation.position
	for i in range(30):
		$ItemPath/ItemSpawnLocation.offset = randi()
		var food = preload("res://src/Food.tscn").instance()
		add_child(food)
		food.position = $ItemPath/ItemSpawnLocation.position
	for i in range(10):
		$EnemyPath/EnemySpawnLocation.offset = randi()
		var enemy= preload("res://src/Character/Enemy.tscn").instance()
		add_child(enemy)
		enemy.position = $EnemyPath/EnemySpawnLocation.position
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.x > $EndPosition.position.x:
		$Player.position = $StartPosition.position
		_ready()
	elif $Player.position.x < $StartPosition.position.x:
		$Player.position = $StartPosition.position


func _on_BackButton_pressed():
	emit_signal("back_to_menu_level", 'Level')
