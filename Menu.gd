extends CanvasLayer
signal load_instructions
signal create_game
signal load_about

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InstructionsButton_pressed():
	emit_signal("load_instructions")


func _on_PlayButton_pressed():
	emit_signal("create_game")


func _on_AboutButton_pressed():
	emit_signal("load_about")
