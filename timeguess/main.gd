extends Node

onready var ui := find_node("ui") as Control
onready var labels := find_node("labels") as Control

const guess_preload := preload("res://guess.tscn")


const FRI1200_UNIX := 1636138800
const SUN1200_UNIX := FRI1200_UNIX + 2*24*60*60

const guesses := {
	"JM": ["Sat", 22, 12, 34, Color.yellow],
	"TS": ["Fri", 22,14,0, Color.red],
}

func _ready():
	var ofst = 20
	for guess_name in guesses.keys():
		var guess = guesses[guess_name]
		var g = guess_preload.instance() as Control
		var p = get_percent(guess)
		
		labels.add_child(g)
		g.rect_position.x = ofst
		ofst += 40
		g.rect_position.y = labels.rect_size.y * p
#		var s = "%s: %s" % [guess_name, str(p)]
		var s = guess_name
		g.setup(s, guess[4])
	pass

func get_unix(a:Array)->int:
	var result:int = FRI1200_UNIX
	if(a[0] == "Fri"):
		result -= 12*60*60
	elif(a[0] == "Sat"):
		result += 12*60*60
	elif(a[0] == "Sun"):
		result += 36*60*60
	
	result += a[1] * 60 * 60
	result += a[2] * 60
	result += a[3]
	
	return(result)

func get_percent(a:Array)->float:
	var result:float = 0.0
	
	result = float(get_unix(a) - FRI1200_UNIX) / float(SUN1200_UNIX - FRI1200_UNIX)
	
	return(result)
