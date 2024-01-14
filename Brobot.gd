extends CharacterBody2D

const SPEED = 200.0
@export var bullet:PackedScene
@onready var bullet_cooldown:=$BulletCooldown
@onready var projectiles:=$Projectiles

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * SPEED;
	look_at(get_global_mouse_position())
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Shoot") and bullet_cooldown.is_stopped():
		var new_bullet = bullet.instantiate()
		new_bullet.direction = global_position.direction_to(get_global_mouse_position())
		new_bullet.position = global_position;
		projectiles.add_child(new_bullet);
		bullet_cooldown.start()
	if Input.is_action_just_pressed("Special"):
		pass
	if Input.is_action_just_pressed("Dash"):
		pass
