require daslib/media

require globalVarAndStruct
require levelBuild
require render
require gameInit

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
    var pl_col = player.collider
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
    print("{a}\n")
    return all_col;



def check_buttons(var b: array<Button>; var player: Player)
    if !loading_level
        for i in range(0, length(b))
            if i < length(b) 
                if is_collision(b[i].collider, player)
                    b[i].color = 0xff
                    b[i].is_active = true
                    update_button(b[i], player)
                else
                    b[i].is_active = false
        
    
def update_button(var b: Button; var player: Player)
    if b.is_active
        if b.tag == "jump"
            //b.is_active = false
            print("b jump")
        if b.tag == "tp"
            //b.is_active = false
            player.pos.x+=800f
        if b.tag == "nextLevel"
            //b.is_active = false
            ++current_level
            load_level(current_level)
    

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

    let jump = get_key(VK_SPACE)
    var p_col = check_collisions(walls, player)
    //print("{p_col.go}\n")
    if !p_col.d 
        apply_gravity(player, dt)
        if(p_col.u || (p_col.r && p_col.l))
            player_levelingY(player, p_col.uo)
    if p_col.d
        if(player.velocity.y >= 0f)
            player_levelingY(player, p_col.dof)
        
        if ((jump && !jump_pressed && p_col.dof < 2f))
            jump_player(player)
        jump_pressed = jump
    
    update_input(player, dt, p_col)
    check_buttons(buttons, player)
    //print("down   up     right  left  \n")
    //print("{p_col.d}, {p_col.u}, {p_col.r}, {p_col.l}, {player.velocity.y}\n")
def jump_player(var player: Player)
    player.velocity.y = 0f
    player.velocity.y += clamp(player.velocity.y - player.force_jump, -player.force_jump, -250.0)

def apply_gravity(var player: Player; dt: float)
    player.velocity.y += gravity*dt*10f

def update_input(var player: Player; dt: float; p_col: tuple<d:bool; u:bool; r:bool; l:bool; dof:float; uo:float; ro:float; lo:float>)
    if (get_key(VK_A) && !p_col.l)
        player.velocity.x = -player.speed*dt*50f
    elif (get_key(VK_D) && !p_col.r)
        player.velocity.x = player.speed*dt*50f
    else
        player.velocity.x = 0f
       
