
require daslib/media

require globalVarAndStruct
require render
require gameInit
require jsonParser

def read_level() : array<Level>
    
    var levels: array<Level>
    levels <- read("Resources/levels.json")
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
    var pos_y:float = 0f
    var pos_x:float = 0f
    for x in mesh
        for y in x
            print(">{y}<")
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
    elif tile == WATER_SYMBOL
        create_trigger(global_tile_pos, scale_tile, make_color(0f,1f,0f,0.3f), "water", TRIGGER_IMAGE)
    elif tile == PLAYER_SYMBOL
        create_trigger(global_tile_pos, scale_tile*float2(1f,1f), TRIGGER_COLOR, "spawn", SPAWN_STATION_IMAGE)
        //create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "spawn", SPAWN_STATION_IMAGE)
        restart_player(player, global_tile_pos, scale_tile.x, scale_tile.y, create_array_type_player(type_name, type_count))

        create_spawn_station(global_tile_pos, scale_tile*float2(1f,1f), TRIGGER_COLOR, create_array_type_player(type_name, type_count))
    elif tile == TRIGGER_SYMBOL
        create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "jump", TRIGGER_IMAGE)
    elif tile == PORTAL_IN_SYMBOL
        create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "tp", TRIGGER_IMAGE)
    elif tile == PORTAL_OUT_SYMBOL
        tp_pos = global_tile_pos
        //create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "tp", TRIGGER_IMAGE)
    elif tile == CLOSE_SYMBOL
        create_trigger(global_tile_pos, scale_tile, TRIGGER_COLOR, "nextLevel", EXIT_LEVEL)
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
            types[i].image := LAVA_PLAYER
        if name[i] == "metal"
            types[i].image := METAL_PLAYER
        if name[i] == "wood"
            types[i].image := WOOD_PLAYER
        if name[i] == "portal"
            types[i].image := PORTAL_PLAYER
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
