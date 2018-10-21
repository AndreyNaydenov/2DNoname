extends TextureRect

var background = preload("res://Textures/shop/game_background.png")
var shop = preload("res://Textures/shop/shop_0.png")
var timerFont = preload("res://Fonts/timer_dynamic_font.tres")
var dateFont = preload("res://Fonts/date_dynamic_font.tres")
var letInButNormal = preload("res://Textures/shop/let_in_button_normal.png")
var letInButHover = preload("res://Textures/shop/let_in_button_hovered.png")
var declineButNormal = preload("res://Textures/shop/decline_button_normal.png")
var declineButHover = preload("res://Textures/shop/decline_button_hovered.png")
var doorButFont = preload("res://Fonts/door_but_dynamic_font.tres")
var monitorNormal = preload("res://Textures/shop/monitor_normal.png")
var monitorHovered = preload("res://Textures/shop/monitor_hovered.png")
var drawerNormal = preload("res://Textures/shop/drawer_normal.png")
var drawerHovered = preload("res://Textures/shop/drawer_hovered.png")
var stockNormal = preload("res://Textures/shop/stock_door_normal.png")
var stockHovered = preload("res://Textures/shop/stock_door_hover.png")
var menuNormal = preload("res://Textures/shop/menu_button_normal.png")
var menuHovered = preload("res://Textures/shop/menu_button_hovered.png")

func _ready():
	SetUI()
	SetTime("8:30")
	SetDate("Jul 20")
	pass
	
func SetTime(time):
	get_node("GameInfoUI/Time").text = time
	pass

func SetDate(date):
	get_node("GameInfoUI/Day").text = date
	pass
	
func SetUI():
	texture = background
	get_node("GameInfoUI/Time").add_font_override("font", timerFont)
	get_node("GameInfoUI/Day").add_font_override("font", dateFont)
	get_node("Shop").texture = shop
	var tradeDrawer = get_node("Shop/TradeDrawer")
	var letInBut = get_node("Shop/DoorButtons/LetInButton")
	var declineBut = get_node("Shop/DoorButtons/DeclineButton")
	var monitor = get_node("Shop/Monitor")
	var stockBut = get_node("Shop/StockButton")
	var menuBut = get_node("Shop/MenuButton")
	menuBut.texture_normal = menuNormal
	menuBut.texture_hover = menuHovered
	stockBut.texture_normal = stockNormal
	stockBut.texture_hover = stockHovered
	monitor.texture_normal = monitorNormal
	monitor.texture_hover = monitorHovered
	tradeDrawer.texture_normal = drawerNormal
	tradeDrawer.texture_hover = drawerHovered
	letInBut.texture_normal = letInButNormal
	letInBut.texture_hover = letInButHover
	declineBut.texture_normal = declineButNormal
	declineBut.texture_hover = declineButHover
	declineBut.get_child(0).add_font_override("font", doorButFont)
	letInBut.get_child(0).add_font_override("font", doorButFont)
	pass