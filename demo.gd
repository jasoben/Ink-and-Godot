extends Control

@onready var _ink_player = $InkPlayer
@export var choice_button_one : Button 
@export var choice_button_two : Button 
@export var choice_button_three : Button 
@export var text_label : Label

var buttons 
var prev_tag

func _ready():
	buttons = [choice_button_one, choice_button_two, choice_button_three]
	_ink_player.create_story()


func _story_loaded(successfully: bool):
	if !successfully:
		return

	_ink_player.continue_story()


func _continued(text, tags):
	text_label.text = text
	if prev_tag != null:
		get_node(prev_tag).visible = false
	for i in range(tags.size()):
		get_node(tags[i]).visible = true
		prev_tag = tags[i]
	_ink_player.continue_story()


func _prompt_choices(choices):
	if !choices.is_empty():
		for i in range(choices.size()):
			buttons[i].text = choices[i].text
			buttons[i].visible = true

func _ended():
	print("The End")


func _select_choice(index):
	for i in range(buttons.size()):
		buttons[i].visible = false
	_ink_player.choose_choice_index(index)
	_continue_story()

func _continue_story():
	_ink_player.continue_story()
