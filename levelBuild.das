
require daslib/media

require globalVarAndStruct
require render
require gameInit

def read_level() : array<Level>
    var levels: array<Level>
    var l0: Level
    var l1: Level



    var mL0 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    var mL1 = [[string "w";"-";"p";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL2 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL3 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"c";"-";"-";"-";"-";"-";"-";"w"]]
    var mL4 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var mL5 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"w";"-";"-";"-";"-";"-";"-";"w"]]
    var mL6 = [[string "w";"-";"-";"-";"w";"c";"-";"w";"w";"-";"-";"-";"-";"-";"-";"w"]]
    var mL7 = [[string "w";"-";"-";"w";"w";"c";"w";"w";"w";"-";"-";"-";"-";"-";"-";"w"]]
    var mL8 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]

    var m1L0 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    var m1L1 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L2 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L3 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L4 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L5 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L6 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w"]]
    var m1L7 = [[string "w";"p";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"c";"w"]]
    var m1L8 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    resize(l0.mesh_level, 9)
    push(l0.mesh_level[0], mL0)
    push(l0.mesh_level[1], mL1)
    push(l0.mesh_level[2], mL2)
    push(l0.mesh_level[3], mL3)
    push(l0.mesh_level[4], mL4)
    push(l0.mesh_level[5], mL5)
    push(l0.mesh_level[6], mL6)
    push(l0.mesh_level[7], mL7)
    push(l0.mesh_level[8], mL8)

    resize(l1.mesh_level, 9)
    push(l1.mesh_level[0], m1L0)
    push(l1.mesh_level[1], m1L1)
    push(l1.mesh_level[2], m1L2)
    push(l1.mesh_level[3], m1L3)
    push(l1.mesh_level[4], m1L4)
    push(l1.mesh_level[5], m1L5)
    push(l1.mesh_level[6], m1L6)
    push(l1.mesh_level[7], m1L7)
    push(l1.mesh_level[8], m1L8)
    push_clone(levels, l0)
    push_clone(levels, l1)
    //print("{levels[0].mesh_level}<---level\n")
    return <- levels

def load_level(var index: int)   
    loading_level = true
    //if index > max_levels
    //    index = 0
    max_levels = length(read_level())
    print("{index}<X\n")
    
    if index < max_levels
        current_level = index
        print("{index}<-\n")
    else
        index = 0
        current_level = index
    clear_level()
    build_level(read_level()[index])
    loading_level = false

def build_level(level: Level)
    var mesh := level.mesh_level
    var pos_y:float = 0f
    var pos_x:float = 0f
    for x in mesh
        for y in x
            create_tilemap(level, y, float2(pos_y, pos_x))
            pos_y++
            
        pos_y=0f
        pos_x++

def create_tilemap(level: Level; tile: string; tile_pos: float2)
    //var count_wall:int
    var mesh := level.mesh_level
    var height_level = length(mesh)
    var width_level = length(mesh[0])
    var border_level: float2 = float2(100f,100f)
    var scale_tile = float2(HEIGHT_SCREEN/height_level, HEIGHT_SCREEN/height_level)
    var global_tile_pos = tile_pos*(scale_tile)
    //print("{global_tile_pos} - pos\n")
    //print("{scale_tile} - scale\n")
    if tile == WALL_SYMBOL
        create_wall(global_tile_pos, scale_tile, BRICK_COLOR)
    elif tile == PLAYER_SYMBOL
        restart_player(player, global_tile_pos, scale_tile.x, scale_tile.y)
    elif tile == BUTTON_SYMBOL
        create_button(global_tile_pos, scale_tile, 0xFF00FF, "jump")
    elif tile == CLOSE_SYMBOL
        create_button(global_tile_pos, scale_tile, 0xF09011, "nextLevel")
    
def create_wall(var pos: float2; scale: float2; color: uint; trigger: bool = false)
    var new_wall: Wall
    new_wall.color = color
    new_wall.pos = pos
    new_wall.collider.topLeftCorner = pos
    new_wall.collider.bottomRightCorner = pos + scale
    
    push(walls, new_wall)
    
def create_button(var pos: float2; scale: float2; color: uint; tag: string)
    var new_button: Button
    new_button.tag = tag
    new_button.color = color
    new_button.pos = pos
    new_button.collider.topLeftCorner = pos
    new_button.collider.bottomRightCorner = pos + scale
    push(buttons, new_button)
def clear_level()
    clear(walls)
    clear(buttons)
    clear(buttons_menu)
    is_menu = false
