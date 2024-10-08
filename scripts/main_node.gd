extends Node2D

## Główny skrypty gry.
##
## Skrypt steruje grą, ekranami, itp

#region Stałe i zmienne
const MIN_BUBBLE_AMOUNT : int = 1	# Minimum number of bubbles in one draw
const MAX_BUBBLE_AMOUNT : int = 5	# Maximum number of bubbles in one draw
var _bubble_score_scene = preload("res://scenes/bubble_score.tscn")		# Scena potrzebna do tworzenia wielu obiektów typu tej sceny
var _bubble_killer_scene = preload("res://scenes/bubble_killer.tscn")	# Scena potrzebna do tworzenia wielu obiektów typu tej sceny
var _start_scene : PackedScene = load("res://scenes/start_menu.tscn")	# Scena zawierajaca menu główne
@onready var _timer_bubble_generator = $Timers/TimerBubbleGenerator		# Timer od generowania baniek
@onready var _hud = $Hud		# Obiekt HUD
@onready var _necromancer: Necromancer = $Necromancer
var _lives : int # Ilość żyć gracza
#endregion

#region Wbudowane funkcje silnika Godot
## Inicjalizacja obiektu
##
## Ustawiamy to co potrzebujemy na starcie gry
func _ready():
	GameEvents.OnKillerBubbleHit.connect(killer_bubble_hit_player)
	randomize() # Będziemy trochę losować, więc trzeba odpalić funkcję
	create_some_score_bubbles()
	_lives = 3

## Łapanie akcji użytkownika
##
## Funkcja przechwytuje akcje użytkownika w GUI i na nie reaguje. Obecnie na wciśnięcie 
## klawisza 'ESC' funkcja przełącza grę do ekranu startowego
func _input(event):
	if event.is_action_pressed("ESC"):
		_switch_to_main_menu()
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


#region Trafienia gracza przez BubbleKiller
## Trafienia w gracza
##
## Funkcja zarządza tym co się stanie jak gracz zsotanie trafiony przez bańkę killera. Obecnie
## takie zdarzenie kończy grę
func killer_bubble_hit_player():
	_lives -= 1
	print("Zycia: ", _lives)
	if _lives == 0:
		just_before_game_over()
		_switch_to_main_menu()
	else:
		_hud.show_lives(_lives)
		_necromancer.continue_game()
		
## Porządki przed wyświetleniem planszy startowej
##
## Funkcja robi kilka porzadków przed wyświetleniem planszy startowej a po zakończeniu gry. Te
## porządki to: usunięcie wszystkich aktywnych baniek, zatrzymanie generatora baniek, wyświetlenie
## wyniku końcowego gracza.
func just_before_game_over() -> void:
	get_tree().call_group("Bubbles", "queue_free")
	_timer_bubble_generator.stop()
	_hud.show_final_score()

	
## Przełączenie gry do głównego menu
##
## Funkcja przełącza grę do głównego menu. 
func _switch_to_main_menu():
	# Próbowałem na różne sposoby. Finalnie trzeba będzie dodać jakiś message na nulla. Można
	# też przejść na ręczne zmienianie scen lub ładowanie node jako instancji ale wtedy trzeba
	# przebudować wszystko bo stronę menu mamy kilka razy na ekranie. Można też zmienić podejście
	# w programie na ukrywanie obiektów na jednej scenie a menu zrobić jako canvaslayer
	var tree : SceneTree = get_tree()
	if tree == null:
		print("ERROR: obiekt SceneTree jest null w czasie zmiany sceny. Źródło 'main_node -> /
				killer_bubble_hit_player")
	else:
		get_tree().change_scene_to_packed(_start_scene)
#endregion
