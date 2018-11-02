extends TextureRect

var mouseInsideWindow = false
var initialMousePosition

# Если true, то окно скрывается при нажатии на кнопку закрытия
var hideOnClose = true

signal closed

func _ready():
	get_node("CloseButton").connect("pressed", self, "Close")
	connect("mouse_entered", self, "_on_mouse_action")
	connect("mouse_exited", self, "_on_mouse_action")
	pass

func _process(delta):
	MoveWindow()
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1 and mouseInsideWindow:
			ToForeground()
			initialMousePosition = get_local_mouse_position()
	pass

# Обрабатывает перетаскивание окна мышкой
func MoveWindow():
	if mouseInsideWindow and Input.is_mouse_button_pressed(BUTTON_LEFT):
		rect_position += get_local_mouse_position() - initialMousePosition
		
		if rect_position.x + rect_size.x > ProjectSettings.get_setting("display/window/size/width"):
			rect_position.x = ProjectSettings.get_setting("display/window/size/width") - rect_size.x
			initialMousePosition.x = int(get_local_mouse_position().x) % int(rect_size.x)
		if rect_position.y + rect_size.y > ProjectSettings.get_setting("display/window/size/height"):
			rect_position.y = ProjectSettings.get_setting("display/window/size/height") - rect_size.y
			initialMousePosition.y = int(get_local_mouse_position().y) % int(rect_size.y)
		if rect_position.x < 0:
			rect_position.x = 0
			initialMousePosition.x = get_local_mouse_position().x
			if get_local_mouse_position().x < 0:
				initialMousePosition.x = 0
		if rect_position.y < 0:
			rect_position.y = 0
			initialMousePosition.y = get_local_mouse_position().y
			if get_local_mouse_position().y < 0:
				initialMousePosition.y = 0
	pass

func Close():
	emit_signal("closed")
	if hideOnClose:
		hide()
	else:
		DestroyWindow()
	pass

func ToForeground():
	var lastChildIndex = get_parent().get_child_count()
	get_parent().move_child(self, lastChildIndex)
	print("Window:ToForground(): Parent is " + get_parent().name)
	pass
	
func DestroyWindow():
	WindowsInfo.DialogWindowPos = rect_position
	WindowsInfo.DialogWindowInstance = null
	queue_free()
	pass

func _on_mouse_action():
	mouseInsideWindow = !mouseInsideWindow
	pass
