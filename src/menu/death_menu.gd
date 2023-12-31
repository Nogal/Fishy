extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_steven_died():
	get_node("Message").set_text(tr('KEY_DEATH'))
	self.visible = true
	pass # Replace with function body.

func unpause():
	get_tree().paused = false
	self.visible = false
	
func _on_retry_pressed():
	unpause()
	SceneManager.change_scene("res://src/Levels/level1.tscn")



func _on_menu_pressed():
	unpause()
	SceneManager.change_scene("res://src/menu/main_menu.tscn")


func _on_steven_steven_too_big():
	get_node("Message").set_text(tr('KEY_TOO_BIG'))
	get_tree().paused = true
	self.visible = true
	pass # Replace with function body.
