extends Control

var PLAYER_WORDS = []
var current_story = {}

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText


func _ready():
	pick_current_story()
	DisplayText.text = "Welcome to a short game used to learn godot basics, we are going to make a story together!!!  \n\n"
	check_player_words_length()


func pick_current_story():
	randomize() # re shuffles "cards", randi takes top
	
	# Node based solution
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story).prompts
	current_story.story = $StoryBook.get_child(selected_story).story
	
	# Json Version
	#var stories = get_from_json("StoryBook.json")
	#current_story = stories[randi() % stories.size()]


func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data


func _on_PlayerText_text_entered(new_text):
	add_ToPlayerWords()
	

func _on_TextureButton_pressed():
	if not is_story_done():
		add_ToPlayerWords()
	else:
		get_tree().reload_current_scene()

func update_DisplayText(words):
	DisplayText.text = words
	PlayerText.clear()


func add_ToPlayerWords():
	PLAYER_WORDS.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()


func is_story_done():
	return PLAYER_WORDS.size() == current_story.prompts.size()
	
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()


func tell_story():
	DisplayText.text = current_story.story % PLAYER_WORDS


func prompt_player():
	DisplayText.text += "Please enter " + current_story.prompts[PLAYER_WORDS.size()]


func end_game():
	#PlayerText.visible = false
	PlayerText.queue_free()
	tell_story()
	#$"VBoxContainer/HBoxContainer/TextureButton".queue_free()
