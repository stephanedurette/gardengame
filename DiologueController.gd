extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var timer = $Timer
onready var textBox = $TextBox

var enabled = false
var currentPage
var currentDialog

signal message_handled

func init(parent):
	animationPlayer.play("Idle")
	timer.connect("timeout", self, "_on_Timer_Timeout")

func beginMessage(var dialog: Array): #dialog is an array of strings
	currentPage = 0
	textBox.set_visible_characters(0)
	textBox.set_bbcode(dialog[currentPage])
	enabled = true
	currentDialog = dialog.duplicate()
	globals.player.enabled = false
	animationPlayer.play("Enter")
	yield(animationPlayer, "animation_finished")
	AudioManager.playsound("text")
	timer.start()
	
func _process(delta):
	if textBox.get_visible_characters() >= textBox.get_total_character_count():
		AudioManager.stop("text")
	if Input.is_action_just_pressed("shoot") and enabled:
		if textBox.get_visible_characters() > textBox.get_total_character_count():
			if currentPage < currentDialog.size() - 1:
				currentPage += 1
				textBox.set_bbcode(currentDialog[currentPage])
				textBox.set_visible_characters(0)
				AudioManager.playsound("text")
			else:
				enabled = false
				AudioManager.stop("text")
				timer.stop()
				animationPlayer.play("Exit")
				yield(animationPlayer, "animation_finished")
				globals.player.enabled = true
				emit_signal("message_handled")
				
		else:
			textBox.set_visible_characters(textBox.get_total_character_count())
			AudioManager.stop("text")
	
func _on_Timer_Timeout():
	textBox.set_visible_characters(textBox.get_visible_characters() + 1)
	
