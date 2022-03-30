require daslib/media

require globalVarAndStruct
require levelBuild
require render
require gameInit
require menu
require player

def is_collision(var other: Rect_collider; player: Player)
    if ((player.collider.bottomRightCorner.y > other.topLeftCorner.y)
    && (player.collider.topLeftCorner.y < other.bottomRightCorner.y)
    && (player.collider.bottomRightCorner.x > other.topLeftCorner.x)
    && (player.collider.topLeftCorner.x < other.bottomRightCorner.x))
        return true;
    else
        return false;
def dir_collision(other: Rect_collider; player: Player)
    
    var down,up,right,left: bool
    var pl_col := player.collider
    var down_offset, up_offset, right_offset, left_offset: float
    //down
    if ((pl_col.bottomRightCorner.y >= other.topLeftCorner.y-offsetDU)
    && (pl_col.topLeftCorner.y < other.topLeftCorner.y)
    && (pl_col.topLeftCorner.x < other.bottomRightCorner.x)
    && (pl_col.bottomRightCorner.x > other.topLeftCorner.x))
        down = true
        down_offset = pl_col.bottomRightCorner.y - other.topLeftCorner.y-offsetDU
    //up
    if ((pl_col.topLeftCorner.y <= other.bottomRightCorner.y)
    && (pl_col.bottomRightCorner.y > other.bottomRightCorner.y+offsetDU)
    && (pl_col.bottomRightCorner.x > other.topLeftCorner.x)
    && (pl_col.topLeftCorner.x < other.bottomRightCorner.x))
        up = true
        up_offset = pl_col.topLeftCorner.y - other.bottomRightCorner.y 
    //right
    if ((pl_col.bottomRightCorner.x >= other.topLeftCorner.x)
    && (pl_col.topLeftCorner.x < other.topLeftCorner.x)
    && (pl_col.bottomRightCorner.y > other.topLeftCorner.y+offsetRL)
    && (pl_col.topLeftCorner.y < other.bottomRightCorner.y-offsetRL))
        right = true
        right_offset = pl_col.bottomRightCorner.x - other.topLeftCorner.x
    //left
    if ((pl_col.topLeftCorner.x <= other.bottomRightCorner.x)
    && (pl_col.bottomRightCorner.x > other.bottomRightCorner.x)
    && (pl_col.bottomRightCorner.y > other.topLeftCorner.y+offsetRL)
    && (pl_col.topLeftCorner.y < other.bottomRightCorner.y-offsetRL))
        left = true
        left_offset = pl_col.topLeftCorner.x - other.bottomRightCorner.x
    var col : tuple<d:bool; u:bool; r:bool; l:bool; dof:float; uo:float; ro:float; lo:float>
    col.d = down
    col.u = up
    col.r = right
    col.l = left
    col.dof = down_offset
    col.uo = up_offset
    col.ro = right_offset
    col.lo = left_offset
    
    return col;

def check_collisions(var walls: array<Wall>; player: Player)
    var p_col, all_col : tuple<d:bool; u:bool; r:bool; l:bool; dof:float; uo:float; ro:float; lo:float>
    var testD,testU: bool = false
    var a: int = 0
    for w in walls
        if is_collision(w.collider, player)
            w.collider.collision_for_player = true
            a++
            p_col = dir_collision(w.collider, player)
            
            if p_col.d  
                testD = true
            if p_col.u 
                testU = true

            if p_col.d && p_col.dof < 20f 
                all_col.d = true
                all_col.dof = p_col.dof
            if p_col.u && p_col.uo > -20f 
                all_col.u = true
                all_col.uo = p_col.uo
                //print("{p_col.uo}\n")

            if p_col.r && !all_col.r
                p_col.d = false
                p_col.u = false
                all_col.r = true
                all_col.ro = p_col.ro
            if p_col.l && !all_col.l
                all_col.l = true
                p_col.d = false
                p_col.u = false
                all_col.lo = p_col.lo
            if testD && testU //all_col.d && all_col.u || p_col.d && p_col.u
                all_col.d = false
                all_col.u = false
                testD = false
                testU = false
            if all_col.r && all_col.l
                all_col.d = true

            //print("{all_col}\n")
            //print("{p_col.r} {p_col.l} {length(walls)} {p_col.d}\n")
        else
            w.collider.collision_for_player = false
    //print("{a}\n")
    return all_col;



