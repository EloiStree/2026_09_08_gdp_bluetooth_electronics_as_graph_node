class_name BeGraphNodeAnalogAsBase62List
extends Node


signal on_full_text_debug(text:String)


@export var _line_debug_format:String = "%s (%s): %s  %.2f  %.2f " #Label (CHAR): index, percent, value


@export var _index_label_name:Array[String]=[
	"minute_60",
	"second_60",

	"sound_level_255",
	"light_level_255",
	"compass_360",
	"temperature_b64",

	"pin00_1023",
	"pin01_1023",
	"pin02_1023",

	"acceleration_x_1023",
	"acceleration_y_1023",
	"acceleration_z_1023",

]
@export var _index_to_label_multiplicator:Array[float]=[
	60,60,1,1,360,0,1,1,1,1,1,1,1

]
@export var _index_array_to_char:Array[String]=[]
@export var _index_array_to_index_b64:Array[int]=[]
@export var _index_array_to_percent_b64:Array[float]=[]
@export var _index_array_to_value_multiplicated:Array[float]=[]


func push_in_text_to_process(text:String):
	text = text.strip_edges()
	if text.begins_with("A_"):
		text = text.substr(2)

	_index_array_to_char.clear()	
	_index_array_to_index_b64.clear()
	_index_array_to_percent_b64.clear()
	_index_array_to_value_multiplicated.clear()
	
	var index :int=0
	for character in text:
		_index_array_to_char.append(character)	
		var index_b64:int = parse_b62_to_index(character)
		_index_array_to_index_b64.append(index_b64)
		var percent:float = parse_b62_to_percent(character)
		_index_array_to_percent_b64.append(percent)
		var value:float = percent*(_index_to_label_multiplicator[index] if index < _index_to_label_multiplicator.size() else 1.0)
		if _index_to_label_multiplicator[index]==0:
			value= index_b64
		_index_array_to_value_multiplicated.append(value)
		index += 1
	

	var debug:String = ""
	for i in range(_index_array_to_char.size()):
		var label:String = "UNKNOWN"
		if i < _index_label_name.size():
			label = _index_label_name[i]
		var char :String= _index_array_to_char[i]
		var index_b64 :int= _index_array_to_index_b64[i]
		var percent_b64 :float= _index_array_to_percent_b64[i]
		var value:float = _index_array_to_value_multiplicated[i]
		debug += _line_debug_format % [label, char, str(index_b64), percent_b64, value] + "\n"
	on_full_text_debug.emit(debug)




const BASE62_CHARS:String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"


func parse_b62_to_index(character:String) -> int:
	if character.length() != 1:
		return -1
	return BASE62_CHARS.find(character)

func parse_b62_to_percent(character:String) -> float:
	if character.length() != 1:
		return 0.0
	var index:int = BASE62_CHARS.find(character)
	if index < 0:
		return 0.0
	return float(index) / float(BASE62_CHARS.length() - 1)
