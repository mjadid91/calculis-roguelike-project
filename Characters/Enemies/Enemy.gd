@icon("res://Art/v1.1 dungeon crawler 16x16 pixel pack/enemies/goblin/goblin_idle_anim_f0.png")

extends Character
class_name Enemy

@onready var player: CharacterBody2D = get_tree().current_scene.get_node("Player")
@onready var path_timer: Timer = get_node("PathTimer")
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")

var linked_door: Node = null

func _ready() -> void:
	# 🔗 Trouver une porte parente et s’enregistrer auprès d’elle
	linked_door = find_parent_door()
	if linked_door and linked_door.has_method("register_enemy"):
		linked_door.register_enemy()

	# 🧨 Connexion à sa propre disparition pour signaler sa mort à la porte
	connect("tree_exited", Callable(self, "_on_enemy_killed"))

func _on_enemy_killed() -> void:
	if linked_door and linked_door.has_method("notify_enemy_killed"):
		linked_door.notify_enemy_killed()

func find_parent_door() -> Node:
	var current = get_parent()
	while current:
		if current.has_node("Doors"):
			var doors = current.get_node("Doors")
			for door in doors.get_children():
				if door.has_method("register_enemy"):
					return door
		current = current.get_parent()
	return null

func chase() -> void:
	if not navigation_agent.is_target_reached():
		var vector_to_next_point: Vector2 = navigation_agent.get_next_path_position() - global_position
		mov_direction = vector_to_next_point

		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		_get_path_to_player()
	else:
		path_timer.stop()
		mov_direction = Vector2.ZERO

func _get_path_to_player() -> void:
	navigation_agent.target_position = player.position
