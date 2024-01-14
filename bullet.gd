extends Area2D
var direction:=Vector2.ZERO;
const SPEED = 1000;

func _ready():
	look_at(global_position + direction)

func _process(delta: float) -> void:
	position += direction * SPEED * delta;
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
