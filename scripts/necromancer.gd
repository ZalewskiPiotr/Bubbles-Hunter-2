extends CharacterBody2D
class_name Necromancer
@onready var _necromancer_sprite = $AnimatedSprite2D


#region Stałe i zmienne
const SPEED = 300.0		# Szybkość gracza
var _player_alive : bool = true		# Informacja czy gracz jest ciągle żywy
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

## Funkcja zarządzająca ruchem i animacją
##
## Funkcja odpowiada za zarządzaniem ruchem i aktualnie odgrywaną animacją
func move():
	var direction : Vector2 = set_player_speed()
	if direction.x > 0:
		_necromancer_sprite.flip_h = false
	else:
		_necromancer_sprite.flip_h = true
	
	play_animation(direction)
	if _player_alive:
		move_and_slide()
	

## Animacja postaci gracza
##
## Funkcja odgrywa animację	postaci gracza w zależności od warunków: idle, move, death
func play_animation(direction : Vector2):
	if direction and _player_alive:
		_necromancer_sprite.play("run")
	elif !direction and _player_alive:
		_necromancer_sprite.play("idle")
	elif !_player_alive:
		_necromancer_sprite.play("death")
	else:
		print("Unexpected situation")
	
	
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
			Sfx.play_score_bubble()
			GameEvents.OnScoreBubbleHit.emit()
		elif collider is BubbleKiller:
			collider.hit()
			_player_alive = false
			Sfx.play_player_death()
			await _necromancer_sprite.animation_finished # Żeby wywołał się ten signal to animacja nie może być w pętli
			GameEvents.OnKillerBubbleHit.emit()


func continue_game() -> void:
	_player_alive = true
#endregion
