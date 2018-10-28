extends Node2D

var currentScene = null
var allLoadedScenes = []

func _ready():
	currentScene = preload("res://scenes/title.tscn").instance()
	add_child(currentScene)
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_Z):
		var charact = preload("res://scenes/character.tscn").instance()
		currentScene.add_child(charact)
		charact.SetChar("char_test")
	pass

#Функция смены сцены
func ChangeScene(scenePreload):
	#Пытаемся добавить текущую сцену в массив уже загруженных сцен
	AddToScenesArray(currentScene)
	#Скрываем текущую сцену
	currentScene.hide()
	#Загружаем новую сцену
	var inst = scenePreload.instance()
	#Проверяем, есть ли новая сцена в массиве уже загруженных сцен (вернется -1, если нет)
	var index = CheckIfLoaded(inst)
	#Если новая сцена есть в массиве, то показываем ее копию из массива,
	#а если нет, то показываем новый экземпляр.
	if index != -1:
		currentScene = allLoadedScenes[index]
		currentScene.show()
	else:
		currentScene = inst
		add_child(currentScene)
	pass
	
func QuitToTitle():
	currentScene.queue_free()
	currentScene = preload("res://scenes/title.tscn").instance()
	allLoadedScenes = []
	add_child(currentScene)
	pass
	
#Добавление сцены в массив всех загруженных сцен (с проверкой)
func AddToScenesArray(scene):
	var isInArray = false
	for i in range(allLoadedScenes.size()):
		if allLoadedScenes[i].get_name() == scene.get_name():
			isInArray = true
	
	if not isInArray:
		allLoadedScenes.append(scene)
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