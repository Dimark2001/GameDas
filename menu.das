require daslib/media
require levelBuild
require globalVarAndStruct
require gameInit

var
    selected: int
    selected_back: int = 3
    is_bar:bool

def close_menu()
    is_menu = false
    clear(buttons_menu)
    clear(labels)
def load_menu()
    if get_key_down(VK_X)
        if !is_menu
            main_menu()
        else 
            close_menu()
    if get_key_down(VK_P)
        if !is_menu
            pause_menu()
        else 
            close_menu()
        
def main_menu()
    close_menu()
    is_menu = true
    create_back_menu(float2(0, 0), float2(WIDTH_SCREEN, HEIGHT_SCREEN), BACK_MENU_COLOR1, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(0,0))
    create_back_menu(float2(100, 100), float2(WIDTH_SCREEN-200, HEIGHT_SCREEN-200), BACK_MENU_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10,10))
    
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2-200), float2(500, 100), "Start", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10, 10))
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2), float2(500, 100), "Settings", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10, 10))
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2+200), float2(500, 100), "Exit", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10, 10))

def pause_menu()
    close_menu()
    is_menu = true
    
    create_back_menu(float2(250, 150), float2(WIDTH_SCREEN-500, HEIGHT_SCREEN-300), BACK_MENU_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10,10))
    
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2-200), float2(500, 100), "Start", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10, 10))
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2), float2(500, 100), "Exit", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 3f)
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2+200), float2(500, 100), "Restart", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 3f)

def settings_menu()
    close_menu()
    is_menu = true
    create_back_menu(float2(0, 0), float2(WIDTH_SCREEN, HEIGHT_SCREEN), BACK_MENU_COLOR1, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(0,0))

    create_back_menu(float2(250, 150), float2(WIDTH_SCREEN-500, HEIGHT_SCREEN-300), BACK_MENU_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10,10))
    
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2-200), float2(500, 100), "1", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10, 10))
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2), float2(500, 100), "2", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 3f)
    create_button_menu(float2(WIDTH_SCREEN/2, HEIGHT_SCREEN/2+200), float2(500, 100), "3", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 3f)

def select_player_menu()

    if !spawn_station.open
        create_bar(float2(250, 250), spawn_station.type_player, 3, 200f)
    else
        close_menu()

def game_over_menu()
    close_menu()
    is_menu = true
    create_back_menu(float2(250, 150), float2(WIDTH_SCREEN-500, HEIGHT_SCREEN-300), BACK_MENU_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10,10))
    create_label("GAMEOVER", "mono", 100f, float2(float(WIDTH_SCREEN)/2f, 100f))
def create_bar(pos: float2; elements: array<Type_Player_Bar>; count_window: int; scale_window: float)
    create_label(name_current_level, "mono", 100f, float2(WIDTH_SCREEN/2, 100), true)
    if get_key_down(VK_D)
        selected++
    elif get_key_down(VK_A)
        selected--
    elif (get_mouse_scroll_delta()) != 0f 
        selected += int(get_mouse_scroll_delta())
    if selected > length(elements)-1
        selected = 0
    if selected < 0
        selected = length(elements)-1
        
    if selected != selected_back
        update_bar = true
    if get_key_down(VK_SPACE)
        select_player(selected, true)
    if update_bar
        update_bar = false
        select_player(selected)
        selected_back = selected
        update_bar(pos, elements, count_window, scale_window, selected)
        //print("update_bar")
def update_bar(pos: float2; elements: array<Type_Player_Bar>; count_window: int; scale_window: float; selected: int)

    close_menu()
    var count, count_win, begin: int
    var scale: float2
    var color_bar_element: uint
    scale = float2(scale_window, scale_window)
    count_win = count_window
    if length(elements) < count_win
        count = length(elements) % count_win
        count_win = length(elements)
    //create_back_menu(float2(250, 250), float2(WIDTH_SCREEN-500, HEIGHT_SCREEN-500), BACK_MENU_COLOR, BUTTON_MENU_OUTLINE_COLOR, 3f, float2(0,0))
    
    for i in range(0, length(elements))
        if elements[i].count <= 0
            color_bar_element = make_color(0.5f, 0.5f, 0.5f, 1f)
        else
            color_bar_element = BACK_MENU_COLOR
        if i == selected
            //create_button_menu(pos + float2(scale_window*float(i)-scale_window/6f, 0f), float2(scale_window, scale_window), "1", BUTTON_MENU_COLOR, BUTTON_MENU_CROSS_COLOR, BUTTON_MENU_CLICK_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10, 10))
            create_back_menu(pos + float2(scale_window*float(i), 0f), float2(scale_window, scale_window), color_bar_element, string(elements[i].count), scale_window/2f, elements[i].image)
            
            //create_button_menu(pos + float2(scale_window*float(i)-scale_window/6f, 0f), float2(scale_window, scale_window), string(elements[i]), BUTTON_MENU_COLOR, BUTTON_MENU_COLOR, BUTTON_MENU_COLOR, BUTTON_MENU_OUTLINE_COLOR, 3f)
        else
            create_back_menu(pos + float2(scale_window*float(i), 0f), float2(scale_window/1.5, scale_window/1.5), color_bar_element, string(elements[i].count), scale_window/2f, elements[i].image)
            //create_button_menu(pos + float2(scale_window*float(i), 0f), float2(scale_window/1.5f, scale_window/1.5f), string(elements[i]), BUTTON_MENU_COLOR, BUTTON_MENU_COLOR, BUTTON_MENU_COLOR, BUTTON_MENU_OUTLINE_COLOR, 0f, float2(10, 10))
