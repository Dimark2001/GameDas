require daslib/media


require globalVarAndStruct
def restart_player(var player: Player; pos: float2; height:float; width:float; var type_player_bar: array<Type_Player_Bar>)
    
    //is_restart = true
    //clear(player.type_player)
    player.pos = pos//float2(80,100)
    player.start_pos = pos//float2(80,100)
    player.velocity = float2(0,0)
    player.speed = 5400f
    player.force_jump = 450f//*gravity
    player.height = height//80f // выс коллайдера и спрайта
    player.width = width //80f
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
    
    player.pos = player.start_pos
    player.velocity = float2(0,0)
    spawn_station.open = false
    //update_type_player(player, type_player_bar)


def select_player(var index: int; active:bool = false)
    //if length(player.type_player) > 0
    unselect_player()
    select_index = index
    var t = player.type_player[index]
    
    t.active = true
    print("{t.name}=select\n")
    if active && spawn_station.type_player[index].count > 0
        //spawn_station.type_player[index].count--
        spawn_station.open = true
        t.active = true
    else
        spawn_station.open = false
    if t.active
        if t.name == "metal"
            body := BODY_METAL
            mask := MASK_METAL
            heat := HEAT_METAL
            legs := LEGS_METAL
        if t.name == "stone"
            body := BODY_STONE
            mask := MASK_STONE
            heat := HEAT_STONE
            legs := LEGS_STONE
        if t.name == "wood"
            body := BODY_WOOD
            mask := MASK_WOOD
            heat := HEAT_WOOD
            legs := LEGS_WOOD

def unselect_player()
    for i in range(0, length(player.type_player)) 
        player.type_player[i].active = false

