extends TextureRect

var menuScene = preload("res://scenes/ingame_menu.tscn")

func _ready():
	get_node("MenuButton").connect("pressed", self, "_on_MenuButton_pressed")
	get_node("StockButton").connect("pressed", self, "_on_StockButton_pressed")
	pass

func _on_MenuButton_pressed():
	var sceneInstance = menuScene.instance()
	get_parent().add_child(sceneInstance)
	pass

func _on_StockButton_pressed():
	SceneManager.ChangeScene(preload("res://scenes/stock.tscn"))
	pass
