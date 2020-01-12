extends Control

onready var playButton = get_node("CenterContainer/Control/VBox/PlayButton")

func _ready():
	playButton.connect("button_down", self, "startGame")

func changeScreen(scene):
	AudioManager.playsound("menu_select")
	sceneManager.change_scene(scene)
	
func startGame():
	globals.checkpoint = 0
	globals.currentFlowers = 0
	AudioManager.playsound("menu_select")
	sceneManager.change_scene("res://Screens/TestLevel.tscn")