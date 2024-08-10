extends CharacterBody2D
class_name Necromancer
@onready var _necromancer_sprite = $AnimatedSprite2D


#region Stałe i zmienne
const SPEED = 300.0		# Szybkość gracza
#endregion


#region Wbudowane funkcje silnika Godot
## Funkcja zarządza przebiegiem wszystkiego co dzieje się z graczem
##
## Funkcja zarządza takimi aspektami gracza jak ruch, animacja, kolizje, itd
func _physics_process(delta: float):
	move()
	detect_collision()
#endregion


#region Zarządzanie ruchem gracza - szybkość, animacja, itd

## Funkcja 
func move():
	var direction : Vector2 = set_player_speed()
	if direction.x > 0:
		_necromancer_sprite.flip_h = false
	else:
		_necromancer_sprite.flip_h = true
	play_animation(direction)
	move_and_slide()
	
func play_animation(direction : Vector2):
	if direction:
		_necromancer_sprite.play("run")
	else:
		_necromancer_sprite.play("idle")
	
	
## Funkcja ustawia szybkość gracza
##
## Szybkość ustawiana jest na podstawie kierunku poruszania się gracza. Kierunek ten jest 
## wyznaczany na podstawie przycisków jakie aktualnie wciska gracz
func set_player_speed() -> Vector2:
	var direction: Vector2 = Input.get_vector("player_move_left","player_move_right", \
			"player_move_up","player_move_down")
	direction.normalized()
	velocity = direction * SPEED
	return direction
#endregion


#region Kolizje
## Zarządzanie kolizjami
##
## Funckja zarządza tym co się ma wydarzyć w czasie kolizji pomiędzy bańkami a graczem
func detect_collision():
	var collision_count : int = get_slide_collision_count()
	for i : int in collision_count:
		var collision : KinematicCollision2D = get_slide_collision(i)
		var collider : Object = collision.get_collider()
		if collider is BubbleScore:
			collider.hit() # zawołamy metodę hit z BubbleScore
			GameEvents.OnScoreBubbleHit.emit()
		elif collider is BubbleKiller:
			collider.hit()
			# TODO: trzeba odegrać animację śmierci gracza i poczekać na jej koniec
			GameEvents.OnKillerBubbleHit.emit()
#endregion
