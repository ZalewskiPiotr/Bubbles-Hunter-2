extends CharacterBody2D
class_name Necromancer


#region Stałe i zmienne
const SPEED = 300.0		# Szybkość gracza
# var _start_scene : PackedScene = load("res://scenes/start_menu.tscn")
#endregion


#region Wbudowane funkcje silnika Godot
## Funkcja zarządza przebiegiem wszystkiego co dzieje się z graczem
##
## Funkcja zarządza takimi aspektami gracza jak ruch, animacja, kolizje, itd
func _physics_process(delta: float):
	set_player_speed()
	move_and_slide()
	detect_collision()
#endregion


#region Zarządzanie ruchem gracza - szybkośc, animacja, itd
## Funkcja ustawia szybkość gracza
##
## Szybkość ustawiana jest na podstawie kierunku poruszania się gracza. Kierunek ten jest 
## wyznaczany na podstawie przycisków jakie aktualnie wciska gracz
func set_player_speed():
	var direction: Vector2 = Input.get_vector("player_move_left","player_move_right", \
			"player_move_up","player_move_down")
	direction.normalized()
	velocity = direction * SPEED
#endregion


#region Kolizje
func detect_collision():
	var collision_count : int = get_slide_collision_count()
	for i : int in collision_count:
		var collision : KinematicCollision2D = get_slide_collision(i)
		var collider : Object = collision.get_collider()
		if collider is BubbleScore:
			collider.hit() # zawołamy metodę hit z BubbleScore
			GameEvents.OnScoreBubbleHit.emit() # z Necromancer wyemitujemy sygnał AddPoint. Ten sygnał złapie HUD i zaktualizuje punktację
		elif collider is BubbleKiller:
			collider.hit()
			GameEvents.OnKillerBubbleHit.emit()
#endregion
