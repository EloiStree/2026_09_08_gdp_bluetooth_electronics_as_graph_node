class_name BeGraphEmitFromButtonNameTextUsingCase
extends Node

signal on_text_emitted(text:String)


@export var _emitter:BeGraphAbstractTextToRemoteEmitter
@export var _linked_button:Button
@export var _inverse_case:bool=false

func _ready() -> void:
	_linked_button.button_down.connect(_on_down)
	_linked_button.button_up.connect(_on_up)

func _on_down():
	if not _inverse_case:
		_emit_text(_linked_button.text.to_upper())
	else :
		_emit_text(_linked_button.text.to_lower())

func _on_up():
	if not _inverse_case:
		_emit_text(_linked_button.text.to_lower())
	else:		
		_emit_text(_linked_button.text.to_upper())

func _emit_text(text:String):
	on_text_emitted.emit(text)
	if _emitter:
		_emitter.emit_text_to_send_to_remote(text)