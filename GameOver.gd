extends Control

onready var mainMenuButton = get_node("CenterContainer/VBox/MainMenu")
onready var restartButton = get_node("CenterContainer/VBox/Restart")

func _ready():
	mainMenuButton.connect("button_down", self, "changeScreen", ["res://Screens/MainMenu.tscn"])
	restartButton.connect("button_down", self, "changeScreen", ["res://Screens/TestLevel.tscn"])

func changeScreen(scene):
	AudioManager.playmusic("main")
	AudioManager.playsound("menu_select")
	sceneManager.change_scene(scene)