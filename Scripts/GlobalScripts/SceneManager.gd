extends Node2D

var currentScene = null

func _ready():
	currentScene = get_child(0)
	pass

func ChangeScene(scenePreload):
	currentScene.queue_free()
	currentScene = scenePreload.instance()
	add_child(currentScene)
	pass
