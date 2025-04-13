extends Node
class_name MathQuestions

var questions := [
	{ "question": "2 x 2 + 2 - 2", "answer": "4" },
	{ "question": "5 + 3 x 2", "answer": "11" },
	{ "question": "12 / 4 + 6", "answer": "9" },
	{ "question": "8 - 2 x 3", "answer": "2" },
	{ "question": "9 + 1 - 5", "answer": "5" },
	{ "question": "6 / 2 + 3", "answer": "6" },
	{ "question": "7 x 2 - 4", "answer": "10" },
	{ "question": "10 - 2 + 1", "answer": "9" },
	{ "question": "3 x 3 + 1", "answer": "10" },
	{ "question": "15 / 5 + 2", "answer": "5" },
	{ "question": "4 x 2 - 1", "answer": "7" },
	{ "question": "18 / 3 - 2", "answer": "4" },
	{ "question": "2 + 2 + 2", "answer": "6" },
	{ "question": "5 x 2 - 5", "answer": "5" },
	{ "question": "20 / 4 + 1", "answer": "6" },
	{ "question": "3 + 3 x 3", "answer": "12" },
	{ "question": "7 + 2 - 1", "answer": "8" },
	{ "question": "6 + 6 / 2", "answer": "9" },
	{ "question": "9 - 3 + 2", "answer": "8" },
	{ "question": "4 x 3 - 6", "answer": "6" },
	{ "question": "Je suis un nombre pair compris entre 5 et 9", "answer": "6" },
	{ "question": "Quel chiffre manque ? 2, 4, 6, __, 10", "answer": "8" },
	{ "question": "Combien de côtés a un triangle ?", "answer": "3" },
	{ "question": "Je suis le double de 4, puis j’enlève 3. Qui suis-je ?", "answer": "5" },
	{ "question": "Quel est le plus petit nombre entier positif ?", "answer": "1" },
	{ "question": "Je suis un carré parfait entre 1 et 10", "answer": "4" },
	{ "question": "Combien y a-t-il de zéros dans 1000 ?", "answer": "3" },
	{ "question": "Je suis le suivant de 19", "answer": "20" },
	{ "question": "Quel est le chiffre central dans 1 2 3 4 5 ?", "answer": "3" },
	{ "question": "Combien de lettres dans le mot 'maths' ?", "answer": "5" }
]


func get_random_question() -> Dictionary:
	return questions[randi() % questions.size()]
