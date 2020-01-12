extends Node
#white -1
#primary 0 - 2
#secondary 3 - 5
#tertiary 6 - 11
enum Colors {White = -1, Blue = 0, Red = 1, Yellow = 2,
			Purple, Green, Orange, 
			Magenta, Vermillion, Violet, Teal, Amber, Chartreuse
}
var ColorStrings = ["Blue", "Red", "Yellow", "Purple", "Green", "Orange", "Magenta", "Vermillion", "Violet", "Teal", "Amber", "Chartreuse", "White"]

var ColorComponents = [
	[Colors.Blue],			#blue
	[Colors.Red],			#red
	[Colors.Yellow],		#yellow
	[Colors.Blue, Colors.Red],	#purple
	[Colors.Blue, Colors.Yellow], #green
	[Colors.Red, Colors.Yellow], #orange
	[Colors.Red, Colors.Red, Colors.Blue], #magenta
	[Colors.Red, Colors.Red, Colors.Yellow], # vermillion
	[Colors.Blue, Colors.Red, Colors.Blue], # violet
	[Colors.Blue, Colors.Yellow, Colors.Blue], # teal
	[Colors.Yellow, Colors.Yellow, Colors.Red], # amper
	[Colors.Yellow, Colors.Yellow, Colors.Blue], # chartreuse
	[] #white
]

var minGroundY
var maxGroundY
var maxBulletX

var player

var checkpoint = 10
var currentFlowers = 0