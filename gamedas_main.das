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
    if get_key(VK_ESCAPE)
        schedule_quit_game()
        
    update_player(player, dt)
    check_buttons_menu(buttons_menu)
    if get_key_down(VK_R)
        load_level(current_level)
    if get_key_down(VK_X)
        load_menu()
        

    if get_key_down(VK_Z)
        
        create_wall(player.pos, float2(player.height, player.width), 0x00ff00)
        player.pos = player.start_pos
    return
[export]
def draw
    render_background()
    render_player(player)
    render_level(walls, buttons, buttons_menu)
    
    return