def create_button_menu(var pos: float2; scale: float2; tag:string; color_def: uint; color_cross: uint; color_click: uint)
    var button_menu: Button_menu
    button_menu.text.font_size = 50f//scale.x//3f
    button_menu.text.pos = pos - float2((button_menu.text.font_size*float(length(tag)))/4f, scale.y/4f)
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
    push_clone(buttons_menu, button_menu)

def create_button_menu(var pos: float2; scale: float2; tag:string; color_def: uint; color_cross: uint; color_click: uint; color_outline: uint; scale_outline: float; offset_outline: float2 = float2(0,0))
    create_button_menu(pos+offset_outline, scale, "false", color_outline, color_outline, color_outline)
    var button_menu: Button_menu
    button_menu.text.font_size = 50f//scale.x//3f
    button_menu.text.pos = pos - float2((button_menu.text.font_size*float(length(tag)))/4f, scale.y/4f)
    button_menu.text.text = tag 
    button_menu.pressed = true
    button_menu.tag = tag
    button_menu.color = color_def
    button_menu.color_def = color_def
    button_menu.color_cross = color_cross
    button_menu.color_click = color_click
    button_menu.pos = pos - scale/2f + float2(scale_outline, scale_outline)
    button_menu.collider.topLeftCorner = pos + float2(scale_outline, scale_outline)
    button_menu.collider.bottomRightCorner = pos + scale/2f - float2(scale_outline, scale_outline)
    push_clone(buttons_menu, button_menu)
def create_back_menu(var pos: float2; scale: float2; color_def: uint)
    var button_menu: Button_menu
    button_menu.pressed = false
    button_menu.color = color_def
    button_menu.pos = pos
    button_menu.collider.topLeftCorner = pos
    button_menu.collider.bottomRightCorner = pos + scale
    push_clone(buttons_menu, button_menu)

def create_back_menu(var pos: float2; scale: float2; color_def: uint; color_outline: uint; scale_outline: float; offset_outline: float2 = float2(0,0))
    create_back_menu(pos+offset_outline, scale, color_outline)
    var button_menu: Button_menu
    var offset = float2(scale_outline, scale_outline)
    button_menu.pressed = false
    button_menu.color = color_def
    button_menu.pos = pos + offset
    button_menu.collider.topLeftCorner = pos + offset
    button_menu.collider.bottomRightCorner = pos + scale - offset
    push_clone(buttons_menu, button_menu)

def create_back_menu(var pos: float2; scale: float2; color_def: uint; text: string; offset_textY: float; image: ImageHandle)
    var button_menu: Button_menu
    button_menu.collider.image := image
    button_menu.text.font_size = 50f//scale.x//3f
    button_menu.text.pos = pos - float2((button_menu.text.font_size*float(length(text)))/4f, scale.y/4f+offset_textY)
    button_menu.tag = text
    button_menu.pressed = false
    button_menu.color = color_def
    button_menu.pos = pos - scale/2f
    button_menu.collider.topLeftCorner = pos 
    button_menu.collider.bottomRightCorner = pos + scale/2f
    push_clone(buttons_menu, button_menu)
def create_label(text: string; font: string; font_size: float; pos: float2; center:bool = true)
    var new_text: Label
    new_text.text = text
    new_text.font = font
    new_text.pos = pos - (center ? float2((font_size*float(length(text)))/4f, 0f) : float2(0f, 0f))
    new_text.font_size = font_size
    push_clone(labels, new_text)

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
    if tag == "Start"
        load_level(0)
    if tag == "Exit"
        print("exit")
        schedule_quit_game()
    if tag == "Restart"
        load_level(current_level)
    if tag == "Settings"
        settings_menu()
        //settings_menu()
    