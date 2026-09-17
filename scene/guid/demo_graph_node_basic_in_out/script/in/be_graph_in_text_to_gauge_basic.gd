class_name BeGraphInTextToGaugeBasic
extends Node


signal on_value_changed(value:float)
signal on_value_changed_as_string(value:String)

@export var _listener:BeGraphAbstractTextFromRemoteListener
@export var _current_value:float=0
@export var _gauge_range_min_value:float=0
@export var _gauge_range_max_value:float=100
@export var _gauge_step_value:float=1

@export var _start_end_char:String="*"
@export var _prefix_to_value:String="G"

@export var _affected_slider:Slider


func _ready() -> void:
	if _listener:
		_listener.on_request_to_handle_received_text_from_remote.connect(push_in_text)

func push_in_text(text:String):
	# *G50*
	if text.begins_with(_start_end_char) and text.ends_with(_start_end_char):
		var substr:String=text.substr(1,text.length()-2)
		if substr.begins_with(_prefix_to_value):
			var value_str:String=substr.substr(_prefix_to_value.length(),substr.length()-_prefix_to_value.length())
			if value_str.is_valid_float():
				var value:float=value_str.to_float()
				if value<_gauge_range_min_value:
					value=_gauge_range_min_value
				elif value>_gauge_range_max_value:
					value=_gauge_range_max_value
				_current_value=value
				on_value_changed.emit(_current_value)
				on_value_changed_as_string.emit(str(_current_value))
				if _affected_slider:
					_affected_slider.step=_gauge_step_value
					_affected_slider.min_value=_gauge_range_min_value
					_affected_slider.max_value=_gauge_range_max_value
					_affected_slider.value=_current_value
