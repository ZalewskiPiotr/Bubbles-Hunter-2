extends CanvasLayer
@onready var _label_score = $LabelScore


func set_score(score : int) -> void:
	_label_score.text = "Your score: " + str(score)
	print("jestem w score")
