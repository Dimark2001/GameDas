require daslib/media

require physics
require globalVarAndStruct
require levelBuild
require render
require gameInit
require menu
require player

var
    fps_counter:int
[export]
def initialize
    set_window_title("FakeLife")
    set_resolution(1575, 900)
    HEIGHT_SCREEN = get_screen_height()
    WIDTH_SCREEN = get_screen_width()
    print("{HEIGHT_SCREEN}")
    print("{WIDTH_SCREEN}")
    //set_antialiasing(4)
    set_vsync_enabled(false)
    
    //load_level(100)
    main_menu()
    return
[export]
def act(dt: float)
    if get_key_down(VK_ESCAPE)
        if !is_menu
            main_menu()
        else 
            close_menu()
    if !is_menu
        update_player(player, dt)
    check_buttons_menu(buttons_menu)
    if get_key_down(VK_R)
        load_level(current_level)
    
    load_menu()
        
    fps_counter = roundi(1.0f / dt)
    if fps_counter > 90
        set_vsync_enabled(true)
    if fps_counter < 45
        set_vsync_enabled(false)
    return
[export]
def draw
    
    //text_out(10f, 10f, "1000f", 0xff00)
    
    enable_alpha_blend()

    render_background()
    render_player(player)
    render_level(walls, triggers, buttons_menu)

    disable_alpha_blend()
    set_font_name("mono")
    set_font_size(25f)
    text_out(10f, 10f, "{fps_counter}", 0x00ff00)
    return
