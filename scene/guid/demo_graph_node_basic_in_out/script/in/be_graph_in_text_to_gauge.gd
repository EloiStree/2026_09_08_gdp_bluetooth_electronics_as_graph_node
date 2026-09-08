class_name BeGraphInTextToGaugeBasic
extends Node

@export var _current_value:float=0
@export var _gauge_range_min_value:float=0
@export var _gauge_range_max_value:float=100

@export var _start_end_char:String="*"
@export var _prefix_to_value:String="G"

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
