extends TextureRect

var menuScene = preload("res://scenes/ingame_menu.tscn")

func _ready():
	get_node("MenuButton").connect("pressed", self, "_on_MenuButton_pressed")
	get_node("StockButton").connect("pressed", self, "_on_StockButton_pressed")
	pass

func _on_MenuButton_pressed():
	var sceneInstance = menuScene.instance()
	add_child(sceneInstance)
	pass

func _on_StockButton_pressed():
	get_tree().change_scene("res://scenes/stock.tscn")
	pass
