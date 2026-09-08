class_name BeGraphInTextToLightIndicator
extends Node


signal on_value_changed(value:Color)

@export var _listener:BeGraphAbstractTextFromRemoteListener
@export var _current_value:Color=Color(1, 1, 1, 1)

@export var _start_end_char:String="*"
@export var _prefix_to_value:String="L"
@export var _affected_slider:Array[ColorRect]=[]


func _ready() -> void:
	if _listener:
		_listener.on_request_to_handle_received_text_from_remote.connect(push_in_text)

func push_in_text(text:String):
	# *LR50G0B255* 
	# R__G__B__
	# *LR255G0B0*
	
	if text.begins_with(_start_end_char) and text.ends_with(_start_end_char):
		var substr:String=text.substr(1,text.length()-2)
		if substr.begins_with(_prefix_to_value):
			var value_str:String=substr.substr(_prefix_to_value.length(),substr.length()-_prefix_to_value.length())
			var r:int=0
			var g:int=0
			var b:int=0
			var a:int=255
			var regex:RegEx=RegEx.new()
			regex.compile("R(\\d+)G(\\d+)B(\\d+)(A(\\d+))?")
			var match:RegExMatch=regex.search(value_str)
			if match:
				r=match.get_string(1).to_int()
				g=match.get_string(2).to_int()
				b=match.get_string(3).to_int()
				if match.get_string(5):
					a=match.get_string(5).to_int()
				_current_value=Color(r/255.0, g/255.0, b/255.0, a/255.0)
				on_value_changed.emit(_current_value)
				for color_rect in _affected_slider:
					if color_rect!=null:
						color_rect.color=_current_value
	
