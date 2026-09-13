extends Control


func _ready() -> void:
	$VBoxContainer/BotonJugar.pressed.connect(_on_boton_jugar_pressed)
	$VBoxContainer/BotonSalir.pressed.connect(_on_boton_salir_pressed)

func _on_boton_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://tablero.tscn")

func _on_boton_salir_pressed() -> void:
	get_tree().quit()
	
