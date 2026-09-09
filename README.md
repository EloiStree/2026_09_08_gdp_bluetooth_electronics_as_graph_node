
```
git submodule add https://github.com/EloiStree/2026_09_08_gdp_bluetooth_electronics_as_graph_node.git addons/2026_09_08_gdp_bluetooth_electronics_as_graph_node
```

> Feel free to help with this one.

# 2026_09_08_gdp_bluetooth_electronics_as_graph_node

## Bluetooth Electronics in Godot as a Graph Node

I was a big fan of an Android application called **Bluetooth Electronics**:

[<img width="1020" height="574" alt="image" src="https://github.com/user-attachments/assets/0b6ea0eb-623b-4a92-8852-9779c3e8695f" />](https://bluetooth-electronics.fr.softonic.com/android)
https://bluetooth-electronics.fr.softonic.com/android



Unfortunately, the app was removed from the Google Play Store after Google required the developer to update it or remove it.

The application was very useful because it allowed you to create buttons, switches, and other controls that could send small pieces of text/commands to a target Bluetooth device.

I don't intend to implement the Bluetooth communication layer itself. That part can be handled by existing or user-provided Godot Bluetooth addons.

What I would like to create is a **Graph Node version of Bluetooth Electronics for Godot**.

The idea would be to provide a visual node-based interface where users could create controls such as:
* Buttons that send text or commands
* Switches/toggles
* Other simple input controls
* Configurable messages to send to a Bluetooth device
* Integration with an existing Bluetooth addon for the actual communication

The Bluetooth implementation itself is out of scope. The focus is on creating the **Godot Graph Node/UI system** that provides a similar workflow to the original Bluetooth Electronics application.

The goal is essentially to recreate the useful control-panel concept of Bluetooth Electronics, but as a native graph-based tool/workflow inside Godot.

--------------

<img width="390" height="674" alt="image" src="https://github.com/user-attachments/assets/7e01cb07-4bf2-4ca9-b6be-3949402c631e" />











-------

BLE
- https://github.com/duffrecords/GodotAndroidBle
