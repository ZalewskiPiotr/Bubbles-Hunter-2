extends Node2D

## Główny skrypty gry.
##
## Skrypt steruje grą, ekranami, itp

#region Stałe i zmienne
const MIN_BUBBLE_AMOUNT : int = 1	# Minimum number of bubbles in one draw
const MAX_BUBBLE_AMOUNT : int = 5	# Maximum number of bubbles in one draw
var _bubble_score_scene = preload("res://scenes/bubble_score.tscn")		# Scena potrzebna do tworzenia wielu obiektów typu tej sceny
var _bubble_killer_scene = preload("res://scenes/bubble_killer.tscn")	# Scena potrzebna do tworzenia wielu obiektów typu tej sceny
var _start_scene : PackedScene = load("res://scenes/start_menu.tscn")
#endregion

#region Wbudowane funkcje silnika Godot
## Inicjalizacja obiektu
##
## Ustawiamy to co potrzebujemy na starcie gry
func _ready():
	GameEvents.OnKillerBubbleHit.connect(killer_bubble_hit_player)
	randomize() # Będziemy trochę losować, więc trzeba odpalić funkcję
	# TODO: trzeba dodać ustawianie widoczności obiektów i pewnie zamrożenie gry albo zrobić coś aby gra nie grała ale 
	# czekała na sygnał z ekranu startowego. Chyba w Creepy jest coś takiego zrobione
	#region TEMP Jak już zrobimt ekran startowy to poniższy kod będzie do przenisienia w noe miejsce
	create_some_score_bubbles()
	#endregion
#endregion


#region Tworzenie baniek
## Generowanie losowej ilości baniek
##
## Funkcja zarządza tworzeniem losowej ilości baniek
func create_some_score_bubbles():
	var bubbles_amount = randi_range(MIN_BUBBLE_AMOUNT, MAX_BUBBLE_AMOUNT)
	for i : int in bubbles_amount:
		var new_bubble = _bubble_score_scene.instantiate()
		add_child(new_bubble)


## Generowanie killera
##
## Funkcja generuje bańkę, która zabija gracza. Jest 50% szans na utworzenie takiej bańki
func create_killer_bubble():
	var create_killer = [true, false][randi() % 2]
	create_killer = true # linijka do wyrzucenia po testach
	if create_killer:
		var new_killer = _bubble_killer_scene.instantiate()
		add_child(new_killer)

## Wyzwalacz generowania baniek
##
## Poniższa funkcja jest wyzwalana przez TimerBubbleGenerator, zgodnie z ustawieniami timera.
## Funkcja co określony czas generuje nowe bańki		
func _on_timer_bubble_generator_timeout():
	create_some_score_bubbles()
	create_killer_bubble()
#endregion

func killer_bubble_hit_player():
	get_tree().change_scene_to_packed(_start_scene)

