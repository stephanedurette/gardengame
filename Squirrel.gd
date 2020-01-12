extends "res://GameObjects/Enemies/Critter/Critter.gd"

func _handle_init():
	$Anim.play("Idle")

func _handle_move(delta):
	if isEnabled:
		$Anim.play("Running")
		position.x -= moveSpeed * delta

