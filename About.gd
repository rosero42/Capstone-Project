extends CanvasLayer
signal back_to_menu


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	emit_signal("back_to_menu", 'About')


func _on_SPLink_pressed():
	OS.shell_open("https://www.sentencingproject.org/about-us/")


func _on_FAMMLink_pressed():
	OS.shell_open("https://famm.org/")


func _on_NAACPLink_pressed():
	OS.shell_open("https://www.naacpldf.org/about-us/")


func _on_ResearchPaperLink_pressed():
	OS.shell_open("https://docs.google.com/document/d/1CjcdIaMYjTlBSHxinNq51bPOaUBN2GKE9UpzNegWfUw/edit?usp=sharing")
