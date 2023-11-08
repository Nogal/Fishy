extends Area2D

const MIN_SPEED = 10
const MAX_SPEED = 100

const MIN_SIZE = 0.1
const MAX_SIZE = 2.0

#var poop = 'poop'

@onready var speed = 0
@onready var fish_scale = 1.0
var rng = RandomNumberGenerator.new()


func size():
	return self.scale
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = rng.randi_range(-MIN_SPEED, -MAX_SPEED)
	fish_scale = rng.randf_range(MIN_SIZE, MAX_SIZE)
	if global_position.x < 0:
		speed = -speed
	else:
		get_node("Sprite2D").set_flip_h(true)
	self.scale = Vector2(fish_scale, fish_scale)
	pass # Replace with function body.

func just_keep_swimming(delta):
	position.x += speed * delta
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	just_keep_swimming(delta)
	pass


func _on_area_entered(area):
	if area.is_in_group("player"):
		print("I am dead!")
		queue_free()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("I have traveled to the nether!")
	queue_free()
	pass # Replace with function body.
