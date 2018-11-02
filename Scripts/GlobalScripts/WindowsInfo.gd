extends Node

var DialogWindowPos = Vector2(ProjectSettings.get_setting("display/window/size/width")/3, 0)
var DialogWindowInstance = null

var MCInvPosition = Vector2(ProjectSettings.get_setting("display/window/size/width")/3, ProjectSettings.get_setting("display/window/size/height") * 0.6)
var MCInventory = null
var DraggedItem = null

func LoadMcInv():
	MCInventory = preload("res://scenes/inventory.tscn").instance()
	get_parent().add_child(WindowsInfo.MCInventory)
	MCInventory.SetInventory(MainCharacter.mcName, Vector2(6, 4))
	MCInventory.rect_position = WindowsInfo.MCInvPosition
	for i in MainCharacter.items:
		MCInventory.AddItemToFreeCell(JsonManager.itemsDataBase[i]["name"], 0)