extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var gems:int = 6                # Start with 5 gems
var current_spawn:Vector2        # Active respawn point
var can_double_jump:bool = true  # Allow one double jump per take-off
var gems_label:Label

func _ready() -> void:
	current_spawn = global_position
	gems_label = get_node("../UI/Gemslabel")
	update_gem_ui()
	
func update_gem_ui():
	if gems_label:
		gems_label.text = "Gems: %d" % gems


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		can_double_jump = true   # Reset double jump on landing

	# Jump / double jump
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif can_double_jump and gems > 0:
			gems -= 1
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			update_gem_ui()

	# Horizontal movement
	var dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED if dir else move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die():
	global_position = current_spawn
	velocity = Vector2.ZERO
