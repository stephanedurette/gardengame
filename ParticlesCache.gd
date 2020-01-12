extends CanvasLayer

var materials = [
	preload("res://Materials/Explosion.material"),
	preload("res://Materials/Trail.material"),
]

func _ready():
	for m in materials:
		var p = Particles2D.new()
		p.emitting = true
		p.one_shot = true
		p.process_material = m
		p.position = Vector2(-1000, -1000) #offscreen
		add_child(p)