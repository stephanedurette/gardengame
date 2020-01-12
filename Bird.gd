extends "res://GameObjects/Enemies/Critter/Critter.gd"

export var is_dead = false

var labelOffset = Vector2(-35, -55)

export (Vector2) var shadowMinScale
export (Vector2) var shadowMaxScale

export var amplitude = 50
export var frequency = 1

var time = 0
var dir = 1



func init(_parent, _color, _position, _moveSpeed, _amplitude = -1, _frequency = -1):
	connect("died", _parent, "_on_Critter_Died")
	amplitude = _amplitude
	frequency = _frequency
	position = _position
	color = _color
	moveSpeed = _moveSpeed
	targetColors = globals.ColorComponents[_color].duplicate()
	if color != globals.Colors.White:
		$ColorLabel.text = globals.ColorStrings[_color]
		$ColorLabel.modulate = colors[_color]
	_handle_init()

func _handle_init():
	$Anim.play("Idle")

func _handle_move(delta):
	if isEnabled:
		time += delta
		var yChange = amplitude * sin(time * frequency)
		var newDir = sign(yChange)
		$Anim.play("Running")
		position.x -= moveSpeed * delta
		position.y -= yChange
		$Shadow.position.y += yChange / 2
		
		if dir != newDir:
			if newDir == -1:
				$Tween.interpolate_property($Shadow, "scale", $Shadow.scale, shadowMaxScale, PI / frequency , $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
			else:
				$Tween.interpolate_property($Shadow, "scale", $Shadow.scale, shadowMinScale, PI / frequency , $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
			$Tween.start()
			dir = newDir
		
		
		
		
		
		