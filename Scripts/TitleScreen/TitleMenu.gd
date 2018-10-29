extends VBoxContainer

var buttonPicture = preload("res://Textures/title_button.png")
var buttonPictureHovered = preload("res://Textures/title_button_hovered.png")
var buttonPicturePressed = preload("res://Textures/title_button_pressed.png")
var textFont = preload("res://Fonts/dynamic_font.tres")

func _ready():
	
	get_child(3).connect("pressed", self, "_on_QuitButton_pressed")
	get_child(0).connect("pressed", self, "_on_NewGameBut_pressed")

	for i in range(0, 4):
		SetButton(get_child(i))		
	pass

func SetButton(button):
	button.texture_normal = buttonPicture
	button.texture_hover = buttonPictureHovered
	button.texture_pressed = buttonPicturePressed
	button.get_child(0).add_font_override("font", textFont)
	pass

func _on_NewGameBut_pressed():
	SceneManager.ChangeScene(load("res://scenes/shop_scene.tscn"))
	pass

func _on_QuitButton_pressed():
	get_tree().quit()
	pass