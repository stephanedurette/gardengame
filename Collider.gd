extends Area2D

var boss

func init(_boss):
	boss = _boss

func hit(_ball_color):
	boss.hit(_ball_color)
	
