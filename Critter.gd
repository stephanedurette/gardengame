extends Area2D

export (Array, Color) var colors = [Color.blue, Color.red, Color.yellow, Color.purple, Color.green, Color.orange, Color.magenta, Color(227, 66, 52), Color.violet, Color.teal, Color(255,191,0), Color.chartreuse, Color.white]
var moveSpeed = 400
var targetColors = []
var color
export var isEnabled = true

signal died

func init(_parent, _color, _position, _moveSpeed, _amplitude = -1, _frequency = -1):
	connect("died", _parent, "_on_Critter_Died")
	position = _position
	color = _color
	moveSpeed = _moveSpeed
	targetColors = globals.ColorComponents[_color].duplicate()
	if color != globals.Colors.White:
		$ColorLabel.text = globals.ColorStrings[_color]
		$ColorLabel.modulate = colors[_color]
	_handle_init()

func _process(delta):
	_handle_move(delta)
	if position.x < 0:
		get_parent().handleGameOver()
	
func hit(_ball_color):
	
	if targetColors.has(_ball_color):
		targetColors.erase(_ball_color)
		$Sprite.modulate = colors[_ball_color]
	if targetColors.size() == 0:
		$Sprite.modulate = colors[color]
		$Anim.play("Death")
		yield($Anim, "animation_finished")
		emit_signal("died")
	
func _handle_move(delta):
	pass #this is handled by children

func _handle_init():
	pass #handled by children

