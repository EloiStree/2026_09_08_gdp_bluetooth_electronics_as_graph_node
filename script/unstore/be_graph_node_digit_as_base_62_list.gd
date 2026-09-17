class_name BeGraphNodeDigitAsBase62List
extends Node



signal on_full_text_debug(text:String)


@export var _line_debug_format:String = "%s(%s):%s  " #Label (index): BOOL


@export var _index_label_name:Array[String]=[
	"button_a",
	"button_b",
	"button_logo",
	"shake",
	"free_fall",	

	"3g",
	"6g",
	"8g",
	"logo_up",
	"logo_down",
	
	"screen_up",
	"screen_down",
	"tilt_left",
	"tilt_right",
	"pin03",
	
	"pin12",
	"pin13",
	"pin14",
	"pin15",
	"pin16",

	"pin08",
	"pin09",
	"pin00",
	"pin01",
	"pin02",
]
@export var _char_array_to_five_booleans:Array[String]=[]
@export var _five_boolean_value:Array[bool]=[]



func push_in_text_to_process(text:String):
	text = text.strip_edges()
	if text.begins_with("B_"):
		text = text.substr(2)

	_char_array_to_five_booleans.clear()	
	_five_boolean_value.clear()
	
	for character in text:
		character = character.strip_edges()
		_char_array_to_five_booleans.append(character)	
		_five_boolean_value.append_array(integer_index_to_five_booleans(parse_b62_to_index(character)))

	var as_binarry_string:String = ""
	for b in _five_boolean_value:
		as_binarry_string += "1" if b else "0"

	var debug:String = as_binarry_string + "\n"
	for i in range(_five_boolean_value.size()):
			var label_found:String =  "UNKNOWN" if _index_label_name.size() <= i else _index_label_name[i]
			debug += (_line_debug_format % [label_found, str(i), str(_five_boolean_value[i])]) + "\n"
	on_full_text_debug.emit(debug)




const BASE62_CHARS:String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"


func parse_b62_to_index(character:String) -> int:
	if character.length() == 0:
		return -1
	return BASE62_CHARS.find(character)


var _index_to_five_boolean:Array[Array]=[
	[false, false, false, false, false],
	[false, false, false, false, true],
	[false, false, false, true, false],
	[false, false, false, true, true],
	[false, false, true, false, false],
	[false, false, true, false, true],
	[false, false, true, true, false],
	[false, false, true, true, true],
	[false, true, false, false, false],
	[false, true, false, false, true],
	[false, true, false, true, false],
	[false, true, false, true, true],
	[false, true, true, false, false],
	[false, true, true, false, true],
	[false, true, true, true, false],
	[false, true, true, true, true],
	[true, false, false, false, false],
	[true, false, false, false, true],
	[true, false, false, true, false],
	[true, false, false, true, true],
	[true, false, true, false, false],
	[true, false, true, false, true],
	[true, false, true, true, false],
	[true, false, true, true, true],
	[true, true, false, false, false],
	[true, true, false, false, true],
	[true, true, false, true, false],
	[true, true, false, true, true],
	[true, true, true, false, false],
	[true, true, true, false, true],
	[true, true, true, true, false],
	[true, true, true, true, true],
]

func array_to_boolean_array(values:Array) -> Array[bool]:
	var result:Array[bool] = []
	for value in values:
		result.append(bool(value))
	return result


func integer_index_to_five_booleans(value:int)->Array[bool]:
	if value < 0 or value >= _index_to_five_boolean.size():
		return [false,false,false,false,false]
	return array_to_boolean_array(_index_to_five_boolean[value])
