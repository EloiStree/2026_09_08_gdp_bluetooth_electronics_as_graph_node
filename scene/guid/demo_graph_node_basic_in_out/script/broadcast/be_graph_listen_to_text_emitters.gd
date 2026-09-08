class_name BeGraphListenToTextEmitters
extends Node

signal on_text_received_from_emitters(text:String)

@export var _emitters : Array[BeGraphAbstractTextToRemoteEmitter] = []
@export var _parent_node:Node = null

func _ready() -> void:
	refresh_liste_of_emitter()

func _search_in_childrens_for_all_emitters(node:Node):
	for child in node.get_children():
		if child is BeGraphAbstractTextToRemoteEmitter:
			_emitters.append(child)
		else:
			_search_in_childrens_for_all_emitters(child)


func refresh_liste_of_emitter():
	_unhook_emitters()
	_emitters.clear()
	_search_in_childrens_for_all_emitters(_parent_node)
	_hook_up_emitters()

func _hook_up_emitters():
	for emitter in _emitters:
		if emitter:
			emitter.on_request_to_send_text_to_remote.connect(_on_text_emitted_by_emitter)

func _unhook_emitters():
	for emitter in _emitters:
		if emitter:
			emitter.on_request_to_send_text_to_remote.disconnect(_on_text_emitted_by_emitter)

func _on_text_emitted_by_emitter(text:String):
	on_text_received_from_emitters.emit(text)
	
