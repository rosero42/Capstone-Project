extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var playername


# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	playername = $TextEdit.text
	print(playername)
	SilentWolf.Scores.persist_score(playername, score)
	#yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	#print("Scores: " + str(SilentWolf.Scores.scores))
	SilentWolf.Scores.get_high_scores()
	$Title.hide()
	$ScoreLabel.hide()
	$Score.hide()
	$TextEdit.hide()
	$Button.hide()
	load_leaderboard()

func load_leaderboard():
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
