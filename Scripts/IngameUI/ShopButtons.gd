extends TextureRect

var menuScene = load("res://scenes/ingame_menu.tscn")
var stockScene = load("res://scenes/stock.tscn")

var tradeDrawer

var mcInvButton

func _ready():
	tradeDrawer = get_node("TradeDrawer")
	mcInvButton = get_node("MCInvButton")
	get_node("MenuButton").connect("pressed", self, "_on_MenuButton_pressed")
	get_node("StockButton").connect("pressed", self, "_on_StockButton_pressed")
	mcInvButton.connect("pressed", self, "_on_McInvBut_pressed")
	pass

func _on_MenuButton_pressed():
	var sceneInstance = menuScene.instance()
	get_parent().add_child(sceneInstance)
	pass

func _on_StockButton_pressed():
	SceneManager.ChangeScene(stockScene)
	if WindowsInfo.MCInventory:
		WindowsInfo.MCInventory.Close()
	pass
	
func _on_McInvBut_pressed():
	if WindowsInfo.MCInventory:
		if WindowsInfo.MCInventory.is_visible():
			WindowsInfo.MCInventory.Close()
		else:
			WindowsInfo.MCInventory.get_parent().remove_child(WindowsInfo.MCInventory)
			add_child(WindowsInfo.MCInventory)
			WindowsInfo.MCInventory.show()
			WindowsInfo.MCInventory.connect("closed", self, "_on_mcInv_closed")
			mcInvButton.texture_normal = mcInvButton.texture_hover
	else:
		WindowsInfo.LoadMcInv()
		WindowsInfo.MCInventory.connect("closed", self, "_on_mcInv_closed")
		mcInvButton.texture_normal = mcInvButton.texture_hover
	pass

func _on_mcInv_closed():
	mcInvButton.texture_normal = preload("res://Textures/shop/mc_inv_button.png")
	WindowsInfo.MCInvPosition = WindowsInfo.MCInventory.rect_position
	pass