def check_triggers(var t: array<Trigger>; var player: Player)
    if !loading_level
        for i in range(0, length(t))
            if i < length(t) 
                if is_collision(t[i].collider, player)
                    //t[i].color = 0xff
                    t[i].is_active = true
                    
                    update_trigger(t[i], player, dir_collision(t[i].collider, player).dof)
                else
                    t[i].is_active = false
                    
        
    
def update_trigger(var t: Trigger; var player: Player; dof: float)
    if t.is_active
        if t.tag == "jump"
            //b.is_active = false
            print("b jump")
        if t.tag == "portal" && current_type_player == "portal"
            //b.is_active = false
            player.pos = tp_pos
        if t.tag == "nextLevel"
            //b.is_active = false
            ++current_level
            load_level(current_level)
        if t.tag == "spawn"
            //b.is_active = false
            //print("spawn")
            select_player_menu()
            //is_bar = true
        if t.tag == "water"
            if current_type_player == "wood"
                swimming_player(player) <| dof
            if current_type_player == "portal"
                swimming_player(player) <| dof
            if current_type_player == "metal" && player.velocity.y == 0f
                dead_player(player)
        if t.tag == "lava"
            if current_type_player != "metal" && current_type_player != "stone" && player.velocity.y == 0f
                dead_player(player)
            if current_type_player == "metal"
                swimming_player(player) <| dof
            elif current_type_player == "stone"
                if player.velocity.y > 0F
                    player.velocity.y /= 1.1f
                else
                    player.velocity.y *= 1.005f
    else
        if t.tag == "spawn"
            select_player_menu()

def swimming_player(var player: Player; offset: float)
    print("^")
    if offset <= player.height && player.velocity.y >= -120f
        player.velocity.y -= offset
def player_levelingY(var player: Player; offset: float)
    player.pos.y -=(offset-1f)
    player.velocity.y = 0f

def player_levelingX(var player: Player; offset: float)
    player.pos.x -= offset-20f
    player.velocity.x = 0f

def update_player(var player: Player; dt: float)
    player.collider.topLeftCorner = player.pos
    player.collider.bottomRightCorner = player.pos+float2(player.width, player.height)
    player.pos.x += player.velocity.x*dt
    player.pos.y += player.velocity.y*dt

    if player.velocity.x > 0f
        player.flip = false
    if player.velocity.x < 0f
        player.flip = true
    if def_flip != player.flip
        def_flip = player.flip
        new_flip = true
    let jump = get_key(VK_SPACE)//int(get_mouse_scroll_delta()) != 0 ? true : false 
    var p_col = check_collisions(walls, player)
    //print("{p_col.go}\n")
    if spawn_station.open
        if !p_col.d 
            apply_gravity(player, dt)
            if(p_col.u || (p_col.r && p_col.l))
                player_levelingY(player, p_col.uo)
        if p_col.d
            if(player.velocity.y >= 0f)
                player_levelingY(player, p_col.dof)
            
            if ((jump && !jump_pressed && p_col.dof < 2f && spawn_station.open))
                jump_player(player)
            jump_pressed = jump
        update_input(player, dt, p_col)
    else
        player.velocity = float2(0f,0f)
    check_triggers(triggers, player)
    //print("down   up     right  left  \n")
    //print("{p_col.d}, {p_col.u}, {p_col.r}, {p_col.l}, {player.velocity.y}\n")
def jump_player(var player: Player)
    player.velocity.y = 0f
    player.velocity.y += clamp(player.velocity.y - player.force_jump, -player.force_jump, -250.0)

def apply_gravity(var player: Player; dt: float)
    player.velocity.y += gravity*dt*10f

def update_input(var player: Player; dt: float; p_col: tuple<d:bool; u:bool; r:bool; l:bool; dof:float; uo:float; ro:float; lo:float>)
    if get_key(VK_Z) && p_col.d
        dead_player(player)
    
    if (get_key(VK_A) && !p_col.l)
        player.velocity.x = -player.speed*dt*50f
    elif (get_key(VK_D) && !p_col.r)
        
        player.velocity.x = player.speed*dt*50f//player.speed*dt
    else
        player.velocity.x = 0f
       
