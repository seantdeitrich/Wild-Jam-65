extends CharacterBody2D

const SPEED = 200.0
@export var bullet:PackedScene
@onready var bullet_cooldown:=$BulletCooldown
@onready var dash_timer := $DashTimer
@onready var laser = $Laser
@onready var projectiles:=$Projectiles
@onready var hurtbox := $CollisionShape2D
var dashing := false;

func _physics_process(delta: float) -> void:
	if not dashing:
		var direction = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = direction * SPEED;
		look_at(get_global_mouse_position())
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if not dashing:
		if Input.is_action_just_pressed("Shoot") and bullet_cooldown.is_stopped():
			var new_bullet = bullet.instantiate()
			new_bullet.direction = global_position.direction_to(get_global_mouse_position())
			new_bullet.position = global_position
			projectiles.add_child(new_bullet)
			bullet_cooldown.start()
			laser.hide()
		if Input.is_action_just_pressed("Special"):
			pass
		if Input.is_action_just_pressed("Dash"):
			dash()

		
func _on_bullet_cooldown_timeout() -> void:
	laser.show();

func dash() -> void:
	dash_timer.start()
	dashing = true
	hurtbox.disabled = true;
	velocity = velocity * 5;

func _on_dash_timer_timeout() -> void:
	dashing = false;
	hurtbox.disabled = false;
