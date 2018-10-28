extends "res://Scripts/IngameUI/Window.gd"

var dialogBG = preload("res://Textures/dialog/dialog_frame.png")
var optionFrameN = preload("res://Textures/dialog/text_frame_normal.png")
var optionFrameH = preload("res://Textures/dialog/text_frame_hover.png")
var optionPre = preload("res://scenes/dialog_option.tscn")

var optionsBox
var dialogHistory
var optionsCount = 0
var optionsNames = []
var historyText = ""
var npcName = ""
var npcDialogPath
var npcNode

func _ready():
	optionsBox = get_child(0)
	dialogHistory = get_child(1)
	SetUI()
	pass

func SetUI():
	texture = dialogBG
	pass

# Устанавливает параметры диалога
func SetDialogParams(NPCName, NPCNode):
	npcName = NPCName
	
	#Иконка нпс
	var pathToIcon = "res://Textures/npc/icons/" + npcName + ".png"
	get_child(2).texture = load(pathToIcon)
	
	#Путь к диалогу НПС
	var file = File.new()
	if file.file_exists("res://Dialog/individual/" + npcName ):
		npcDialogPath = "res://Dialog/individual/" + npcName + "/"
	else:
		npcDialogPath = "res://Dialog/class/" + npcName + "/"
	
	npcNode = NPCNode
	ExpandDialog("greet")
		
	if WindowsInfo.DialogWindowInstance != null:
		WindowsInfo.DialogWindowInstance.DestroyWindow()
	WindowsInfo.DialogWindowInstance = self;
	
	rect_position = WindowsInfo.DialogWindowPos
	pass

#Добавляет опцию в диалог
func AddOption(text):
	var option = optionPre.instance()
	optionsBox.add_child(option)
	optionsCount = optionsBox.get_child_count()
	option.texture_normal = optionFrameN
	option.texture_hover = optionFrameH
	
	var optionText = str(optionsCount) + ". " + text
	option.get_child(0).text = optionText
	option.connect("pressed", self, "_on_Option_pressed", [option])
	pass
	
#Удаляет все опции из диалога
func ClearOptions():
	for i in range(optionsCount):
		optionsBox.get_child(i).queue_free()
	optionsCount = 0;
	pass

#Добавляет в историю диалога новую строку
func AddToHistory(textToAdd, isMcLine):
	if isMcLine:
		historyText += MainCharacter.mcName + ": "
	else: 
		historyText += npcName + ": "
		
	historyText += textToAdd + "\n\n"
	dialogHistory.text = historyText
	pass
	
#Продвинуть диалог
func ExpandDialog(dialogFileName):	
	var dialogFile = File.new()
	dialogFile.open(npcDialogPath + dialogFileName, File.READ)
	
	#Определяем тип файла (histoty и option)
	var isHistory
	if(dialogFile.get_line() == "#NPCLINE"):
		isHistory = true
	else:
		isHistory = false
		
	if(isHistory):	
		#Обработка реплики
		#Добавляем реплику
		var contentStr = ""
		var fileLine = dialogFile.get_line()
		while( fileLine != "#line"):
			fileLine = dialogFile.get_line()
		fileLine = dialogFile.get_line()
		AddToHistory(fileLine, false)
	
		#Добавляем опции
		var optionsFile = File.new()
		while( fileLine != "#options"):
			fileLine = dialogFile.get_line()
		fileLine = dialogFile.get_line()
		while( fileLine != ""):
			optionsNames.append(fileLine)
			optionsFile.open(npcDialogPath + fileLine, File.READ)
			while(optionsFile.get_line() != "#line"):
				pass
			AddOption(optionsFile.get_line())
			fileLine = dialogFile.get_line()
		optionsFile.close()
	else:
		#Обработка опции
		#Добавляем реплику в историю
		var fileLine = dialogFile.get_line()
		while( fileLine != "#line"):
			fileLine = dialogFile.get_line()
		AddToHistory(dialogFile.get_line(), true)
		
		#Продвигаем диалог
		while( fileLine != "#npcline"):
			fileLine = dialogFile.get_line()
		fileLine = dialogFile.get_line()
		ExpandDialog(fileLine)
		
		#Выполняем действия опции
		while(dialogFile.get_line() != "#action"):
			pass
		fileLine = dialogFile.get_line()
		while(fileLine != ""):
			ProcessAction(fileLine)
			fileLine = dialogFile.get_line()
	
	dialogFile.close()
	pass

func ProcessAction(actionLine):
	if actionLine == "end":
		dialogHistory.text += "				*Конец Диалога*"
		npcNode.GoOut()
	pass
	
func _on_Option_pressed(option):
	ClearOptions()
	ExpandDialog(optionsNames[option.get_index()])
	pass