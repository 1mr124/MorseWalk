extends Node2D

var buffer = ""
const LETTER_TIMEOUT = 1.0
var letter_timer := Timer.new()

# --- Morse dictionary ---
const REVERSE_MORSE = {
	".-": "A",
	"-...": "B",
	"-.-.": "C",
	"-..": "D",
	".": "E",
	"..-.": "F",
	"--.": "G",
	"....": "H",
	"..": "I",
	".---": "J",
	"-.-": "K",
	".-..": "L",
	"--": "M",
	"-.": "N",
	"---": "O",
	".--.": "P",
	"--.-": "Q",
	".-.": "R",
	"...": "S",
	"-": "T",
	"..-": "U",
	"...-": "V",
	".--": "W",
	"-..-": "X",
	"-.--": "Y",
	"--..": "Z",

	"-----": "0",
	".----": "1",
	"..---": "2",
	"...--": "3",
	"....-": "4",
	".....": "5",
	"-....": "6",
	"--...": "7",
	"---..": "8",
	"----.": "9",

	".-.-.-": ".",
	"--..--": ",",
	"..--..": "?",
	".----.": "'",
	"-.-.--": "!",
	"-..-.": "/",
	"-.--.": "(",
	"-.--.-": ")",
	".-...": "&",
	"---...": ":",
	"-.-.-.": ";",
	"-...-": "=",
	".-.-.": "+",
	"-....-": "-",
	"..--.-": "_",
	".-..-.": "\"",
	"...-..-": "$",
	".--.-.": "@"
}

func setup_timer():
	letter_timer.one_shot = true
	letter_timer.wait_time = LETTER_TIMEOUT
	letter_timer.timeout.connect(_on_letter_timeout)
	add_child(letter_timer)

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting Morse Logger!")
	setup_timer()


# Input handling
func _input(event):
	if event is InputEventKey and event.pressed:
		handle_morse_input(event.keycode)

func handle_morse_input(keycode):
	match keycode:
		KEY_PERIOD: buffer += "."
		KEY_MINUS: buffer += "-"
		KEY_SPACE:
			#buffer += " "
			decode_buffer()
			return
	letter_timer.start()
		
func _on_letter_timeout():
	decode_buffer()

func decode_symbol(sequence: String) -> String:
		return REVERSE_MORSE.get(sequence, "")

# Check buffer for mapping words... 
func decode_buffer():
	if buffer == "":
		return
	var letter = decode_symbol(buffer)
	if letter != "":
		print("Decoded:", letter)
	else:
		print("Unknown sequence:", buffer)
	buffer = ""
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
