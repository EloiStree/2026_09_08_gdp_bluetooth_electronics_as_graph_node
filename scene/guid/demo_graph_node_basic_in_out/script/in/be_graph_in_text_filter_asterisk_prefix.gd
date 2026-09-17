class_name BeGraphInTextFilterAsteriskPrefix
extends Node


signal on_value_found_as_string(value_as_text:String)

@export var _listener:BeGraphAbstractTextFromRemoteListener
@export var _start_end_char:String="*"
@export var _prefix_to_value:String="G"

func _ready() -> void:
	if _listener:
		_listener.on_request_to_handle_received_text_from_remote.connect(push_in_text)

func push_in_text(text:String):
	# *G50*
	if _start_end_char=="":
		if text.begins_with(_prefix_to_value):
			var value_str:String=text.substr(_prefix_to_value.length(),text.length()-_prefix_to_value.length())
			on_value_found_as_string.emit(value_str)
			
	elif text.begins_with(_start_end_char) and text.ends_with(_start_end_char):
		var substr:String=text.substr(1,text.length()-2)
		if substr.begins_with(_prefix_to_value):
			var value_str:String=substr.substr(_prefix_to_value.length(),substr.length()-_prefix_to_value.length())
			on_value_found_as_string.emit(value_str)
		
