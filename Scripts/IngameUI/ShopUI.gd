extends TextureRect

const background = preload("res://Textures/shop/game_background.png")
const shop = preload("res://Textures/shop/shop_0.png")
const timerFont = preload("res://Fonts/timer_dynamic_font.tres")
const dateFont = preload("res://Fonts/date_dynamic_font.tres")
const letInButNormal = preload("res://Textures/shop/let_in_button_normal.png")
const letInButHover = preload("res://Textures/shop/let_in_button_hovered.png")
const declineButNormal = preload("res://Textures/shop/decline_button_normal.png")
const declineButHover = preload("res://Textures/shop/decline_button_hovered.png")
const doorButFont = preload("res://Fonts/door_but_dynamic_font.tres")
const monitorNormal = preload("res://Textures/shop/monitor_normal.png")
const monitorHovered = preload("res://Textures/shop/monitor_hovered.png")
const drawerNormal = preload("res://Textures/shop/drawer_normal.png")
const drawerHovered = preload("res://Textures/shop/drawer_hovered.png")
const stockNormal = preload("res://Textures/shop/stock_door_normal.png")
const stockHovered = preload("res://Textures/shop/stock_door_hover.png")
const menuNormal = preload("res://Textures/shop/menu_button_normal.png")
const menuHovered = preload("res://Textures/shop/menu_button_hovered.png")
const invButNormal = preload("res://Textures/shop/mc_inv_button.png")
const invButHover = preload("res://Textures/shop/mc_inv_button_hover.png")

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
	var mcInvBut = get_node("Shop/MCInvButton")
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
	mcInvBut.texture_normal = invButNormal
	mcInvBut.texture_hover = invButHover
	declineBut.get_child(0).add_font_override("font", doorButFont)
	letInBut.get_child(0).add_font_override("font", doorButFont)
	pass