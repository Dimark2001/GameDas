require daslib/media

require physics
require globalVarAndStruct
require levelBuild
require render
require gameInit
require menu
require player

var
    fps_counter:float
[export]
def initialize
    set_window_title("gome")
    set_resolution(1600, 900)
    set_antialiasing(1)
    set_vsync_enabled(true)
    main_menu()
    //load_level(100)
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
        
    if get_key_down(VK_Z)
        dead_player(player)
    fps_counter = 1.0f / dt
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
    text_out(10f, 10f, "{fps_counter}", 0x0)
    return
