extends TextureRect

var backgroundPicture = preload("res://Textures/title/title_background.png")
var gameTitleFont = preload("res://Fonts/title_dynamic_font.tres")

func _ready():
	texture = backgroundPicture
	get_child(0).add_font_override("font",gameTitleFont)
	pass