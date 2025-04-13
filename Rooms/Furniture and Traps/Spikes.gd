extends Hitbox


@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	animation_player.play("pierce")


func _collide(body: Node2D) -> void:
	if not body.flying:
		knockback_direction = (body.global_position - global_position).normalized()
		body.take_damage(damage, knockback_direction, knockback_force)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		print("Le joueur a touché le piège")
		var knockback_direction = (body.global_position - global_position).normalized()
		var knockback_force = 300  # Définir la force du knockback
		var damage = 10  # Définir les dégâts infligés par le piège
		body.take_damage(damage, knockback_direction, knockback_force)  # Appeler la méthode take_damage du joueur
