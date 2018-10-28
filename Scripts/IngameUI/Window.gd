extends TextureRect

var mouseInsideWindow = false
var mousePosition

# Если true, то окно скрывается при нажатии на кнопку закрытия
var hideOnClose = true

func _ready():
	get_node("CloseButton").connect("pressed", self, "_on_close_pressed")
	connect("mouse_entered", self, "_on_mouse_action")
	connect("mouse_exited", self, "_on_mouse_action")
	pass

func _process(delta):	
	MoveWindow()
	pass
	
# Обрабатывает перетаскивание окна мышкой
func MoveWindow():
	if mouseInsideWindow and Input.is_mouse_button_pressed(BUTTON_LEFT):
		rect_position -= mousePosition - get_global_mouse_position()
	
	if rect_position.x + rect_size.x > ProjectSettings.get_setting("display/window/size/width"):
		rect_position.x = ProjectSettings.get_setting("display/window/size/width") - rect_size.x
	if rect_position.y + rect_size.y > ProjectSettings.get_setting("display/window/size/height"):
		rect_position.y = ProjectSettings.get_setting("display/window/size/height") - rect_size.y
	if rect_position.x < 0:
		rect_position.x = 0
	if rect_position.y < 0:
		rect_position.y = 0
	
	mousePosition = get_global_mouse_position()
	pass

func _on_close_pressed():
	if hideOnClose:
		hide()
	else:
		DestroyWindow()
	pass
	
func DestroyWindow():
	WindowsInfo.DialogWindowPos = rect_position
	WindowsInfo.DialogWindowInstance = null
	queue_free()
	pass

func _on_mouse_action():
	mouseInsideWindow = !mouseInsideWindow
	pass
