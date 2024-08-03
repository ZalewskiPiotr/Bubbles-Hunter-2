extends CharacterBody2D

const SPEED = 300.0		# Szybkość gracza

## Funkcja zarządza przebiegiem wszystkiego co dzieje się z graczem
func _physics_process(delta : float):
	set_player_speed()
	move_and_slide()

## Funkcja ustawia szybkość gracza
##
## Szybkość ustawiana jest na podstawie kierunku poruszania się gracza. Kierunek ten jest 
## wyznaczany na podstawie przycisków jakie aktualnie wciska gracz
func set_player_speed():
	var direction : Vector2 = Input.get_vector("player_move_left","player_move_right","player_move_up","player_move_down")
	velocity = direction * SPEED
	print(velocity)
