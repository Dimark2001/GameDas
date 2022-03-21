require daslib/media

let 
    HEIGHT_SCREEN = get_screen_height()
    WIDTH_SCREEN = get_screen_width()

    JUMP_KEY = VK_SPACE
    MOVE_RIGHT_KEY = VK_D
    MOVE_LEFT_KEY = VK_A

    BACK_COLOR = make_color(0.9F,0.8F,0.7F,1F)
    BRICK_COLOR = make_color(1F,0F,0F,1F)
    PLAYER_COLOR = make_color(0F,0F,1F,1F)

    BUTTON_COLOR = make_color(0.7F,0.2F,1F,1F)
    //-----MENU
    BUTTON_MENU_COLOR = make_color(1F,0F,0F,1F)
    BUTTON_MENU_CROSS_COLOR = make_color(0.5F,0F,0F,1F)
    BUTTON_MENU_CLICK_COLOR = make_color(0F,1F,0F,1F)
    BUTTON_MENU_OUTLINE_COLOR = make_color(0F,0F,0F,0.8F)
    BACK_MENU_COLOR = make_color(0.7F,0.7F,0.7F,1F)
    BACK_MENU_COLOR1 = make_color(0.5F,0.3F,0.3F,1F)
    TEXT_MENU_COLOR = make_color(0F,0F,0F,1F)
    //-----MENU

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