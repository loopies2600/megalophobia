extends CharacterBody3D
class_name Player

@export var base_speed : float = 1.3
@export var do_gravity : bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor() && do_gravity:
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("left", "right", "forwards", "backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * base_speed
		velocity.z = direction.z * base_speed
	else:
		velocity.x = move_toward(velocity.x, 0, base_speed)
		velocity.z = move_toward(velocity.z, 0, base_speed)

	move_and_slide()
