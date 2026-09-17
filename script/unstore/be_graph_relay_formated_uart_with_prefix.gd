
## Aim to to relay UART
class_name BeGraphRelayFormatedUartWithPrefix
extends Node

signal on_uart_to_relay_with_address(address:String, text:String)
signal on_uart_to_relay_with_address_formated(formated_text:String)

@export var _address_to_use_by_default:String="00:00:00:00:00:00"
@export var _prefix_text:String="uart|%s|%s"


func push_in_uart_text_with_inspector_address(text:String):
	push_in_uart_text_with_address(_address_to_use_by_default,text)	

func push_in_uart_text_with_address(address:String,text:String):
	var formated = _prefix_text%[address,text]
	on_uart_to_relay_with_address_formated.emit(formated)
	on_uart_to_relay_with_address.emit(address,text)

func set_target_address(address:String):
	_address_to_use_by_default = address

func get_target_address():
	return _address_to_use_by_default
