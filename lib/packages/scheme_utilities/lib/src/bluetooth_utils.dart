class BLE {
  BLE._();


  static DevShortcuts hotReload = DevShortcuts([KEY_ALT_LEFT, KEY_SLASH]);
  static DevShortcuts reload =
      DevShortcuts([KEY_ALT_LEFT, KEY_SHIFT_RIGHT, KEY_SLASH]);
  static DevShortcuts run =
      DevShortcuts([KEY_ALT_LEFT, KEY_SHIFT_RIGHT, KEY_F10]);

  /// Enters the command for flutter build runner build. For now you need to highlight the terminal.
  static DevShortcuts buildRunner =
      DevShortcuts('flutter packages pub run build_runner build'.codeUnits);


  customShortcut(String input) => DevShortcuts(input.codeUnits);

  static const Map<String, int> key = {
    'a': KEY_A,
    'b': KEY_B,
    'c': KEY_C,
    'd': KEY_D,
    'e': KEY_E,
    'f': KEY_F,
    'g': KEY_G,
    'h': KEY_H,
    'i': KEY_I,
    'j': KEY_J,
    'k': KEY_K,
    'l': KEY_L,
    'm': KEY_M,
    'n': KEY_N,
    'o': KEY_O,
    'p': KEY_P,
    'q': KEY_Q,
    'r': KEY_R,
    's': KEY_S,
    't': KEY_T,
    'u': KEY_U,
    'v': KEY_V,
    'w': KEY_W,
    'x': KEY_X,
    'y': KEY_Y,
    'z': KEY_Z,
    ' ': KEY_SPACE,
    '\n': KEY_RETURN
  };

  static const int KEY_NONE = (0x00);
  static const int KEY_A = (0x04);
  static const int KEY_B = (0x05);
  static const int KEY_C = (0x06);
  static const int KEY_D = (0x07);
  static const int KEY_E = (0x08);
  static const int KEY_F = (0x09);
  static const int KEY_G = (0x0A);
  static const int KEY_H = (0x0B);
  static const int KEY_I = (0x0C);
  static const int KEY_J = (0x0D);
  static const int KEY_K = (0x0E);
  static const int KEY_L = (0x0F);
  static const int KEY_M = (0x10);
  static const int KEY_N = (0x11);
  static const int KEY_O = (0x12);
  static const int KEY_P = (0x13);
  static const int KEY_Q = (0x14);
  static const int KEY_R = (0x15);
  static const int KEY_S = (0x16);
  static const int KEY_T = (0x17);
  static const int KEY_U = (0x18);
  static const int KEY_V = (0x19);
  static const int KEY_W = (0x1A);
  static const int KEY_X = (0x1B);
  static const int KEY_Y = (0x1C);
  static const int KEY_Z = (0x1D);
  static const int KEY_1 = (0x1E);
  static const int KEY_2 = (0x1F);
  static const int KEY_3 = (0x20);
  static const int KEY_4 = (0x21);
  static const int KEY_5 = (0x22);
  static const int KEY_6 = (0x23);
  static const int KEY_7 = (0x24);
  static const int KEY_8 = (0x25);
  static const int KEY_9 = (0x26);
  static const int KEY_0 = (0x27);
  static const int KEY_RETURN = (0x28);
  static const int KEY_ESCAPE = (0x29);
  static const int KEY_BACKSPACE = (0x2A);
  static const int KEY_TAB = (0x2B);
  static const int KEY_SPACE = (0x2C);
  static const int KEY_MINUS = (0x2D);
  static const int KEY_EQUAL = (0x2E);
  static const int KEY_BRACKET_LEFT = (0x2F);
  static const int KEY_BRACKET_RIGHT = (0x30);
  static const int KEY_BACKSLASH = (0x31);
  static const int KEY_EUROPE_1 = (0x32);
  static const int KEY_SEMICOLON = (0x33);
  static const int KEY_APOSTROPHE = (0x34);
  static const int KEY_GRAVE = (0x35);
  static const int KEY_COMMA = (0x36);
  static const int KEY_PERIOD = (0x37);
  static const int KEY_SLASH = (0x38);
  static const int KEY_CAPS_LOCK = (0x39);
  static const int KEY_F1 = (0x3A);
  static const int KEY_F2 = (0x3B);
  static const int KEY_F3 = (0x3C);
  static const int KEY_F4 = (0x3D);
  static const int KEY_F5 = (0x3E);
  static const int KEY_F6 = (0x3F);
  static const int KEY_F7 = (0x40);
  static const int KEY_F8 = (0x41);
  static const int KEY_F9 = (0x42);
  static const int KEY_F10 = (0x43);
  static const int KEY_F11 = (0x44);
  static const int KEY_F12 = (0x45);
  static const int KEY_PRINT_SCREEN = (0x46);
  static const int KEY_SCROLL_LOCK = (0x47);
  static const int KEY_PAUSE = (0x48);
  static const int KEY_INSERT = (0x49);
  static const int KEY_HOME = (0x4A);
  static const int KEY_PAGE_UP = (0x4B);
  static const int KEY_DELETE = (0x4C);
  static const int KEY_END = (0x4D);
  static const int KEY_PAGE_DOWN = (0x4E);
  static const int KEY_ARROW_RIGHT = (0x4F);
  static const int KEY_ARROW_LEFT = (0x50);
  static const int KEY_ARROW_DOWN = (0x51);
  static const int KEY_ARROW_UP = (0x52);
  static const int KEY_NUM_LOCK = (0x53);
  static const int KEY_KEYPAD_DIVIDE = (0x54);
  static const int KEY_KEYPAD_MULTIPLY = (0x55);
  static const int KEY_KEYPAD_SUBTRACT = (0x56);
  static const int KEY_KEYPAD_ADD = (0x57);
  static const int KEY_KEYPAD_ENTER = (0x58);
  static const int KEY_KEYPAD_1 = (0x59);
  static const int KEY_KEYPAD_2 = (0x5A);
  static const int KEY_KEYPAD_3 = (0x5B);
  static const int KEY_KEYPAD_4 = (0x5C);
  static const int KEY_KEYPAD_5 = (0x5D);
  static const int KEY_KEYPAD_6 = (0x5E);
  static const int KEY_KEYPAD_7 = (0x5F);
  static const int KEY_KEYPAD_8 = (0x60);
  static const int KEY_KEYPAD_9 = (0x61);
  static const int KEY_KEYPAD_0 = (0x62);
  static const int KEY_KEYPAD_DECIMAL = (0x63);
  static const int KEY_EUROPE_2 = (0x64);
  static const int KEY_APPLICATION = (0x65);
  static const int KEY_POWER = (0x66);
  static const int KEY_KEYPAD_EQUAL = (0x67);
  static const int KEY_F13 = (0x68);
  static const int KEY_F14 = (0x69);
  static const int KEY_F15 = (0x6A);
  static const int KEY_CONTROL_LEFT = (0xE0);
  static const int KEY_SHIFT_LEFT = (0xE1);
  static const int KEY_ALT_LEFT = (0xE2);
  static const int KEY_GUI_LEFT = (0xE3);
  static const int KEY_CONTROL_RIGHT = (0xE4);
  static const int KEY_SHIFT_RIGHT = (0xE5);
  static const int KEY_ALT_RIGHT = (0xE6);
  static const int KEY_GUI_RIGHT = (0xE7);
}

class DevShortcuts {
  final List<int> characters;

  DevShortcuts(this.characters);
}
