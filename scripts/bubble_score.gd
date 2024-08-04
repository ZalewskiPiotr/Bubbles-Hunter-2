extends CharacterBody2D
class_name BubbleScore


#region Stałe i zmienne
const SPEED_MIN : float = 0.1		# Minimalna szybkość bańki
const SPEED_MAX : float = 5.0		# Maksymalna szybkość bańki
var _speed : float					# Szybkość bańki
@onready var _sprite = $Sprite2D	# Obiekt przechowujący grafikę
#endregion


#region Metody wbudowane
## Przygotowanie obiektu bańki
##
## W momencie gdy obiekt jest gotowy, czyli ma załadowane wszystkie podrzędne obiekty, to ustawiamy
## parametry startowe, takie jak szybkośc, kiedunek, grafika, pozycja, itp
func _ready():
	randomize() # Będzie trochę losować to się przyda
	create_velocity_vector()
	_speed = create_speed()
	create_texture()
	create_position()


## Poruszanie obiektem
##
## Obiekt bańki w czasie tworzenia dostaje parametry początkowe. Dzięki temu sam się porusza.
## W metodzie poniżej zadbano o to, aby po zderzeniu z przeszkodą obiekt dalej pozostawałw ruchu
func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(velocity * _speed)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
#endregion
		
		
#region Tworzenie nowej bańki
## Funkcja tworzy wektor o jaki ma się przesuwać bańka
##
## Wektor wynosi zawsze jeden pixel w osi x oraz 1 w osi y. Przez to mamty tylko 4 możliwe kierunki
## startu bańki. Za to dzięki temu mamy tylko jedną zmienną, która kieruje prędkością.
func create_velocity_vector():
	velocity.x = [-1, 1][randi() % 2] # Funkcja randi wybiera z dwóch wartości podanych w tablicy przed nią
	velocity.y = [-1, 1][randi() % 2]
	velocity = velocity.normalized()
	

## Funkcja tworzy prędkość bańki
##
## W zasadzie nic ciekawego tu nie ma. Prędkość powstaje losowo z zakresu podanego w stałych	
func create_speed() -> float:
	return randf_range(SPEED_MIN, SPEED_MAX)


## Funkcja tworzy grafikę bańki
##
## Mamy kilka obrazków na dysku. Losujemy numer obrazka, dodajemy go do ścieżki i ładujemy obrazek
func create_texture():
	var sprite_number = randi() % 7 + 1 # +1 powoduje, że funkcja randi() startuje od 1 zamiast od 0
	var path = "res://assets/bubbles/bubble_" + str(sprite_number) + ".png"
	_sprite.texture = load(path)
	

## Funkcja wskazuje w jakim miejscu pojawi się bańka
##
## Zajrzyj na TODO w funkcji a jak już zrobisz dobrze to opisz to w tym miejscu
func create_position():
	# TODO: do poprawy. Na razie brana jest pozycja kursora myszki ale wolałbym mieć coś losowo z 
	# obszaru gry
	position = get_viewport().get_mouse_position()
#endregion


#region Usunięcie obiektu bańki
## Reakcja na trafienie bańki przez gracza
##
## W momencie kiedy bańka zostanie trafiona przez gracza, wywoływana jest ta metoda. 
## Zaimplementowano najprostszą reakcję, czy usunięcie bańki
func hit():
	print("hit")
	queue_free()
#endregion
