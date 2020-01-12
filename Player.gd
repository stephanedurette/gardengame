extends Node2D

export (PackedScene) var paintBall

export (Array, Texture) var brushColors 
var switchAnimationColors = ["switch_blue", "switch_red", "switch_yellow"]

var enabled = true
var color
export var can_shoot = true #used by the animation player
export var can_switch = true #used by the animation player

signal shoot
signal switch

func _ready():
	globals.player = self
	color = globals.Colors.Blue
	$Brush_Anim.play("Setup")
	$Palette_Anim.play("Setup")
	
func _process(delta):
	if not enabled: return
	if Input.is_action_pressed("shoot") and can_shoot and can_switch:
		$Brush_Anim.play("Shoot")
		emit_signal("shoot")
	if Input.is_action_pressed("switch") and can_switch:
		$Palette_Anim.play(switchAnimationColors[color])
		emit_signal("switch")
		AudioManager.playsound("switch")
	

func shoot_paintball():
	AudioManager.playsound("shoot")
	$BrushPivot/BrushSprite.texture = brushColors[globals.Colors.White]
	var p = paintBall.instance()
	var mousePos = get_global_mouse_position()
	var velocity = (mousePos - $ShootPosition.global_position).normalized()
	var explodePos = mousePos.y if mousePos.y > globals.minGroundY else -1
	p.init(color, velocity, explodePos)
	p.position = $ShootPosition.position
	add_child(p)

func rotate_brush_color():
	color = (color + 1) % 3
	reset_brush_color()

func reset_brush_color():
	$BrushPivot/BrushSprite.texture = brushColors[color]
