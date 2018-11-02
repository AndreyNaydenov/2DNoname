extends Node2D

var currentScene = null
var allLoadedScenes = []

func _ready():
	currentScene = preload("res://scenes/title.tscn").instance()
	add_child(currentScene)
	pass

#Спавн НПС на клавишу Z
func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.scancode == KEY_Z:
			var charact = preload("res://scenes/npc.tscn").instance()
			currentScene.add_child(charact)
			charact.SetNPC("char_test")

#Функция смены сцены
func ChangeScene(scene):
	#Скрываем текущую сцену
	currentScene.hide()
	#Загружаем новую сцену
	var inst = scene.instance()
	#Проверяем, есть ли новая сцена в массиве уже загруженных сцен (вернется -1, если нет)
	var index = CheckIfLoaded(inst)
	#Если новая сцена есть в массиве, то показываем ее копию из массива,
	#а если нет, то показываем новый экземпляр и добавляем его в масиив.
	if index != -1:
		currentScene = allLoadedScenes[index]
		currentScene.show()
	else:
		currentScene = inst
		allLoadedScenes.append(currentScene)
		add_child(currentScene)
	pass
	
func QuitToTitle():
	currentScene.queue_free()
	currentScene = preload("res://scenes/title.tscn").instance()
	allLoadedScenes = []
	add_child(currentScene)
	pass

#Проверка, существует ли сцена в массиве всех загруженных сцен
func CheckIfLoaded(scene):
	var isInArray = false
	var index = -1
	for i in range(allLoadedScenes.size() - 1):
		if allLoadedScenes[i].get_name() == scene.get_name():
			isInArray = true
			index = i
	
	return index
	pass