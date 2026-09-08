class_name BeGraphEmitFromButtonOnDownUp
extends Node

signal on_text_emitted(text:String)

@export var _emitter:BeGraphAbstractTextToRemoteEmitter
@export var _linked_button:Button
@export var _on_down_text:String
@export var _on_up_text:String


func _ready() -> void:
	_linked_button.button_down.connect(_on_down)
	_linked_button.button_up.connect(_on_up)

func _on_down():
		_emit_text(_on_down_text)

func _on_up():
		_emit_text(_on_up_text)


func _emit_text(text:String):
		on_text_emitted.emit(text)
		if _emitter:
			_emitter.emit_text_to_send_to_remote(text)
