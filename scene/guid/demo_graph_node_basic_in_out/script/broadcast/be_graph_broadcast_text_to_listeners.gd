class_name BeGraphBroadcastTextToListeners
extends Node

signal on_received_text_from_remote(text:String)

@export var _listeners:Array[BeGraphAbstractTextFromRemoteListener] = []
@export var _parent_node:Node = null

func _ready() -> void:
	refresh_list_of_listeners()

func _search_in_childrens_for_all_listeners(node:Node):
	for child in node.get_children():
		if child is BeGraphAbstractTextFromRemoteListener:
			_listeners.append(child)
		else:
			_search_in_childrens_for_all_listeners(child)

func refresh_list_of_listeners():
	_listeners.clear()
	_search_in_childrens_for_all_listeners(_parent_node)


func push_text_to_all_listeners(text:String):
	on_received_text_from_remote.emit(text)
	for listener in _listeners:
		if listener:
			listener.emit_text_received_from_remote(text)
