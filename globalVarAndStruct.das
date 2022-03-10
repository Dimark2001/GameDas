require daslib/media

let 
    HEIGHT_SCREEN = get_screen_height()
    WIDTH_SCREEN = get_screen_width()
    BACK_COLOR = 0xF0F0A0
    BRICK_COLOR = 0xFF0000
    PLAYER_COLOR = 0x0000ff
    JUMP_KEY = VK_SPACE
    MOVE_RIGHT_KEY = VK_D
    MOVE_LEFT_KEY = VK_A

    WALL_SYMBOL: string = "w"
    PLAYER_SYMBOL: string = "p"
    BUTTON_SYMBOL: string = "b"
    CLOSE_SYMBOL: string = "c"
    NULL_SYMBOL: string = "-"

var
    rect_collider: Rect_collider
    player: Player
    gravity: float = 9.8*10f
    walls: array<Wall> 
    buttons: array<Button> 
    levels: array<Level>
    //wall: Wall
    jump_pressed: bool = false
    is_jump:bool = false
    offsetRL: float //погрешность для боковых столкновений
    offsetDU: float //погрешность для нижн./верх. столкновений

struct Rect_collider
    topLeftCorner: float2
    bottomRightCorner: float2
    collision_for_player: bool = false
    //trigger: bool = false

struct Wall
    collider: Rect_collider
    color: uint
    pos: float2
    //death

struct Player
    collider: Rect_collider
    pos: float2
    velocity: float2
    speed: float
    force_jump: float = 10f
    h_col: float = 100f
    w_col: float = 100f
struct Button
    collider: Rect_collider
    color: uint
    is_active: bool
    pos: float2
    tag: string

struct Level
    mesh_level: array<array<string>>