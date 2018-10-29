extends TextureRect

var menuScene = load("res://scenes/ingame_menu.tscn")
var stockScene = load("res://scenes/stock.tscn")

func _ready():
	get_node("MenuButton").connect("pressed", self, "_on_MenuButton_pressed")
	get_node("StockButton").connect("pressed", self, "_on_StockButton_pressed")
	pass

func _on_MenuButton_pressed():
	var sceneInstance = menuScene.instance()
	get_parent().add_child(sceneInstance)
	pass

func _on_StockButton_pressed():
	SceneManager.ChangeScene(stockScene)
	pass
