extends Area2D
var direction:=Vector2.ZERO;
const SPEED = 400;

func _process(delta: float) -> void:
	position += direction * SPEED * delta;
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
