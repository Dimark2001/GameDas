require daslib/media

let 
    HEIGHT_SCREEN = get_screen_height()
    WIDTH_SCREEN = get_screen_width()

    JUMP_KEY = VK_SPACE
    MOVE_RIGHT_KEY = VK_D
    MOVE_LEFT_KEY = VK_A

    BACK_COLOR = make_color(0.9F,0.8F,0.7F,1F)
    BRICK_COLOR = make_color(1F,1F,1F,1F)
    PLAYER_COLOR = make_color(0F,0F,1F,1F)
    TRIGGER_COLOR = make_color(0.7F,0.2F,1F,1F)
    SPAWN_STATION_COLOR =  make_color(1F,1F,1F,1F)

    BACK_IMAGE <- create_managed_image("Resources/ramka.png")
    BRICK_IMAGE <- create_managed_image("Sprites/Stone5.png")
    BRICK_IMAGE8 <- create_managed_image("Sprites/Stone8.png")
    PLAYER_IMAGE <- create_managed_image("Sprites/PlayerStone.png")
    TRIGGER_IMAGE <- create_managed_image("Resources/ramka.png")
    SPAWN_STATION_IMAGE <- create_managed_image("Sprites/portal1.png")

    MASK_METAL <- create_managed_image("Sprites/MaskSvar.png")
    MASK_STONE <- create_managed_image("Resources/flag.png")
    MASK_WOOD <- create_managed_image("Resources/EMPTY.png")

    BODY_METAL <- create_managed_image("Sprites/PlayerCupper.png")
    BODY_STONE <- create_managed_image("Sprites/PlayerStone.png")
    BODY_WOOD <- create_managed_image("Sprites/Stone1.png")

    HEAT_METAL <- create_managed_image("Resources/ramka.png")
    HEAT_STONE <- create_managed_image("Resources/ramka.png")
    HEAT_WOOD <- create_managed_image("Resources/ramka.png")

    LEGS_METAL <- create_managed_image("Resources/ramka.png")
    LEGS_STONE <- create_managed_image("Resources/ramka.png")
    LEGS_WOOD <- create_managed_image("Resources/ramka.png")

    //-----MENU
    BUTTON_MENU_COLOR = make_color(1F,0F,0F,1F)
    BUTTON_MENU_CROSS_COLOR = make_color(0.5F,0F,0F,1F)
    BUTTON_MENU_CLICK_COLOR = make_color(0F,1F,0F,1F)
    BUTTON_MENU_OUTLINE_COLOR = make_color(0F,0F,0F,0.8F)
    BACK_MENU_COLOR = make_color(0.7F,0.7F,0.7F,1F)
    BACK_MENU_COLOR1 = make_color(0.5F,0.3F,0.3F,1F)
    TEXT_MENU_COLOR = make_color(0F,0F,0F,1F)
    //--Bar
    METAL_PLAYER <- create_managed_image("Sprites/PlayerCupper.png")
    STONE_PLAYER <- create_managed_image("Sprites/PlayerStone.png")
    WOOD_PLAYER <- create_managed_image("Sprites/Stone1.png")
    //--Bar
    //-----MENU
    WALL_SYMBOL: string = "w"
    WALL_SYMBOL8: string = "v"
    PLAYER_SYMBOL: string = "p"
    TRIGGER_SYMBOL: string = "t"
    PORTAL_IN_SYMBOL: string = "i"
    PORTAL_OUT_SYMBOL: string = "o"
    CLOSE_SYMBOL: string = "c"
    NULL_SYMBOL: string = "-"
var
    // //--Bar
    // METAL_PLAYER <- create_managed_image("Resources/test.png")
    // STONE_PLAYER <- create_managed_image("Resources/test.png")
    // WOOD_PLAYER <- create_managed_image("Resources/test.png")
    // //--Bar
    // BACK_IMAGE <- create_managed_image("Resources/ramka.png")
    // BRICK_IMAGE <- create_managed_image("Sprites/grass.png")
    // PLAYER_IMAGE <- create_managed_image("Sprites/PlayerStone.png")
    // TRIGGER_IMAGE <- create_managed_image("Resources/ramka.png")
    // SPAWN_STATION_IMAGE <- create_managed_image("Resources/flag.png")

    // MASK_METAL <- create_managed_image("Sprites/MaskSvar.png")
    // MASK_STONE <- create_managed_image("Resources/flag.png")
    // MASK_WOOD <- create_managed_image("Resources/EMPTY.png")

    // BODY_METAL <- create_managed_image("Sprites/PlayerCupper.png")
    // BODY_STONE <- create_managed_image("Sprites/PlayerStone.png")
    // BODY_WOOD <- create_managed_image("Sprites/Stone1.png")

    // HEAT_METAL <- create_managed_image("Resources/ramka.png")
    // HEAT_STONE <- create_managed_image("Resources/ramka.png")
    // HEAT_WOOD <- create_managed_image("Resources/ramka.png")

    // LEGS_METAL <- create_managed_image("Resources/ramka.png")
    // LEGS_STONE <- create_managed_image("Resources/ramka.png")
    // LEGS_WOOD <- create_managed_image("Resources/ramka.png")

    
    rect_collider: Rect_collider
    player: Player
    spawn_station: Spawn_station
    
    gravity: float = 9.8*10f
    levels: array<Level>
    image_player_in_bar: array<ImageHandle>
    tp_pos:float2
    jump_pressed: bool = false
    is_jump:bool = false
    update_bar: bool
    offsetRL: float //погрешность для боковых столкновений
    offsetDU: float //погрешность для нижн./верх. столкновений
    current_level: int = 0
    max_levels: int = 1
    loading_level: bool
    walls: array<Wall> 
    triggers: array<Trigger> 
    buttons_menu: array<Button_menu> 
    is_menu:bool
    is_gameover:bool
    //is_restart:bool

    select_index:int
    labels: array<Label>


    body <- create_managed_image("Resources/EMPTY.png")
    mask <- create_managed_image("Resources/EMPTY.png")
    heat <- create_managed_image("Resources/EMPTY.png")
    legs <- create_managed_image("Resources/EMPTY.png")

    spawn <- create_managed_image("Resources/EMPTY.png")


struct Rect_collider
    topLeftCorner: float2
    bottomRightCorner: float2
    collision_for_player: bool = false
    image: ImageHandle
    //trigger: bool = false

struct Wall
    collider: Rect_collider
    color: uint
    pos: float2
    //death
struct Label
    text: string
    font: string
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
    type_player: array<Type_Player>

struct Trigger
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
struct Spawn_station
    open: bool
    type_player: array<Type_Player_Bar>
    //image: Image
struct Level
    mesh_level: array<array<string>>
    level_name: string
    type_name: array<string>
    type_count: array<int>

struct Type_Player
    name:string
    active:bool

struct Type_Player_Bar
    name:string
    image:ImageHandle
    count:int
    //type_player: array<Type_Player>
