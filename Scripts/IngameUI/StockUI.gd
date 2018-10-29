extends TextureRect

var stockBG = preload("res://Textures/stock/stock_background.png")
var shelfNormal = preload("res://Textures/stock/shelf_normal.png")
var shelfHover = preload("res://Textures/stock/shelf_hover.png")
var doorNormal = preload("res://Textures/stock/door_button_normal.png")
var doorHover = preload("res://Textures/stock/door_button_hover.png")

func _ready():
	SetUI()
	get_child(0).connect("pressed", self, "_on_door_pressed")
	pass

func _on_door_pressed():
	SceneManager.ChangeScene(preload("res://scenes/shop_scene.tscn"))
	pass

func SetUI():
	texture = stockBG
	get_child(1).texture_normal = shelfNormal
	get_child(1).texture_hover = shelfHover
	get_child(0).texture_normal = doorNormal
	get_child(0).texture_hover = doorHover
	pass
