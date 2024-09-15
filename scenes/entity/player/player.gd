extends CharacterBody3D
class_name Player

@export var base_speed : float = 1.3
@export var do_gravity : bool = false

@onready var camera : Camera3D = $BaseCam

var moving := false
var elapsed := 0.0

func bob_camera(delta : float):
	if moving:
		camera.position.y = abs(sin(elapsed * 5.0)) / 20.0
		camera.rotation.z = -sin(elapsed * 4.0) / 32.0
	else:
		camera.position.y = lerp(camera.position.y, 0.0, 8 * delta)
		camera.rotation.z = lerp_angle(camera.rotation.z, 0.0, 8 * delta)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor() && do_gravity:
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("left", "right", "forwards", "backwards")
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	moving = not direction.is_zero_approx()
	
	if direction:
		elapsed += delta
		
		velocity.x = direction.x * base_speed
		velocity.z = direction.z * base_speed
	else:
		elapsed = 0.0
		
		velocity.x = move_toward(velocity.x, 0, base_speed)
		velocity.z = move_toward(velocity.z, 0, base_speed)
	
	move_and_slide()
	
	bob_camera(delta)
