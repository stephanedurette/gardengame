extends Node2D

signal bloomed

func init(_parent, _sprite):
	$AnimationPlayer.play("Idle")
	$Sprite.texture = _sprite

func bloom():
	$AnimationPlayer.play("Bloom")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("bloomed")