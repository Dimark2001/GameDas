require daslib/media

require globalVarAndStruct
var 
    body <- create_image("Resources/ramka.png")
    mask <- create_image("Resources/ramka.png")
    heat <- create_image("Resources/ramka.png")
    legs <- create_image("Resources/ramka.png")
def render_player(var player: Player)
    var height = player.collider.bottomRightCorner.y - player.collider.topLeftCorner.y
    var width = player.collider.bottomRightCorner.x - player.collider.topLeftCorner.x
    fill_rect(player.pos.x, player.pos.y, width, height, PLAYER_COLOR)

    
    body |> draw_image(player.pos.x, player.pos.y, make_color(1f,1f,1f,1f), float2(width, height))
    mask |> draw_image(player.pos.x + height/2f, player.pos.y-width/2f, make_color(1f,1f,1f,1f), float2(width, height))
    heat |> draw_image(player.pos.x - height/2f, player.pos.y-width/2f, make_color(1f,1f,1f,1f), float2(width, height))
    legs |> draw_image(player.pos.x - width/2f, player.pos.y + height/2f, make_color(1f,1f,1f,1f), float2(width, height))
    legs |> draw_image(player.pos.x + width/2f, player.pos.y + height/2f, make_color(1f,1f,1f,1f), float2(width, height))
    //fill_rect( , )

def render_walls(var walls: array<Wall>)
    for wall in walls
        var height = wall.collider.bottomRightCorner.y - wall.collider.topLeftCorner.y
        var width = wall.collider.bottomRightCorner.x - wall.collider.topLeftCorner.x
        wall.pos = wall.collider.topLeftCorner
        fill_rect(wall.pos.x, wall.pos.y, width, height, wall.color)
def render_buttons(var buttons: array<Button>)
    for b in buttons
        var height = b.collider.bottomRightCorner.y - b.collider.topLeftCorner.y
        var width = b.collider.bottomRightCorner.x - b.collider.topLeftCorner.x
        b.collider.topLeftCorner = b.pos
        fill_rect(b.pos.x, b.pos.y, width, height, b.color)
def render_buttons_menu(var b_menu: array<Button_menu>)
    for b in b_menu
        var height = b.collider.bottomRightCorner.y - b.collider.topLeftCorner.y
        var width = b.collider.bottomRightCorner.x - b.collider.topLeftCorner.x
        b.collider.topLeftCorner = b.pos
        fill_rect(b.pos.x, b.pos.y, width, height, b.color)
        
        set_font_name("sans")
        set_font_size(b.text.font_size)
        if b.tag != "false"
            text_out(b.text.pos.x, b.text.pos.y, b.tag, TEXT_MENU_COLOR)
        //text_out(100, 520, "Open Sans", make_color(0.2, 0.3, 0.1))

def render_level(var walls: array<Wall>; var buttons: array<Button>; var buttons_menu: array<Button_menu>)
    render_walls(walls)
    render_buttons(buttons)
    render_buttons_menu(buttons_menu)
def render_background()
    fill_rect(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN, BACK_COLOR)