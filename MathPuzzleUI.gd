extends CanvasLayer
class_name MathPuzzleUI

signal puzzle_solved(success: bool)

@onready var question_label = $Panel/VBoxContainer/QuestionTitle
@onready var answer_input = $Panel/VBoxContainer/AnswerInput
@onready var feedback_label = $Panel/VBoxContainer/FeedbackLabel

var correct_answer: String

func show_puzzle(question: String, answer: String) -> void:
	print("📢 Enigme affichée avec question :", question)
	correct_answer = answer
	question_label.text = question
	answer_input.text = ""
	feedback_label.text = ""
	visible = true
	answer_input.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_accept"):
		print("✅ Touche ui_accept détectée")
		_check_answer()

func _check_answer() -> void:
	var user_answer = answer_input.text.strip_edges()
	if user_answer == correct_answer:
		feedback_label.text = "✅ Bonne réponse !"
		emit_signal("puzzle_solved", true)
		await get_tree().create_timer(1.2).timeout
		hide()
	else:
		feedback_label.text = "❌ Mauvaise réponse. Réessaie."



func _on_answer_input_text_submitted(new_text: String) -> void:
	_check_answer()
