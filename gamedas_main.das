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
    set_antialiasing(4)
    set_vsync_enabled(true)
    set_resolution(1600, 900)
    load_level(110)
    
    
    //restart_player(player)
    //for i in range(0, 50)
    //    create_wall(float2(100+50*i, 500-25*i), float2(50, 25), 0x00000000)
    //create_wall(float2(250, 200), float2(400, 300), BRICK_COLOR, true)
    
    //create_wall(float2(50, 500), float2(1000, 220), 0xf00ff0ff)


    //create_button(float2(300, 150), float2(50, 50), 0xff00ff0, "tp")

    return

// this function is called to update game data,
// dt - time elapsed since the previous update (in seconds)
[export]
def act(dt: float)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
        
    update_player(player, dt)
    check_buttons_menu(buttons_menu)
    if get_key_down(VK_R)
        load_level(++current_level)
    if get_key_down(VK_X)
        load_menu()
    if get_key_down(VK_Z)
        
        create_wall(player.pos, float2(player.height, player.width), 0x00ff00)
        player.pos = player.start_pos
    return
// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    //render_background() 
    render_player(player)
    render_level(walls, buttons, buttons_menu)
    //fill_rect(0.0, 700.0, 1280.0, 20.0, 0xffffff)
    
    return
