
require daslib/media

require globalVarAndStruct
require render
require gameInit

def read_level() : array<Level>
    var levels: array<Level>
    var l0: Level
    var l1: Level
    var l2: Level

    var type_name1 = [[string "metal"]]
    var type_name2 = [[string "metal"; "wood"; ""; ""]]
    var type_name3 = [[string "metal"; "stone"]]

    var type_count1 = [[int 10]]
    var type_count2 = [[int 3; 2; 1; 0]]
    var type_count3 = [[int 3; 2]]

    l0.level_name = "name_level1"
    l1.level_name = "name_level2"
    l2.level_name = "name_level3"
    
    l0.biom = "grass"
    l1.biom = "lava"
    l2.biom = "stone"
    push(l0.type_name, type_name1)
    push(l1.type_name, type_name2)
    push(l2.type_name, type_name3)

    push(l0.type_count, type_count1)
    push(l1.type_count, type_count2)
    push(l2.type_count, type_count3)

    

    var mL0 =  [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    var mL1 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL2 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL3 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"v";"v";"v";"v";"-";"-";"v";"-";"-";"-";"w"]]
    var mL4 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"v";"w";"-";"-";"w";"-";"-";"w";"-";"-";"-";"w"]]
    var mL5 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"v";"w";"-";"-";"-";"w";"-";"-";"w";"-";"-";"-";"w"]]
    var mL6 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w";"c";"-";"w";"-";"-";"-";"w"]]
    var mL7 =  [[string "w";"-";"-";"-";"-";"-";"-";"v";"v";"-";"-";"-";"-";"w";"v";"v";"w";"-";"-";"-";"w"]]
    var mL8 =  [[string "w";"-";"-";"-";"-";"-";"v";"-";"-";"v";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL9 =  [[string "w";"-";"-";"-";"c";"v";"v";"-";"-";"-";"v";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL10 = [[string "w";"p";"-";"-";"w";"w";"w";"v";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL11 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]

    var m1L0 =  [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    var m1L1 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L2 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L3 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L4 =  [[string "w";"p";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L5 =  [[string "w";"v";"v";"v";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L6 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L7 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L8 =  [[string "w";"-";"-";"v";"l";"l";"l";"l";"v";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L9 =  [[string "w";"-";"-";"w";"l";"l";"l";"l";"w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L10 = [[string "w";"-";"-";"w";"l";"l";"l";"l";"w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"c";"w"]]
    var m1L11 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]

    var m2L0 =  [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    var m2L1 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L2 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L3 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L4 =  [[string "w";"p";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"c";"-";"-";"-";"-";"w"]]
    var m2L5 =  [[string "w";"v";"v";"v";"-";"-";"-";"-";"-";"-";"-";"-";"-";"v";"v";"v";"-";"-";"-";"-";"w"]]
    var m2L6 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"o";"v";"v";"v";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L7 =  [[string "w";"-";"-";"-";"-";"-";"-";"v";"v";"v";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L8 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L9 =  [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L10 = [[string "w";"i";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m2L11 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    resize(l0.mesh_level, 12)
    push(l0.mesh_level[0], mL0)
    push(l0.mesh_level[1], mL1)
    push(l0.mesh_level[2], mL2)
    push(l0.mesh_level[3], mL3)
    push(l0.mesh_level[4], mL4)
    push(l0.mesh_level[5], mL5)
    push(l0.mesh_level[6], mL6)
    push(l0.mesh_level[7], mL7)
    push(l0.mesh_level[8], mL8)
    push(l0.mesh_level[9], mL9)
    push(l0.mesh_level[10], mL10)
    push(l0.mesh_level[11], mL11)

    resize(l1.mesh_level, 12)
    push(l1.mesh_level[0], m1L0)
    push(l1.mesh_level[1], m1L1)
    push(l1.mesh_level[2], m1L2)
    push(l1.mesh_level[3], m1L3)
    push(l1.mesh_level[4], m1L4)
    push(l1.mesh_level[5], m1L5)
    push(l1.mesh_level[6], m1L6)
    push(l1.mesh_level[7], m1L7)
    push(l1.mesh_level[8], m1L8)
    push(l1.mesh_level[9], m1L9)
    push(l1.mesh_level[10], m1L10)
    push(l1.mesh_level[11], m1L11)

    resize(l2.mesh_level, 12)
    push(l2.mesh_level[0], m2L0)
    push(l2.mesh_level[1], m2L1)
    push(l2.mesh_level[2], m2L2)
    push(l2.mesh_level[3], m2L3)
    push(l2.mesh_level[4], m2L4)
    push(l2.mesh_level[5], m2L5)
    push(l2.mesh_level[6], m2L6)
    push(l2.mesh_level[7], m2L7)
    push(l2.mesh_level[8], m2L8)
    push(l2.mesh_level[9], m2L9)
    push(l2.mesh_level[10], m2L10)
    push(l2.mesh_level[11], m2L11)
    push_clone(levels, l0)
    push_clone(levels, l1)
    push_clone(levels, l2)
    return <- levels

def load_level(var index: int)  
    loading_level = true
    max_levels = length(read_level())
    spawn_station.open = false
    update_bar = true
    if index < max_levels
        current_level = index
    else
        index = 0
        current_level = index
    clear_level()
    build_level(read_level()[index])
    name_current_level = read_level()[index].level_name
    loading_level = false

def build_level(level: Level)
    var mesh := level.mesh_level
    // var res = float(length(mesh[0])) / float(length(mesh))
    // set_resolution(int(res*900f), 900)
    var pos_y:float = 0f
    var pos_x:float = 0f
    for x in mesh
        for y in x
            create_tilemap(level, y, float2(pos_y, pos_x))
            pos_y++
            
        pos_y=0f
        pos_x++

def create_tilemap(level: Level; tile: string; tile_pos: float2)
    aplay_biom_level(level.biom)
    var type_name := level.type_name
    var type_count := level.type_count
    var mesh := level.mesh_level
    var height_level = length(mesh)
    var width_level = length(mesh[0])
    var border_level: float2 = float2(100f,100f)
    var scale_tile = float2(HEIGHT_SCREEN/height_level, HEIGHT_SCREEN/height_level)
    var global_tile_pos = tile_pos*(scale_tile)
    if tile == WALL_SYMBOL
        create_wall(global_tile_pos, scale_tile, BRICK_COLOR, WALL_IMAGE)
    elif tile == WALL_SYMBOL8
        create_wall(global_tile_pos, scale_tile, BRICK_COLOR, WALL_IMAGE8)

    elif tile == LAVA_SYMBOL
        create_trigger(global_tile_pos, scale_tile, make_color(1f,0f,0f,0.3f), "lava", TRIGGER_IMAGE)
    elif tile == PLAYER_SYMBOL
        create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "spawn", TRIGGER_IMAGE)
        //create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "spawn", SPAWN_STATION_IMAGE)
        restart_player(player, global_tile_pos, scale_tile.x, scale_tile.y, create_array_type_player(type_name, type_count))
        create_spawn_station(global_tile_pos, scale_tile, TRIGGER_COLOR, create_array_type_player(type_name, type_count))
    elif tile == TRIGGER_SYMBOL
        create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "jump", TRIGGER_IMAGE)
    elif tile == PORTAL_IN_SYMBOL
        create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "tp", TRIGGER_IMAGE)
    elif tile == PORTAL_OUT_SYMBOL
        tp_pos = global_tile_pos
        //create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "tp", TRIGGER_IMAGE)
    elif tile == CLOSE_SYMBOL
        create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "nextLevel", SPAWN_STATION_IMAGE)
def aplay_biom_level(b:string)
    if b == "grass"
        WALL_IMAGE = GRASS_WALL_IMAGE
        WALL_IMAGE8 = GRASS_WALL_IMAGE8
    if b == "stone"
        WALL_IMAGE = STONE_WALL_IMAGE
        WALL_IMAGE8 = STONE_WALL_IMAGE8
    if b == "lava"
        WALL_IMAGE = LAVA_WALL_IMAGE
        WALL_IMAGE8 = LAVA_WALL_IMAGE8
def create_wall(var pos: float2; scale: float2; color: uint; image: ImageHandle)
    var new_wall: Wall
    new_wall.color = color
    new_wall.collider.image := image

    new_wall.pos = pos
    new_wall.collider.topLeftCorner = pos
    new_wall.collider.bottomRightCorner = pos + scale
    
    push_clone(walls, new_wall)
    
def create_trigger(var pos: float2; scale: float2; color: uint; tag: string; image: ImageHandle)
    var new_trigger: Trigger
    new_trigger.tag = tag
    new_trigger.color = color
    new_trigger.collider.image := image
    new_trigger.pos = pos
    new_trigger.collider.topLeftCorner = pos
    new_trigger.collider.bottomRightCorner = pos + scale
    push_clone(triggers, new_trigger)


def create_array_type_player(var name: array<string>; var count: array<int>)// : array<Type_Player_Bar>
    //clear()
    var count_type = length(name) <= length(count) ? length(name) : length(count)
    var types: array<Type_Player_Bar> 
    resize(types, count_type)
    for i in range(0, count_type)
        //delete types[i].image
        types[i].name = name[i]
        types[i].count = count[i]
        if name[i] == "stone"
            types[i].image := STONE_PLAYER
        if name[i] == "metal"
            types[i].image := METAL_PLAYER
        if name[i] == "wood"
            types[i].image := WOOD_PLAYER
    return <- types

def create_spawn_station(var pos: float2; scale: float2; color: uint; type_player: array<Type_Player_Bar>)
    //create_trigger(pos, scale, color, "spawn", SPAWN_STATION_IMAGE)
    delete spawn_station.type_player
    
    spawn_station.type_player := type_player

def clear_level()
    clear(walls)
    clear(triggers)
    clear(buttons_menu)
    is_menu = false
