extends Node

onready var textBox = get_node("../Text")

var boss

func init(_boss):
	boss = _boss
	
func print_text(text):
	get_node("../Text").set_bbcode(text)