extends CanvasLayer

## Skrypt HUD
##
## Skrypt zajmuje się tym co jest wyświetlane na HUD w czasie gry. Aktywowany jest po starcie gry.
## Obecnie wyświetla informacje o liczbie punktów zdobytych przez gracza.


#region Stałe i zmienne
var _score : int						# Liczba punktów zdobytych przez gracza
@onready var label_score = $LabelScore	# Kontrolka do wyświetlania punktów
@onready var _label_final_score = $LabelFinalScore		# Kontrolka do wyświetlenia końcowego wyniku
@onready var _label_lives: Label = $LabelLives			# Kontrolka do wyświetlania ilości żyć
#endregion


#region Wbudowane funkcje silnika Godot
## Przygotowanie obiektu HUD
##
## Funkcja przygotowuje obiekt HUD do działania: zeruje zmienne, ładuje sygnały, 
func _ready():
	GameEvents.OnScoreBubbleHit.connect(add_point)
	clear_score()
	show_score()
	show_lives(3)
	_label_final_score.visible = false
#endregion


#region Zarządzanie punktami
## Dodanie punktu
##
## Funkcja dodaje jeden punkt do ogólnego wyniku
func add_point():
	_score += 1
	show_score()

	
## Wyświetlenie wyniku
##
## Funkcja aktualizuje wynik wyświetlany na akranie
func show_score():
	label_score.text = "SCORE: " + str(_score)


## Wyczyszczenie wyniku
##
## Funkcja zeruje ogólny wynik gracza	
func clear_score():
	_score = 0
	

## Wyświetlenie końcowego wyniku gracza
##
## Funkcja wyświetla na środku okranu końcowy wynik gracza
func show_final_score() -> void:
	_label_final_score.text = "Your score: " + str(_score)
	_label_final_score.visible = true
#endregion


#region Zarządzanie życiem
## Wyświetlenie ilości żyć na ekranie	
func show_lives(lives : int) -> void:
	_label_lives.text = "LIVES: " + str(lives)
#endregion
