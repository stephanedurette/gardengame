extends "res://GameObjects/Enemies/Critter/Critter.gd"

export var can_jump = true
export var is_dead = false

var labelOffset = Vector2(-35, -75)

func _handle_init():
	$Anim.play("Idle")

func _handle_move(delta):
	$ColorLabel.rect_position = $Sprite.position + labelOffset
	if is_dead:
		$Sprite.position += Vector2(8, -5)
	else:
		$Anim.play("Running")
		if can_jump:
			position.x -= moveSpeed * delta
			$CollisionShape2D.position = $Sprite.position