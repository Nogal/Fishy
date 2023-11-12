extends Node2D

@export var mob_scene: PackedScene

var mob_position = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var extents = get_node("Area2D/CollisionShape2D").shape.extents
	var center = get_node("Area2D/CollisionShape2D").position - get_node("Area2D").position
	
	var random_time = randi_range(1, 10)

	mob_position.x = (randi() % int(round(extents.x))) - (extents.x/2) + center.x
	mob_position.y = (randi() % int(round(extents.y))) - (extents.y/2) + center.y

	mob.position = mob_position
	add_child(mob)
	get_node("Timer").set_wait_time(random_time)
	get_node("Timer").start()
	
	pass # Replace with function body.
