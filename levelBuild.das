
require daslib/media

require globalVarAndStruct
require render

def read_level() : array<Level>
    var levels: array<Level>
    var l0: Level



    var mL0 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"-"]]
    var mL1 = [[string "w";"-";"-";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"-";"w"]]
    var mL2 = [[string "w";"-";"-";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"-";"w";"w"]]
    var mL3 = [[string "w";"-";"-";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]
    var mL4 = [[string "w";"-";"-";"w";"w";"w";"w";"-";"-";"-";"-";"-";"-";"w";"w";"w"]]
    var mL5 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"-";"w";"w";"w"]]
    var mL6 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"w";"w";"w";"w";"w";"w";"w"]]
    var mL7 = [[string "w";"-";"-";"-";"-";"-";"-";"-";"-";"w";"w";"w";"w";"w";"w";"w"]]
    var mL8 = [[string "w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"]]


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
    push_clone(levels, l0)
    //print("{levels[0].mesh_level}<---level\n")
    return <- levels

def load_level(index: int)      
    build_level(read_level()[index])

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
    var count_wall:int
    var mesh := level.mesh_level
    var height_level = length(mesh)
    var width_level = length(mesh[0])
    var border_level: float2 = float2(100f,100f)
    var scale_tile = float2(HEIGHT_SCREEN/height_level, HEIGHT_SCREEN/height_level)
    var global_tile_pos = tile_pos*(scale_tile)
    //print("{global_tile_pos} - pos\n")
    //print("{scale_tile} - scale\n")
    if tile == WALL_SYMBOL
        //print("{count_wall++}\n")
        create_wall(global_tile_pos, scale_tile, BRICK_COLOR)
def create_wall(var pos: float2; scale: float2; color: uint; trigger: bool = false)
    var new_wall: Wall
    new_wall.color = color
    new_wall.pos = pos
    new_wall.collider.topLeftCorner = pos
    new_wall.collider.bottomRightCorner = pos + scale
    //print("{length(walls)}\n")
    push(walls, new_wall)
    
def create_button(var pos: float2; scale: float2; color: uint; tag: string)
    var new_button: Button
    new_button.tag = tag
    new_button.color = color
    new_button.pos = pos
    new_button.collider.topLeftCorner = pos
    new_button.collider.bottomRightCorner = pos + scale
    push(buttons, new_button)
