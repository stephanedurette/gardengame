extends Node2D

enum Stages {SpawnSquirrel = 0, Run, SpawnRabbits, Jump, SpawnBirds, Fly}

signal died
var spawner
var startingPosition
var enabled = true
export var airbourne = false

var currentStage = Stages.SpawnSquirrel
export var runSpeed = 100
export var jumpDistance = 200

var shuffleDir
var maxShuffleDistance = 100

func init(_spawner):
	spawner = _spawner

func _ready():
	connect("died",spawner, "_on_boss_died")
	$AnimationPlayer.play("Enter")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("TextEnter")
	yield($AnimationPlayer, "animation_finished")
	startingPosition = global_position
	$Area2D.init(self)
	$TextManager.init(self)
	$ColorManager.init(self)
	_enter_stage()

func _enter_stage():
	match currentStage:
		Stages.SpawnSquirrel:
			$TextManager.print_text("I Can Taste them already!")
			$AnimationPlayer.play("SpawnSquirrels")
		Stages.Run:
			$TextManager.print_text("Those flowers are MINE")
			$AnimationPlayer.play("Running")
		Stages.SpawnRabbits:
			shuffleDir = 1
			$AnimationPlayer.play("JumpBack")
			yield($AnimationPlayer, "animation_finished")
			position = startingPosition
			$AnimationPlayer.play("Enter")
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("TextEnter")
			yield($AnimationPlayer, "animation_finished")
			$TextManager.print_text("I Might Even Leave you one when i'm done")
			$AnimationPlayer.play("SpawnRabbits")
		Stages.Jump:
			$TextManager.print_text("GIMME!!!!!")
			$AnimationPlayer.play("Jumping")
		Stages.SpawnBirds:
			enabled = false
			shuffleDir = 1
			$AnimationPlayer.play("JumpBack")
			yield($AnimationPlayer, "animation_finished")
			position = startingPosition
			$AnimationPlayer.play("Enter")
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("TextEnter")
			yield($AnimationPlayer, "animation_finished")
			$TextManager.print_text("After I'm done, I'll eat everything in your greenhouse too!")
			$AnimationPlayer.play("SpawnBirds")
			enabled = true
		Stages.Fly:
			$TextManager.print_text("OM NOM NOM NOM!!")
			$AnimationPlayer.play("Jumping")
func _process(delta):
	if !enabled: return
	_check_death()
	match currentStage:
		Stages.SpawnSquirrel:
			pass
		Stages.Run:
			position.x -= delta * runSpeed
		Stages.SpawnRabbits:
			position.y += shuffleDir * delta * runSpeed
			if position.y > startingPosition.y + maxShuffleDistance:
				shuffleDir = -shuffleDir
			elif position.y < startingPosition.y - maxShuffleDistance:
				shuffleDir = -shuffleDir
		Stages.Jump:
			if airbourne:
				position.x -= delta * jumpDistance
		Stages.SpawnBirds:
			position.y += shuffleDir * delta * runSpeed
			if position.y > startingPosition.y + maxShuffleDistance:
				shuffleDir = -shuffleDir
			elif position.y < startingPosition.y - maxShuffleDistance:
				shuffleDir = -shuffleDir
		Stages.Fly:
			if airbourne:
				position.x -= delta * jumpDistance

func _check_death():
	if position.x < 0:
		enabled = false
		get_parent().handleGameOver()

func hit(_ball_color):
	$ColorManager.hit(_ball_color)

func _on_ColorManager_IncrementState():
	currentStage += 1
	_enter_stage()

func _on_ColorManager_Dead():
	enabled = false
	$AnimationPlayer.play("JumpBack")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("died")
	
func spawn_squirrels():
	spawner.spawnWave("boss_squirrel")

func spawn_rabbits():
	spawner.spawnWave("boss_rabbit")
	
func spawn_birds():
	spawner.spawnWave("boss_bird")
	
	
	
	
	
	
	
	
	
	
	
	