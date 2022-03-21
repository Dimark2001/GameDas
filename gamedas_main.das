require daslib/media

require physics
require globalVarAndStruct
require levelBuild
require render
require gameInit
require menu


[export]
def initialize
    set_window_title("gome")
    set_resolution(1600, 900)
    set_antialiasing(4)
    set_vsync_enabled(true)
    
    load_level(100)
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
        

    if get_key_down(VK_Z) && !is_menu
        
        create_wall(player.pos, float2(player.height, player.width), 0xffff0077)
        player.pos = player.start_pos
    return
[export]
def draw
    enable_alpha_blend()
    render_background()
    render_player(player)
    render_level(walls, buttons, buttons_menu)
    disable_alpha_blend()
    
    return
