extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area: Area2D = $Area2D

@export var has_enemies: bool = false

var puzzle_solved: bool = false
var enemies_cleared: bool = false
var opened: bool = false
var enemies_remaining: int = 0

func _ready() -> void:
	print("🚪 Porte prête")
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	print("🧠 Connexion au signal body_entered faite")
	print("🎯 Area2D monitoring : ", area.monitoring)
	print("🎯 Area2D monitorable : ", area.monitorable)
	print("🎯 Area2D mask : ", area.collision_mask)
	print("🎯 Area2D layer : ", area.collision_layer)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D and body.name == "Player":
		print("✅ Le joueur est bien entré dans la zone.")
		
		# Afficher l'énigme uniquement si la porte est fermée
		if not opened:
			_show_math_puzzle()
	else:
		print("🚫 Collision ignorée avec : ", body.name, " (", body.get_class(), ")")

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		print("🚪 Le joueur a quitté la zone.")
		var puzzle_ui = get_tree().current_scene.get_node("MathPuzzleUI")
		if puzzle_ui:
			puzzle_ui.visible = false

func _show_math_puzzle() -> void:
	print("📢 Tentative d'affichage de l'énigme...")
	var puzzle_ui = get_tree().current_scene.get_node("MathPuzzleUI")
	if not puzzle_ui: return

	var question_data: Dictionary = MathQuestions.new().get_random_question()
	puzzle_ui.show_puzzle(question_data["question"], question_data["answer"])
	if not puzzle_ui.puzzle_solved.is_connected(_on_puzzle_result):
		puzzle_ui.puzzle_solved.connect(_on_puzzle_result)

	print("📘 Énigme affichée avec question :", question_data["question"])

func _on_puzzle_result(success: bool) -> void:
	if success:
		print("✅ Bonne réponse à l’énigme !")
		puzzle_solved = true
		try_open()
	else:
		print("❌ Mauvaise réponse.")

func try_open() -> void:
	print("🔍 Test ouverture : puzzle_solved=%s | enemies_cleared=%s" % [puzzle_solved, enemies_cleared])

	if opened:
		return

	if puzzle_solved and (not has_enemies or enemies_cleared):
		opened = true
		open()

func open() -> void:
	print("🚪 Ouverture de la porte !")
	animation_player.play("open")

# ------- Gestion des ennemis --------

func register_enemy() -> void:
	enemies_remaining += 1
	print("👾 Ennemi enregistré. Total =", enemies_remaining)

func notify_enemy_killed() -> void:
	enemies_remaining -= 1
	print("❌ Ennemi tué. Restants :", enemies_remaining)
	if enemies_remaining <= 0:
		notify_enemies_cleared()

func notify_enemies_cleared() -> void:
	enemies_cleared = true
	print("🎯 Tous les ennemis éliminés.")
	try_open()
