extends Control

onready var mainMenuButton = get_node("CenterContainer/VBox/MainMenu")

func _ready():
	mainMenuButton.connect("button_down", self, "changeScreen", ["res://Screens/MainMenu.tscn"])

func changeScreen(scene):
	AudioManager.playmusic("main")
	AudioManager.playsound("menu_select")
	sceneManager.change_scene(scene)
