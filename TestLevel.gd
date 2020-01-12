extends Node2D

onready var critterSpawner = $CritterSpawner
onready var diologueController = $DiologueController
onready var flowerBed = $FlowerBed

var gameOver = false
var firstOpen = true

func _ready():
	_set_globals()
	critterSpawner.init(self)
	flowerBed.init(self)
	diologueController.init(self)
	begin_gameplay(globals.checkpoint)

func begin_gameplay(var checkpoint):
	if firstOpen:
		firstOpen = false
		yield(sceneManager, "faded_in")
		if globals.currentFlowers > 0:
			flowerBed.bloomRandomFlowers(globals.currentFlowers, true)
			yield(flowerBed, "flowers_bloomed")
	
	match checkpoint:
		0:
			diologueController.beginMessage(
				[
					"hello, I'm roger the rabbit", 
					"there are some hungry critters eager to feast on your plants",
					"you must master the art of the brush to fend them off",
					"left click anywhere on the screen to fling paint"
				]
			)
			yield(diologueController, "message_handled")
			yield(globals.player, "shoot")
			diologueController.beginMessage(
				[
					"well done", 
					"uh oh", 
					"here come a bunch of squirrels eager to eat the buds of your flowers before they've even grown!",
					"you know what to do", 
				]
			)
			yield(diologueController, "message_handled")
		1:
			critterSpawner.spawnWave("colorless_squirrels")
			yield(critterSpawner, "wave_cleared")
			
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		2:
			diologueController.beginMessage(
				[
					"Good job dealing with those bushy tailed bastards.",
					"Hey look!, some of your flowers have bloomed!",
					"You should protect them until they are all grown",
					"some enemies can only be defeated by certain colors",
					"right click to change colors then left click to fling paint"
				]
			)
			yield(diologueController, "message_handled")
			yield(globals.player, "switch")
			yield(globals.player, "shoot")
			diologueController.beginMessage(
				[
					"Well done!",
					"Here come some more squirrels.",
					"Are they hungry or just trying to avenge their friends?",
					"no matter",
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("colored_squirrels")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		3:
			diologueController.beginMessage(
				[
					"You slaughtered them! good job!",
					"Don't let a single critter pass!",
					"oh..",
					"well this is awkward.."
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("rabbits")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		4:	
			diologueController.beginMessage(
				[
					"A green squirrel?",
					"Your palette doesn't have that color..",
					"How do you make green?",
					"Here he comes!"
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("green_squirrel")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		5:
			diologueController.beginMessage(
				[
					"Good thing you figured that out",
					"And just in time too!",
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("secondary_colors")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		6:
			diologueController.beginMessage(
				[
					"You must be wondering if the animals you hit are being injured or chased away.",
					"They're dead."
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("first_birds")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		7: 
			diologueController.beginMessage(
				[
					"Do you think they feel pain?",
					"doesn't matter, we're so close!"
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("first_mix")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		8:
			diologueController.beginMessage(
				[
					"Almost there!",
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("second_mix")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		9:
			diologueController.beginMessage(
				[
					"Only a few more murders!",
					"*Ahem, minutes"
				]
			)
			yield(diologueController, "message_handled")
			critterSpawner.spawnWave("third_mix")
			yield(critterSpawner, "wave_cleared")
			_bloom_flowers(5)
			yield(flowerBed, "flowers_bloomed")
		10:
			AudioManager.stopmusic()
			diologueController.beginMessage(
				[
					"It's done!",
					"What a delicious looking garden!",
					"ha..",
					"haha...",
					"HAHAHAHAHAHAHAHAHAHAHAHAHHAHAHAHAHAHA!!!!!!!!!!!!",
					"I've waited so long!!",
					"To eat them when they're fully grown"
				]
			)
			yield(diologueController, "message_handled")
			AudioManager.playmusic("boss")
			critterSpawner.spawn_boss()
			yield(critterSpawner, "boss_died")
			yield(get_tree().create_timer(2.0),"timeout")
			AudioManager.playmusic("main")
			diologueController.beginMessage(
				[
					"Oww, Fine",
					"I'll make do with bread crumbs..",
					"...For now",
				]
			)
			yield(diologueController, "message_handled")
			sceneManager.change_scene("res://Screens/Victory.tscn")
			return
			
	globals.checkpoint += 1
	begin_gameplay(globals.checkpoint)



func _set_globals():
	globals.minGroundY = $MinGroundY.position.y
	globals.maxGroundY = $MaxGroundY.position.y
	globals.maxBulletX = $MaxBulletX.position.x

func _bloom_flowers(var count):
	flowerBed.bloomRandomFlowers(count)
	globals.currentFlowers += count

func handleGameOver():
	if gameOver: return
	gameOver = true
	AudioManager.playsound("game_over")
	sceneManager.change_scene("res://Screens/GameOver.tscn")
