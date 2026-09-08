class_name BeGraphEmitFromToggleOnOnOff
extends Node

signal on_text_emitted(text:String)


@export var _emitter:BeGraphAbstractTextToRemoteEmitter
@export var _linked_button:Button
@export var _on_toggle_on:String
@export var _on_toggle_off:String


func _ready() -> void:
	_linked_button.toggled.connect(_on_down)

func _on_down(value:bool):
	_emit_text(_on_toggle_on if value else _on_toggle_off)


func _emit_text(text:String):
	on_text_emitted.emit(text)
	if _emitter:
		_emitter.emit_text_to_send_to_remote(text)
