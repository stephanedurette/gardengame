extends Node

signal increment_state
signal dead

export (Array, Color) var spriteColors = [Color.blue, Color.red, Color.yellow, Color.purple, Color.green, Color.orange,Color.white]

var colors = [
	[globals.Colors.White, globals.Colors.Blue, globals.Colors.Yellow, ], # spawn squirrels
	[globals.Colors.Red, globals.Colors.Blue, globals.Colors.Red, ], # run
	[globals.Colors.Yellow, globals.Colors.Green, globals.Colors.Orange, ], # spawn rabbits
	[globals.Colors.Purple, globals.Colors.Orange, globals.Colors.Red, ], # jump
	[globals.Colors.Orange, globals.Colors.Blue, globals.Colors.Green, ], # spawn birds
	[globals.Colors.Blue, globals.Colors.Red, globals.Colors.Yellow, ], # fly
]
var boss
var currentColor = 0
var lives = 6
var targetColors = []
var enabled = true

onready var textBox = get_node("../Text")
onready var bodySprite = get_node("../Sprite")
onready var tween = get_node("../Tween")

func _ready():
	pass
	#_set_colors()

func init(_boss):
	boss = _boss
	connect("increment_state", boss, "_on_ColorManager_IncrementState")
	connect("dead", boss, "_on_ColorManager_Dead")
	_set_colors()

func _set_colors():
	var col = colors[boss.currentStage][currentColor]
	targetColors = globals.ColorComponents[col].duplicate()
	_change_text_color(spriteColors[col])

func hit(_ball_color):
	if !enabled: return
	if targetColors.has(_ball_color):
		targetColors.erase(_ball_color)
		bodySprite.modulate = spriteColors[_ball_color]
		bodySprite.modulate.a = 1
	if targetColors.size() == 0:
		bodySprite.modulate = spriteColors[-1]
		bodySprite.modulate.a = 1
		currentColor += 1
		if currentColor > 2:
			lives -= 1
			if lives <= 0:
				enabled = false
				emit_signal("dead") 
				return
			currentColor = 0
			emit_signal("increment_state")
		_set_colors()

func _change_text_color(new_color):
	print("changing")
	tween.interpolate_property(textBox,"modulate",textBox.modulate,new_color,.25,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()