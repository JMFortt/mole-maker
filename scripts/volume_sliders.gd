extends Control

func _ready():
	$MusicHSlider.value = linear_to_db(AudioManager.music_player.volume_db)
	$MusicHSlider.connect("value_changed", AudioManager.set_music_volume)
	$SFXHSlider2.value = linear_to_db(AudioManager.click_player.volume_db)
	$SFXHSlider2.connect("value_changed", AudioManager.set_sfx_volume)
