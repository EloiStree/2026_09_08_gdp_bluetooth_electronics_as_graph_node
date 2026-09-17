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


func _set_current_value(value:Color) -> void:
	_current_value=value
	on_value_changed.emit(_current_value)
	for color_rect in _affected_slider:
		if color_rect!=null:
			color_rect.color=_current_value

func push_in_text(text:String):
	# *LR50G0B255* 
	# R__G__B__
	# *LR255G0B0*
	#RGBCYP0
	
	if text.begins_with(_start_end_char) and text.ends_with(_start_end_char):
		var substr:String=text.substr(1,text.length()-2)
		if substr.begins_with(_prefix_to_value):
			var value_str:String=substr.substr(_prefix_to_value.length(),substr.length()-_prefix_to_value.length())
			if value_str.length() ==1:
				match value_str.to_lower():
					"r": 
						_set_current_value(Color(1, 0, 0, 1))
					"g":
						_set_current_value(Color(0, 1, 0, 1))
					"b":
						_set_current_value(Color(0, 0, 1, 1))
					"y":
						_set_current_value(Color(1, 1, 0, 1))
					"c":
						_set_current_value(Color(0, 1, 1, 1))
					"p":
						_set_current_value(Color(1, 0, 1, 1))
					"w":
						_set_current_value(Color(1, 1, 1, 1))
					"0":
						_set_current_value(Color(0, 0, 0, 1))
					_:
						pass
			
			else:
				var split = value_str.split("_")
				if split.size() ==3:
					var r=split[0].to_int()
					var g=split[1].to_int()
					var b=split[2].to_int()
					_set_current_value(Color(r/255.0, g/255.0, b/255.0, 1))
					return
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
					_set_current_value(Color(r/255.0, g/255.0, b/255.0, a/255.0))

		

# *C128* COMPASS
# *S15* SOUND
# *L0* LIGHT_MICRO_BIT
# *T31* TEMPERATURE
# *AX-16* ACCELEROMETER_X
# *AY1056* ACCELEROMETER_Y
# *AZ-32* ACCELEROMETER_Z
# *AS1056* ACCELEROMETER_STRENGTH
# *ML0* MOTOR_LEFT
# *MR0* MOTOR_RIGHT
# *LRL918* LIGHT_RESISTANCE_LEFT
# *LRR935* LIGHT_RESISTANCE_RIGHT
# *LT0* LINE_TACK_0123
# *TIME490390* TIME
# *US23* ULTRASONIC
# *CLR0G255B255* COLOR_LEFT_RESISTANCE
# *CRR0G255B255* COLOR_RIGHT_RESISTANCE
# *LT1* LINE_TRACK_LEFT
# *RT1* LINE_TRACK_RIGHT

# *EVSHAKE* SHAKED
# *EV3G* 3G FORCE
# *EV6G* 6G FORCE
# *EV8G* 8G FORCE
# *EVTR* TILT RIGHT
# *EVTL* TILT LEFT
# *EVLU* LOGO UP
# *EVLD* LOGO DOWN
# *EVSU* SCREEN UP
# *EVSU* SCREEN DOWN
# *EVFALL* MICRO BIT FALL

# *LOGO* LOGO TRUE
# *logo* LOGO FALSE


# *A* BUTTON A TRUE
# *a* BUTTON A FALSE

# *B* BUTTON B TRUE
# *b* BUTTON B FALSE

# *LOUD* LOUD TRUE
# *quiet* LOUD FALSE

# *EVAB* TRIGGER A+B



#
	
