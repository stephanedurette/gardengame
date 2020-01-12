extends Node2D

export (PackedScene) var flower
export (Array, Texture) var flowerSprites

onready var flowerPositions = get_children()
var flowers = []

signal flowers_bloomed

func init(parent):
	for pos in flowerPositions:
		var f = flower.instance()
		f.position = pos.position
		var sprite = flowerSprites[randi() % flowerSprites.size()]
		f.init(self, sprite)
		parent.add_child(f)
		flowers.append(f)
	#bloomRandomFlowers(20)

func bloomRandomFlowers(num_flowers, fast_spawn = false):
	var count = num_flowers if num_flowers <= flowers.size() else flowers.size()
	for i in range(count):
		var randIndex = randi() % flowers.size()
		var f = flowers[randIndex]
		f.bloom()
		if !fast_spawn:
			yield(f, "bloomed")
		flowers.remove(randIndex)
	if fast_spawn:
		yield(get_tree().create_timer(1.0), "timeout")
	emit_signal("flowers_bloomed")
