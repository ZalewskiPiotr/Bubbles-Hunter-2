extends Node

## Skrypt z sygnałami (zdarzeniami)
##
## Skrypt zawiera zdarzenia jakie dzieją się w grze i służą do komunikacji pomiędzy modułami

## Zebranie bańki przez gracza
## 
## Emisja sygnału: necromancer.gd -> detect_collision()
## Odbiór sygnału: hud.gd -> _ready()
signal OnScoreBubbleHit
