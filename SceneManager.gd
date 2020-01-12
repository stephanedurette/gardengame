extends CanvasLayer

onready var anim = $AnimationPlayer

signal faded_in

func _ready():
	anim.play("Idle")

func change_scene(newScenePath):
	anim.play("FadeOut")
	yield(anim, "animation_finished")
	print("done")
	get_tree().change_scene(newScenePath)
	anim.play("FadeIn")
	yield(anim, "animation_finished")
	emit_signal("faded_in")