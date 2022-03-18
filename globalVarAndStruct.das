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
    levels: array<Level>
    jump_pressed: bool = false
    is_jump:bool = false
    offsetRL: float //погрешность для боковых столкновений
    offsetDU: float //погрешность для нижн./верх. столкновений
    current_level: int = 0
    max_levels: int = 1
    loading_level: bool
    walls: array<Wall> 
    buttons: array<Button> 
    buttons_menu: array<Button_menu> 
    is_menu:bool
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
struct Label
    text: string
    font_size: float
    pos: float2
struct Player
    collider: Rect_collider
    pos: float2
    velocity: float2
    speed: float
    force_jump: float = 10f
    height: float = 100f
    width: float = 100f
    start_pos: float2
struct Button
    collider: Rect_collider
    color: uint
    is_active: bool
    pos: float2
    tag: string
struct Button_menu
    pos: float2
    collider: Rect_collider
    color: uint
    color_cross: uint
    color_click: uint
    color_def: uint
    tag: string
    pressed: bool = true
    text: Label
    //image
struct Level
    mesh_level: array<array<string>>