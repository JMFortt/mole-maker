extends Node

@onready var music_player = AudioStreamPlayer.new()
@onready var click_player = AudioStreamPlayer.new()
var music_stream : AudioStream = preload("res://assets/audio/thinking_scientifically.mp3")
var click_sound : AudioStream = preload("res://assets/audio/mixkit-modern-technology-click.wav")
var is_playing = false

func _ready():
	# set up music player
	add_child(music_player)
	music_player.stream = music_stream
	music_player.autoplay = true

	# set up click player
	add_child(click_player)
	click_player.stream = click_sound  # Assign the click sound to the player

	# if the music isn't playing already, start it
	if not is_playing:
		music_player.play()
		is_playing = true

func set_music_volume(volume_db: float):
	music_player.volume_db = clamp(volume_db, -80, 0)

func button_click():
	click_player.play()
