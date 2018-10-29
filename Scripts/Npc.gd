extends TextureButton

var dialogPre = preload("res://scenes/dialog.tscn")
var dialogInst

var charName = ""
var dialogExists = false

func _ready():
	connect("pressed", self, "_char_pressed")
	pass

func SetNPC(name):
	charName = name
	texture_normal = load("res://Textures/npc/chars/" + charName + ".png")
	pass

func _char_pressed():
	if dialogInst != null:
		if dialogInst.is_visible():
			HideDialog()
		else:
			ShowDialog()
	else:
		ShowDialog()
	pass

func ShowDialog():
	if dialogExists:
		dialogInst.show()
	else:
		dialogInst = dialogPre.instance()
		get_parent().add_child(dialogInst)
		dialogInst.SetDialogParams(charName, self)
		dialogExists = true
	pass

func HideDialog():
	dialogInst.hide()
	pass

func GoOut():
	dialogInst.hideOnClose = false
	queue_free()
	pass