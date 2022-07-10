extends CanvasLayer

func _ready():
	$Control/TextureRect/HBoxContainer/LifeCount.text = "3"
	$Control/TextureRect/HBoxContainer/CoinCount.text = "0"


func updateLives(lives_left):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	

func updateCoins(current_coins):
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(current_coins)
