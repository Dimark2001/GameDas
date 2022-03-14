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
    create_button_menu(float2(WIDTH_SCREEN/2-200, HEIGHT_SCREEN/2-200), float2(400f, 400f), 0xffffff, 0x00ff00, 0xff0000)

def create_button_menu(var pos: float2; scale: float2; color_def: uint; color_cross: uint; color_click: uint; pressed: bool = true)
    var button_menu: Button_menu
    button_menu.pressed = pressed
    button_menu.color = color_def
    button_menu.color_def = color_def
    button_menu.color_cross = color_cross
    button_menu.color_click = color_click
    button_menu.pos = pos
    button_menu.collider.topLeftCorner = pos
    button_menu.collider.bottomRightCorner = pos + scale
    push(buttons_menu, button_menu)
def check_buttons_menu(var b_menu: array<Button_menu>)
    for i in range(0, length(b_menu))
        if b_menu[i].pressed
            if is_cross(b_menu[i].collider) 
                
                if get_mouse_button(MB_LEFT) 
                    print("click")
                    b_menu[i].color = b_menu[i].color_click
                else
                    b_menu[i].color = b_menu[i].color_cross
            else
                b_menu[i].color = b_menu[i].color_def
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