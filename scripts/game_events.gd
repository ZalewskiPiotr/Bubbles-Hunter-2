extends Node

## Skrypt z sygnałami (zdarzeniami)
##
## Skrypt zawiera zdarzenia jakie dzieją się w grze i służą do komunikacji pomiędzy modułami

## Zebranie bańki przez gracza
## 
## Emisja sygnału: necromancer.gd -> detect_collision()
## Odbiór sygnału: hud.gd -> _ready()
signal OnScoreBubbleHit

## Zderzenie gracza z bańką KilletBubble
## 
## Emisja sygnału: necromancer.gd -> detect_collision()
## Odbiór sygnału: main_node.gd -> _ready()
signal OnKillerBubbleHit

## Zakończenie gry
##
## Zdarzenie wywoływane jest tuż przed zakończeniem gry. Już po śmierci gracza ale jeszcze przed
## wyświetleniem ekranu startowego. Zdarzenie jest wykorzystywane do zatrzymania różnych mechanik 
## w grze oraz wyświetlenia wyniku gracza
## Emisja sygnału: necromancer.gd -> detect_collision()
## Odbiór sygnału: main_node.gd -> _ready()
signal JustBeforeGameOver
