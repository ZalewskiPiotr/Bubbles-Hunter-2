extends CanvasLayer

## Skrypt HUD
##
## Skrypt zajmuje się tym co jest wyświetlane na HUD w czasie gry. Aktywowany jest po starcie gry.
## Obecnie wyświetla informacje o liczbie punktów zdobytych przez gracza.


#region Stałe i zmienne
var _score : int						# Liczba punktów zdobytych przez gracza
@onready var label_score = $LabelScore	# Kontrolka do wyświetlania punktów
#endregion


#region Wbudowane funkcje silnika Godot
## Przygotowanie obiektu HUD
##
## Funkcja przygotowuje obiekt HUD do działania: zeruje zmienne, ładuje sygnały, 
func _ready():
	GameEvents.OnScoreBubbleHit.connect(add_point)
	clear_score()
	show_score()
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
#endregion
