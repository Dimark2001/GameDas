require daslib/media


require globalVarAndStruct
def restart_player(var player: Player; pos: float2; height:float; width:float; var type_player_bar: array<Type_Player_Bar>)
    
    player.pos = pos//float2(80,100)
    player.start_pos = pos//float2(80,100)
    player.velocity = float2(0,0)
    player.speed = 400f
    player.force_jump = 450f//*gravity
    player.height = height // выс коллайдера и спрайта
    player.width = width
    offsetRL = player.height/10f
    offsetDU = player.width/100f
    spawn_station.open = false
    update_type_player(player, type_player_bar)

def update_type_player(var player: Player; var type_player_bar: array<Type_Player_Bar>)
    clear(player.type_player)
    var new_types_player: array<Type_Player>
    print("{type_player_bar[0].name} <----\n")
    var len = length(type_player_bar)
    print("{length(type_player_bar)}-------------> length\n")
    for i in range(0, len)
        print("{i}")
        var new_type: Type_Player
        new_type.name = type_player_bar[i].name
        new_type.active = false
        push_clone(image_player_in_bar, type_player_bar[i].image )
        push_clone(player.type_player, new_type)
def restart_player(var player: Player)
    if  player.flip
        body |> flip_image_x()
        mask |> flip_image_x()
        heat |> flip_image_x()
        legs |> flip_image_x()
        legs |> flip_image_x()
    def_flip = false
    player.flip = false
    player.pos = player.start_pos
    player.velocity = float2(0,0)
    spawn_station.open = false


def select_player(var index: int; active:bool = false)
    
    unselect_player()
    
    select_index = index
    var t = player.type_player[index]
    
    t.active = true
    print("{t.name}=select\n")
    if active && spawn_station.type_player[index].count > 0
        spawn_station.open = true
        t.active = true
    else
        spawn_station.open = false
    if t.active
        current_type_player = t.name
        if t.name == "metal"
            body := BODY_METAL
            mask := MASK_METAL
            heat := HEAT_METAL
            legs := LEGS_METAL
            dead := METAL_PLAYER
        if t.name == "stone"
            body := BODY_LAVA
            mask := MASK_LAVA
            heat := HEAT_LAVA
            legs := LEGS_LAVA
            dead := LAVA_PLAYER
        if t.name == "wood"
            body := BODY_WOOD
            mask := MASK_WOOD
            heat := HEAT_WOOD
            legs := LEGS_WOOD
            dead := WOOD_PLAYER
        if t.name == "portal"
            body := BODY_PORTAL
            mask := MASK_PORTAL
            heat := HEAT_PORTAL
            legs := LEGS_PORTAL
            dead := PORTAL_PLAYER

def unselect_player()
    for i in range(0, length(player.type_player)) 
        player.type_player[i].active = false
