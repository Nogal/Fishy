extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	update_language()
	pass


func _process(delta):
	pass


func _on_start_pressed():
	SceneManager.change_scene("res://src/Levels/level1.tscn")


func _on_exit_pressed():
	get_tree().quit()


func update_language():
	get_node("Start").set_text(tr("KEY_START"))
	get_node("RichTextLabel").text = "[center][wave] [rainbow freq=.2 sat=0.8 val=0.9 ]" + tr("KEY_TITLE")
	get_node("Exit").set_text(tr("KEY_EXIT"))
	get_node("Language").set_text(tr("KEY_LANGUAGE"))


func _on_language_pressed():
	if TranslationServer.get_locale() == 'en_US':
		TranslationServer.set_locale('jp')
	else:
		TranslationServer.set_locale('en_US')
	update_language()
