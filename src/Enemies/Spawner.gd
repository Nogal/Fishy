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
	print("spawn")

	var mob = mob_scene.instantiate()
	
	var extents = get_node("Area2D/CollisionShape2D").shape.extents
	var center = get_node("Area2D/CollisionShape2D").position - get_node("Area2D").position

	mob_position.x = (randi() % int(round(extents.x))) - (extents.x/2) + center.x
	mob_position.y = (randi() % int(round(extents.y))) - (extents.y/2) + center.y
	print(mob_position)
	mob.position = mob_position
	add_child(mob)
	
	
	pass # Replace with function body.
