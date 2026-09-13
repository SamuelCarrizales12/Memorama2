extends Control

@export var imagenes_disponibles: Array[Texture2D]
var cartas_seleccionadas: Array = []
var procesando: bool = false
var parejas_encontradas: int = 0
var parejas_necesarias: int = 0
var intentos: int = 0

func _ready() -> void:
	var cartas = $CenterContainer/GridContainer.get_children()
	@warning_ignore("integer_division")
	parejas_necesarias = cartas.size() / 2
	
	imagenes_disponibles.shuffle()
	var imagenes_elegidas = imagenes_disponibles.slice(0, parejas_necesarias)
	var mazo = imagenes_elegidas + imagenes_elegidas
	mazo.shuffle()
	
	for i in range(cartas.size()):
		cartas[i].imagen_frente = mazo[i]
		cartas[i].carta_seleccionada.connect(_on_carta_seleccionada)
	
	# Configuración de victoria (fuera del bucle for)
	$CanvasLayer/PantallaVictoria.hide()
	$CanvasLayer/PantallaVictoria/BotonReiniciar.pressed.connect(_on_boton_reiniciar_pressed)
	$CanvasLayer/PantallaVictoria/BotonSalir2.pressed.connect(_on_boton_salir2_pressed)
func _on_carta_seleccionada(carta_node) -> void:
	if procesando or carta_node in cartas_seleccionadas:
		return
	
	carta_node.revelar_carta()
	cartas_seleccionadas.append(carta_node)	

	if cartas_seleccionadas.size() == 2:
		procesando = true
		intentos += 1
		$LabelIntentos.text = "Intentos: " + str(intentos)
		
		if cartas_seleccionadas[0].imagen_frente == cartas_seleccionadas[1].imagen_frente:
			print("¡Son iguales! 🎉")
			cartas_seleccionadas[0].desactivar_carta()
			cartas_seleccionadas[1].desactivar_carta()
			cartas_seleccionadas.clear()
			procesando = false
			
			parejas_encontradas += 1
			if parejas_encontradas == parejas_necesarias:
				$CanvasLayer/PantallaVictoria/LabelMensaje.text = "¡Ganaste!\nTotal de intentos: " + str(intentos)
				$CanvasLayer/PantallaVictoria.show()
		else:
			print("No coinciden ❌")
			await get_tree().create_timer(1.0).timeout
			cartas_seleccionadas[0].ocultar_carta()
			cartas_seleccionadas[1].ocultar_carta()
			cartas_seleccionadas.clear()
			procesando = false

func _on_boton_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()

func _on_boton_salir2_pressed() ->  void:
	get_tree().quit()
