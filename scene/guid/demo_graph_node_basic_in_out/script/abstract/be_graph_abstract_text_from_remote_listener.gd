class_name BeGraphAbstractTextFromRemoteListener
extends Node

signal on_request_to_handle_received_text_from_remote(text_to_handle:String)

@export var _linked_graph_node:GraphNode
		
func emit_text_received_from_remote(text:String):
	on_request_to_handle_received_text_from_remote.emit(text)
	
