extends AudioStreamPlayer

## Efekty dźwiękowe w grze
##
## Moduł odgrywa efekty dźwiękowe w grze. Jest ładowany w opcji 'autoload', przez co jest 
## modułęm globalnym, dostępnym z każdej sceny i skryptu w grze.


#region Stałe i zmienne
const _sfx_bubble_score : AudioStreamWAV = preload("res://assets/audio/sfx/BubbleScore.wav")	# Złapanie bańki
const _sfx_player_death : AudioStreamWAV = preload("res://assets/audio/sfx/death.wav")			# Śmierć gracza
#endregion


#region Odgrywanie dźwięków
## Odegranie wskazanego dźwięku
## 
## Metoda prywatne, która odgrywa wskazany dźwięk o podanej głośności
func _make_player(stream : AudioStreamWAV, volume : float) -> void:
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.name = "SFX_PLAYER"
	sfx_player.volume_db = volume
	add_child(sfx_player)
	sfx_player.play()
	await sfx_player.finished
	sfx_player.queue_free()


## Złapanie bańki
##
## Odegranie dźwięku w momencie złapania bańki
func play_score_bubble():
	_make_player(_sfx_bubble_score, 0.0)


## Śmierć gracza
##
## Odegranie dźwięku w momencie straty życia przez gracza
func play_player_death():
	_make_player(_sfx_player_death, 10.0)
#endregion
