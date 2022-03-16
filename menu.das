require daslib/media
require levelBuild
require globalVarAndStruct

def close_menu()
    clear(buttons_menu)
def load_menu()
    clear_level()
    main_menu()

def main_menu()
    //create_button_menu(float2(100f, 100f), float2(400f, 400f), 0x0000ff, 0xffff, true)
    //create_button_menu(float2(WIDTH_SCREEN/2-200, HEIGHT_SCREEN/2-200), float2(400f, 400f), "restart", 0xffffff, 0x00ff00, 0xff0000)
    create_back_menu(float2(0, 0), float2(WIDTH_SCREEN, HEIGHT_SCREEN), 0xb0234d)
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2-200), float2(500, 100), "restart", 0xffff, 0xf0ff00, 0xff00f0)
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2), float2(500, 100), "exit", 0xffff, 0xf0ff00, 0xff00f0)
    
def create_button_menu(var pos: float2; scale: float2; tag:string; color_def: uint; color_cross: uint; color_click: uint)
    var button_menu: Button_menu
    button_menu.text.font_size = 50f//scale.x//3f
    button_menu.text.pos = pos - scale/2f
    button_menu.text.text = tag
    button_menu.pressed = true
    button_menu.tag = tag
    button_menu.color = color_def
    button_menu.color_def = color_def
    button_menu.color_cross = color_cross
    button_menu.color_click = color_click
    button_menu.pos = pos - scale/2f
    button_menu.collider.topLeftCorner = pos
    button_menu.collider.bottomRightCorner = pos + scale/2f
    push(buttons_menu, button_menu)
def create_back_menu(var pos: float2; scale: float2; color_def: uint)
    var button_menu: Button_menu
    button_menu.pressed = false
    button_menu.color = color_def
    button_menu.pos = pos
    button_menu.collider.topLeftCorner = pos
    button_menu.collider.bottomRightCorner = pos + scale
    push(buttons_menu, button_menu)

def check_buttons_menu(var b: array<Button_menu>)
    for i in range(0, length(b))
        if i < length(b) 
            if b[i].pressed
                if is_cross(b[i].collider) 
                    
                    if get_mouse_button_down(MB_LEFT) 
                        //print("click")
                        //
                        button_click(b[i])
                    else
                        b[i].color = b[i].color_cross
                else
                    b[i].color = b[i].color_def
def is_cross(var other: Rect_collider)
    var mouse: float2
    mouse = get_mouse_position()
    if ((mouse.y > other.topLeftCorner.y)
    && (mouse.y < other.bottomRightCorner.y)
    && (mouse.x > other.topLeftCorner.x)
    && (mouse.x < other.bottomRightCorner.x))
        return true;
    else
        return false;
def button_click(var b: Button_menu)
    b.color = b.color_click
    var tag = b.tag
    //if tag == "start"
        //load_level(0)
    if tag == "exit"
        print("exit")
    if tag == "restart"
        load_level(current_level)
    //if tag == "settings"
        //settings_menu()
    