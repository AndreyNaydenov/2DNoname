extends Node

var itemsDataBase

func _ready():
	ParseItemsJson()
	pass

func ParseItemsJson():
	var file = File.new()
	file.open("res://Databases/ItemsDatabase.json", File.READ)
	var parsedJson = JSON.parse(file.get_as_text())
	itemsDataBase = parsedJson.result
	pass
	
func FindItemByName(nameString):
	for i in range(itemsDataBase.size()):
		if itemsDataBase[i]["name"] == nameString:
			return itemsDataBase[i]
	pass