extends TextureRect

var stockBG = preload("res://Textures/stock/stock_background.png")
var shelfNormal = preload("res://Textures/stock/shelf_normal.png")
var shelfHover = preload("res://Textures/stock/shelf_hover.png")
var doorNormal = preload("res://Textures/stock/door_button_normal.png")
var doorHover = preload("res://Textures/stock/door_button_hover.png")
const invButNormal = preload("res://Textures/shop/mc_inv_button.png")
const invButHover = preload("res://Textures/shop/mc_inv_button_hover.png")

var shelfInv = null
var shelfInvPosition = Vector2(ProjectSettings.get_setting("display/window/size/width") * 0.6, ProjectSettings.get_setting("display/window/size/height") * 0.4)
var shelf

var mcInvButton

func _ready():
	shelf = get_child(1)
	mcInvButton = get_node("MCInvButton")
	SetUI()
	get_child(0).connect("pressed", self, "_on_door_pressed")
	shelf.connect("pressed", self, "_on_shelf_pressed")
	mcInvButton.connect("pressed", self, "_on_McInvBut_pressed")
	pass

func SetUI():
	texture = stockBG
	get_child(1).texture_normal = shelfNormal
	get_child(1).texture_hover = shelfHover
	get_child(0).texture_normal = doorNormal
	get_child(0).texture_hover = doorHover
	get_child(2).texture_normal = invButNormal
	get_child(2).texture_hover = invButHover
	pass

func _on_door_pressed():
	SceneManager.ChangeScene(preload("res://scenes/shop_scene.tscn"))
	if shelfInv:
		shelfInv.Close()
	if WindowsInfo.MCInventory:
		WindowsInfo.MCInventory.Close()
	pass

func _on_shelf_pressed():
	if shelfInv:
		if shelfInv.is_visible():
			shelfInv.Close()
		else:
			shelfInv.show()
			shelf.texture_normal = shelfHover
	else:
		shelfInv = preload("res://scenes/inventory.tscn").instance()
		add_child(shelfInv)
		shelfInv.SetInventory("Полки", Vector2(8, 4))
		shelfInv.connect("closed", self, "_on_inv_closed")
		shelfInv.rect_position = shelfInvPosition
		shelf.texture_normal = shelfHover
	pass
	
func _on_inv_closed():
	shelf.texture_normal = shelfNormal
	shelfInvPosition  = shelfInv.rect_position
	pass

func _on_McInvBut_pressed():
	if WindowsInfo.MCInventory:
		if WindowsInfo.MCInventory.is_visible():
			WindowsInfo.MCInventory.Close()
		else:
			WindowsInfo.MCInventory.get_parent().remove_child(WindowsInfo.MCInventory)
			add_child(WindowsInfo.MCInventory)
			WindowsInfo.MCInventory.show()
			WindowsInfo.MCInventory.connect("closed", self, "_on_McInv_closed")
			mcInvButton.texture_normal = invButHover
	else:
		WindowsInfo.LoadMcInv()
		WindowsInfo.MCInventory.connect("closed", self, "_on_McInv_closed")
		mcInvButton.texture_normal = invButHover
	pass

func _on_McInv_closed():
	mcInvButton.texture_normal = invButNormal
	WindowsInfo.MCInvPosition = WindowsInfo.MCInventory.rect_position
	pass