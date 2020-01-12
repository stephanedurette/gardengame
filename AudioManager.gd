extends Node2D

onready var sounds = {
	"hit": $Sounds/Hit,
	"menu_select": $Sounds/MenuSelect,
	"game_over": $Sounds/GameOver,
	"miss": $Sounds/Miss,
	"shoot": $Sounds/Shoot,
	"switch": $Sounds/Switch,
	"text": $Sounds/Text
}

onready var musics = {
	"main": load("res://Assets/Sounds/music.wav"),
	"boss": load("res://Assets/Sounds/boss_music.wav"),
}

func _ready():
	playmusic("main")

func playsound(var soundString):
	if !sounds.has(soundString): return
	sounds[soundString].play()

func playmusic(var musicString):
	if !musics.has(musicString): return
	$Music.stream = musics[musicString]
	$Music.play()

func stopmusic():
	$Music.stop()

func stop(var soundString):
	sounds[soundString].stop()