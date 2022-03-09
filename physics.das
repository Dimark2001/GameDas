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
    if ((pl_col.bottomRightCorner.y >= other.topLeftCorner.y+offsetDU)
    && (pl_col.topLeftCorner.y < other.topLeftCorner.y)
    && (pl_col.topLeftCorner.x < other.bottomRightCorner.x)
    && (pl_col.bottomRightCorner.x > other.topLeftCorner.x))
        down = true
        down_offset = pl_col.bottomRightCorner.y - other.topLeftCorner.y
    //up
    if ((pl_col.topLeftCorner.y <= other.bottomRightCorner.y)
    && (pl_col.bottomRightCorner.y > other.bottomRightCorner.y)
    && (pl_col.bottomRightCorner.x > other.topLeftCorner.x)
    && (pl_col.topLeftCorner.x < other.bottomRightCorner.x))
        up = true
        up_offset = pl_col.topLeftCorner.y - other.bottomRightCorner.y 
    //right
    if ((pl_col.bottomRightCorner.x >= other.topLeftCorner.x)
    && (pl_col.topLeftCorner.x < other.topLeftCorner.x)
    && (pl_col.bottomRightCorner.y > other.topLeftCorner.y+offsetRL)
    && (pl_col.topLeftCorner.y < other.bottomRightCorner.y))
        right = true
        right_offset = pl_col.bottomRightCorner.x - other.topLeftCorner.x
    //left
    if ((pl_col.topLeftCorner.x <= other.bottomRightCorner.x)
    && (pl_col.bottomRightCorner.x > other.bottomRightCorner.x)
    && (pl_col.bottomRightCorner.y > other.topLeftCorner.y+offsetRL)
    && (pl_col.topLeftCorner.y < other.bottomRightCorner.y))
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

    for w in walls
        if is_collision(w.collider, player)
            w.collider.collision_for_player = true
            p_col = dir_collision(w.collider, player)
            if p_col.d
                all_col.d = true
                all_col.dof = p_col.dof
            if p_col.u
                all_col.u = true
                all_col.uo = p_col.uo
            if p_col.r
                all_col.r = true
                all_col.ro = p_col.ro
            if p_col.l
                all_col.l = true
                all_col.lo = p_col.lo
        else
            w.collider.collision_for_player = false
    return all_col;



def check_button(var buttons: array<Button>; var player: Player)
    for b in buttons
        if is_collision(b.collider, player)
            b.is_active = true
            b.pos.y += 10f//b.collider.bottomRightCorner.y
            b.color = 0xff
            update_button(b, player)
        else
            b.is_active = false
            //print("{b.is_active}\n")
            //b.pos.y = b.collider.bottomRightCorner.y

def update_button(var b: Button;var player: Player)
    if b.tag == "jump"
        jump_player(player) 
    if b.tag == "tp"
        player.pos.x+=800f

def player_levelingY(var player: Player; offset: float)
    player.pos.y -=(offset-1f)
    player.velocity.y = 0f

def player_levelingX(var player: Player; offset: float)
    player.pos.x -= offset-20f
    player.velocity.x = 0f

def update_player(var player: Player; dt: float)
    player.collider.topLeftCorner = player.pos
    player.collider.bottomRightCorner = player.pos+float2(player.w_col, player.h_col)
    player.pos.x += player.velocity.x*dt
    player.pos.y += player.velocity.y*dt

    let jump = get_key(VK_SPACE)
    var p_col = check_collisions(walls, player)
    //print("{p_col.go}\n")
    if !p_col.d  
        apply_gravity(player, dt)
        if(p_col.u)
            player_levelingY(player, p_col.uo-10f)
    else 
        if(player.velocity.y >= 0f)
            player_levelingY(player, p_col.dof)
        if ((jump && !jump_pressed && p_col.d))
            jump_player(player)
        jump_pressed = jump
    
    update_input(player, dt, p_col)
    //print("down   up     right  left  \n")
    //print("{p_col.d}, {p_col.u}, {p_col.r}, {p_col.l}\n")
def jump_player(var player: Player)
    player.velocity.y += clamp(player.velocity.y - player.force_jump, -1000.0, -250.0)

def apply_gravity(var player: Player; dt: float)
    player.velocity.y += gravity*dt*10f

def update_input(var player: Player; dt: float; p_col: tuple<d:bool; u:bool; r:bool; l:bool; dof:float; uo:float; ro:float; lo:float>)
    if (get_key(VK_A) && !p_col.l)
        player.velocity.x = -player.speed*dt*50f
    elif (get_key(VK_D) && !p_col.r)
        player.velocity.x = player.speed*dt*50f
    else
        player.velocity.x = 0f
       
