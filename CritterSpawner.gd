extends Node2D

export(PackedScene) var boss

export (PackedScene) var rabbit;
export (PackedScene) var squirrel;
export (PackedScene) var bird;

var currentEnemies = 0
var enabled = true
onready var spawnPositions = get_children()

export var wave_finished = false #controlled by the animation player

var waves = {}

signal wave_cleared
signal boss_died

func init(_parent):
	spawnPositions.remove(0) # remove the timer node
	_load_waves()

func _load_waves():
	var file = File.new()
	file.open("res://Data/waves.json", file.READ)
	var text = file.get_as_text()
	waves = JSON.parse(text).result
	file.close()
	#print(waves)
	
func spawnWave(name: String):
	enabled = true
	currentEnemies = 0
	wave_finished = false
	for spawn in waves[name]:
		if spawn.type == 0:
			spawn_squirrel(spawn.color, spawn.position, spawn.movespeed)
		elif spawn.type == 1:
			spawn_rabbit(spawn.color, spawn.position, spawn.movespeed)
		elif spawn.type == 2:
			spawn_bird(spawn.color, spawn.position, spawn.movespeed, spawn.amplitude, spawn.frequency)

		if spawn.delay == 0: continue
		$Timer.start(spawn.delay)
		yield($Timer, "timeout")
	wave_finished = true
	
func _process(delta):
	if wave_finished and currentEnemies == 0 and enabled:
		emit_signal("wave_cleared")
		enabled = false
	
func spawn_squirrel(color: int, spawnPositionIndex: int, moveSpeed: int):
	currentEnemies += 1
	var s = squirrel.instance()
	s.init(self, color, spawnPositions[spawnPositionIndex].position, moveSpeed)
	get_parent().call_deferred("add_child", s)
	
func spawn_rabbit(color: int, spawnPositionIndex: int, moveSpeed: int):
	currentEnemies += 1
	var s = rabbit.instance()
	s.init(self, color, spawnPositions[spawnPositionIndex].position, moveSpeed)
	get_parent().call_deferred("add_child", s)
	
func spawn_bird(color: int, spawnPositionIndex: int, moveSpeed: int, amplitude: int, frequency: int):
	currentEnemies += 1
	var s = bird.instance()
	s.init(self, color, spawnPositions[spawnPositionIndex].position, moveSpeed, amplitude, frequency)
	get_parent().call_deferred("add_child", s)
	
func spawn_boss():
	currentEnemies += 1
	var s = boss.instance()
	s.position = get_node("../BossPosition").position
	s.init(self)
	get_parent().call_deferred("add_child", s)
	
func _on_Critter_Died():
	currentEnemies -= 1
	print(currentEnemies)
	
func _on_boss_died():
	emit_signal("boss_died")
	
	
	
	
	