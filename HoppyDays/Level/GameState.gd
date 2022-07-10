extends Node2D

var lives = 3
var coins = 0
var life_up_target = 10

func _ready():
	add_to_group("Gamestate")
	update_GUI()


func hurt():
	lives -= 1
	$Player.hurt()
	print(lives)
	update_GUI()
	if lives < 0:
		end_game()


func update_GUI():
	get_tree().call_group("GUI", "updateLives", lives)


func coin_up():
	coins += 1
	get_tree().call_group("GUI", "updateCoins", coins)
	if (coins % life_up_target) == 0:
		lives += 1
		update_GUI()


func end_game():
	get_tree().change_scene("res://Level/EndGame.tscn")
