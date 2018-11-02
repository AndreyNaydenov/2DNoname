extends "res://Scripts/IngameUI/Window.gd"

const bgTexture = preload("res://Textures/inventory/inventory_bg.png")
const closeButTexture = preload("res://Textures/inventory/inventory_cross.png")
const cellTexture = preload("res://Textures/inventory/inventory_cell.png")
const cellScene = preload("res://scenes/inventory_cell.tscn")
const itemScene = preload("res://scenes/inventory_item.tscn")

const cellSize = Vector2(50, 50)
var inventorySize

var inventoryName
var cellGrid
var cells = []
var itemNodes = []

func _ready():
	cellGrid = get_child(2)
	pass

func SetInventory(nameStr, sizeVec2):
	inventoryName = nameStr
	get_child(1).text = nameStr
	inventorySize = sizeVec2
	SetUI()
	PopulateInventory()
	pass

#ставит текстурки и настраивает размер инвентаря
func SetUI():
	texture = bgTexture
	get_child(0).texture_normal = closeButTexture
	rect_size = cellSize * inventorySize + Vector2(10, 38)
	cellGrid.rect_size = cellSize * inventorySize
	cellGrid.columns = inventorySize.x
	pass

# Заполняет инвентарь ячейками
func PopulateInventory():
	var cell
	for i in range(inventorySize.x * inventorySize.y):
		cell = cellScene.instance()
		cell.rect_size = cellSize
		cellGrid.add_child(cell)
		cells.append(cell)
		itemNodes.append(null)
	pass

#Ищет нужный предмет по имени и вставляет его в нужную ячейку
func AddItem(itemName, cellID):
	var itemInst = itemScene.instance()
	itemInst.item = JsonManager.FindItemByName(itemName)
	itemNodes[cellID] = itemInst
	cells[cellID].add_child(itemInst)
	itemInst.SetTexture(itemInst.item["texture"])
	itemInst.inventory = self
	itemInst.cell = cells[cellID]
	itemInst.rect_position = cellSize * 0.08
	itemInst.rect_size = cellSize - cellSize * 0.16
	pass

#Ищет нужный предмет по имени и вставляет его в 1 первую свободную ячейку, начиная с заданной
#Вернет true если место в инв. есть, вернет false если места нет
func AddItemToFreeCell(itemName, cellToStart):
	var attempts = 0
	var i = cellToStart
	while true:
		if !itemNodes[i]:
			AddItem(itemName, i)
			return true
		
		attempts += 1
		if attempts == cells.size():
			return false
		i += 1
		if i > cells.size() - 1:
			i = 0
	pass
	
func SwapItems(cellNum, itemNode):
	if itemNodes[cellNum]:
		var buf = itemNodes[cellNum]
		#Кладем лежащий предмет в слот кладущегося предмета
		cells[cellNum].remove_child(itemNodes[cellNum])
		itemNode.cell.add_child(itemNodes[cellNum])
		itemNodes[cellNum].cell = itemNode.cell
		itemNodes[cellNum] = itemNode
		#Кладем кладущийся предмет в слот лежащего предмета
		itemNode.cell.remove_child(itemNode)
		cells[cellNum].add_child(itemNode)
		itemNodes[itemNode.cell.get_index()] = buf
		itemNode.cell = cells[cellNum]
	else:
		itemNodes[itemNode.cell.get_index()] = null
		#Кладем кладущийся предмет в пустой слот
		itemNode.cell.remove_child(itemNode)
		cells[cellNum].add_child(itemNode)
		itemNodes[cellNum] = itemNode
		itemNode.cell = cells[cellNum]
	pass

#Обработка дропа предметов
func _input(event):
	if event is InputEventMouseButton:
		if !event.pressed and event.button_index == 1 and WindowsInfo.DraggedItem and is_visible():
			ItemDropped(WindowsInfo.DraggedItem)
	pass

func ItemDropped(itemNode):
	for cell in cells:
		#Чекаем, в какой ячейке находится мышка с предметом
		if cell.rect_global_position.x <= get_global_mouse_position().x and cell.rect_global_position.x + cell.rect_size.x >= get_global_mouse_position().x:
			if cell.rect_global_position.y <= get_global_mouse_position().y and cell.rect_global_position.y + cell.rect_size.y >= get_global_mouse_position().y:
				#Если мышка находится в ячейке инвентаря, то кладем предмет в нее
				#Если предмет из того же инв., то ,если ячейка занята, меняем предметы местами
				if itemNode.inventory.inventoryName == inventoryName:
					SwapItems(cell.get_index(), itemNode)
				else:
					itemNode.inventory.itemNodes[itemNode.cell.get_index()] = null
					if AddItemToFreeCell(itemNode.item["name"], cell.get_index()):
						itemNode.inventory = self
						itemNode.queue_free()
					else:
						#Если места в инв. нет, то не кладем
						itemNode.inventory.itemNodes[itemNode.cell.get_index()] = itemNode
				WindowsInfo.DraggedItem = null
	pass