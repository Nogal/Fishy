extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):

		get_node("BigBones%d" % x).hide()
	for x in range(5):

		get_node("LittleBones%d" % x).hide()
	pass # Replace with function body.


func display_number_eaten(eaten: int):
	print(eaten)
	var quotient = eaten / 5
	var modulus = eaten % 5
	
	if eaten == 30:
		get_node("LittleBones4").show()
		
	if eaten < 30:
		if quotient > 0:
			for x in range(quotient):

				get_node("BigBones%d" % x).show()
		
		if modulus == 0:
			for x in range(5):

				get_node("LittleBones%d" % x).hide()
		else:
			for x in range(modulus):

				get_node("LittleBones%d" % x).show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_steven_eat_counter_increased(num_eaten):
	display_number_eaten(num_eaten)
	pass # Replace with function body.
