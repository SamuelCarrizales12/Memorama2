extends TextureButton

signal carta_seleccionada(carta_node)

@export var imagen_reverso: Texture2D
var imagen_frente:Texture2D
var bocarriba:bool = false

func _ready() -> void :
	texture_normal = imagen_reverso
	bocarriba = false

func revelar_carta() -> void:
	bocarriba = true
	texture_normal = imagen_frente

func _on_pressed() -> void:
	if not bocarriba:
		carta_seleccionada.emit(self)

func desactivar_carta() -> void:
	disabled = true

func ocultar_carta() -> void:
	print("Ocultando carta... La imagen de reverso es: ", imagen_reverso)
	bocarriba = false
	texture_normal = imagen_reverso



		
