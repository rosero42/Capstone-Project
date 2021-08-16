extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var menu = preload("res://Menu.tscn").instance()
	add_child(menu)
	menu.connect("load_instructions", self, "_load_instructions")
	menu.connect("create_game", self, "_create_game")
	menu.connect("load_about", self, "_load_about")


func _load_instructions():
	print("_load_instructions")
	var instructions_page = preload("res://Instructions.tscn").instance()
	add_child(instructions_page)
	instructions_page.connect("back_to_menu", self, "_back_to_menu")

func _back_to_menu(scene):
	remove_child(get_node(scene))


func _create_game():
	print("_create_game")
	var game = preload("res://Level.tscn").instance()
	add_child(game)
	remove_child(get_node("Menu"))
	game.connect("back_to_menu", self, "_back_from_level")
	print_tree()

func _load_about():
	print("_load about")
	var about = preload("res://About.tscn").instance()
	add_child(about)
	about.connect("back_to_menu", self, "_back_to_menu")
	

func _back_from_level():
	#print("back from level")
	var menu = preload("res://Menu.tscn").instance()
	add_child(menu)
	menu.connect("load_instructions", self, "_load_instructions")
	menu.connect("create_game", self, "_create_game")
	menu.connect("load_about", self, "_load_about")
	remove_child(get_node("Level"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
