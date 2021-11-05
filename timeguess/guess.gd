extends Control

onready var label := find_node("label") as Label
onready var c1 := find_node("c1") as ColorRect
onready var c2 := find_node("c2") as ColorRect

var color := Color.white

func _ready():
	
	yield(get_tree(), "idle_frame")
	set_colors()
	pass

func setup(guess_initials:String, c:Color):
	label.text = guess_initials
	self.color = c
	pass

func set_colors():
	c1.color = color
	c2.color = color
