extends Camera3D

@export var mouse_sensitivity : float = 0.002

@onready var player : Player = get_parent() as Player

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _check_mouse_button(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event : InputEvent):
	_check_mouse_button(event)
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# rotate player
		player.rotate_y(-event.relative.x * mouse_sensitivity)
		
		# self rotate
		rotate_x(-event.relative.y * mouse_sensitivity)
		rotation.x = clampf(rotation.x, -deg_to_rad(70), deg_to_rad(70))
