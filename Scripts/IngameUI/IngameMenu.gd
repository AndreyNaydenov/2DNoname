extends VBoxContainer

var buttonPicture = preload("res://Textures/title_button.png")
var buttonPictureHovered = preload("res://Textures/title_button_hovered.png")
var buttonPicturePressed = preload("res://Textures/title_button_pressed.png")
var textFont = preload("res://Fonts/dynamic_font.tres")

func _ready():	
	
	get_child(0).connect("pressed", self, "_on_ContinueButton_pressed")
	get_child(2).connect("pressed", self, "_on_QuitButton_pressed")
	
	for i in range(0, 3):
		SetButton(get_child(i))
	pass

func SetButton(button):
	button.texture_normal = buttonPicture
	button.texture_hover = buttonPictureHovered
	button.texture_pressed = buttonPicturePressed
	button.get_child(0).add_font_override("font", textFont)
	pass

func _on_QuitButton_pressed():
	get_node("/root/GlobalScripts").ChangeScene(preload("res://scenes/title.tscn"))
	pass

func _on_ContinueButton_pressed():
	get_parent().remove_child(self)
	pass
