class_name BeGraphAbstractTextToRemoteEmitter
extends Node

signal on_request_to_send_text_to_remote(given_text:String)

@export var _linked_graph_node:GraphNode

func emit_text_to_send_to_remote(given_text:String):
	on_request_to_send_text_to_remote.emit(given_text)
		
	
