extends CharacterBody2D

const SPEED = 200.0
@export var bullet:PackedScene
@onready var bullet_cooldown:=$BulletCooldown
@onready var projectiles:=$Projectiles

func _ready() -> void:

	#Set authority over player instance
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	print(name)

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	
	#Make sure only the proper instance of the player is controlled
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():

		var direction = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = direction * SPEED;
		look_at(get_global_mouse_position())
		move_and_slide()

func _input(event: InputEvent) -> void:

	#Make sure only the proper instance of the player is controlled
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():

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
