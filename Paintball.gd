extends Area2D

export (Array, Color) var colors = [Color.blue, Color.red, Color.yellow]
export (float) var bulletSpeed = 400

var color
var velocity
var max_y_pos
export var enabled = true #used by the animation player

func init(_color, _velocity, _max_y_pos):
	connect("area_entered", self, "_on_Area_Entered")
	color = _color
	max_y_pos = _max_y_pos
	modulate = colors[color]
	velocity = _velocity
	$Anim.play("Flight")
	$PaintTrail.rotation = atan2(velocity.y, velocity.x) + PI
	

func _process(delta):
	if !enabled: return
	position += velocity * bulletSpeed * delta
	if (max_y_pos != -1 and global_position.y >= max_y_pos + 100):
		$Anim.play("Hit")
		AudioManager.playsound("miss")
		$PaintTrail.emitting = false
	if position.x > globals.maxBulletX:
		$PaintTrail.emitting = false
		$Anim.play("Hit")
		
	#if the position is offscreen delete self

func _on_Area_Entered(area): 
	if !area.has_method("hit"): return 
	area.hit(color)
	$Anim.play("Hit")
	AudioManager.playsound("hit")
	$Explosion.emitting = true
	$PaintTrail.emitting = false
	
