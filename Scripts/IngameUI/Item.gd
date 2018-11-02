extends TextureButton

var item
var inventory
var cell

var initialMousePosition
var mouseInside = false
var drag = false

func _ready():
	connect("mouse_entered", self, "_on_mouse_enter_exit")
	connect("mouse_exited", self, "_on_mouse_enter_exit")
	pass

func _process(delta):
	if drag:
		MoveItem(item)
	pass

func _on_mouse_enter_exit():
	mouseInside = !mouseInside
	pass

#По нажатию на предмет выносит его на передний план и начинает передвигать
#По отпускании предмета возвращает его в свою ячейку
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1 and mouseInside:
			drag = true
			var offset = get_global_mouse_position() - rect_global_position
			get_parent().remove_child(self)
			inventory.add_child(self)
			rect_global_position = get_global_mouse_position() - offset
			initialMousePosition = get_local_mouse_position()
			WindowsInfo.DraggedItem = self
			inventory.ToForeground()
		elif !event.pressed and event.button_index == 1 and drag:
			drag = false
			get_parent().remove_child(self)
			cell.add_child(self)
			rect_position = inventory.cellSize * 0.08
	pass
	
# Перемещение предмета
func MoveItem(item):
	rect_position += get_local_mouse_position() - initialMousePosition
	if rect_global_position.x + rect_size.x > ProjectSettings.get_setting("display/window/size/width"):
		rect_global_position.x = ProjectSettings.get_setting("display/window/size/width") - rect_size.x
		initialMousePosition.x = int(get_local_mouse_position().x) % int(rect_size.x)
	if rect_global_position.y + rect_size.y > ProjectSettings.get_setting("display/window/size/height"):
		rect_global_position.y = ProjectSettings.get_setting("display/window/size/height") - rect_size.y
		initialMousePosition.y = int(get_local_mouse_position().y) % int(rect_size.y)
	if rect_global_position.x < 0:
		rect_global_position.x = 0
		initialMousePosition.x = get_local_mouse_position().x
		if get_local_mouse_position().x < 0:
			initialMousePosition.x = 0
	if rect_global_position.y < 0:
		rect_global_position.y = 0
		initialMousePosition.y = get_local_mouse_position().y
		if get_local_mouse_position().y < 0:
				initialMousePosition.y = 0
	pass

func SetTexture(texturePath):
	self.texture_normal = load(texturePath)
	pass