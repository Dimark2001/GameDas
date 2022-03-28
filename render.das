require daslib/media

require globalVarAndStruct



def render_player(var player: Player)
    var height = player.collider.bottomRightCorner.y - player.collider.topLeftCorner.y
    var width = player.collider.bottomRightCorner.x - player.collider.topLeftCorner.x
    //fill_rect(player.pos.x, player.pos.y, width, height, PLAYER_COLOR)

    
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
        if wall.collider.image.width == 0
            fill_rect(wall.pos.x, wall.pos.y, width, height, wall.color)
        else
            wall.collider.image |> draw_image(wall.pos.x, wall.pos.y, wall.color, float2(width, height))
def render_triggers(var triggers: array<Trigger>)
    for t in triggers
        var height = t.collider.bottomRightCorner.y - t.collider.topLeftCorner.y
        var width = t.collider.bottomRightCorner.x - t.collider.topLeftCorner.x
        t.collider.topLeftCorner = t.pos
        if t.collider.image.width == 0
            fill_rect(t.pos.x, t.pos.y, width, height, t.color)
        else
            t.collider.image |> draw_image(t.pos.x, t.pos.y, t.color, float2(width, height))


def render_buttons_menu(var b_menu: array<Button_menu>)
    for b in b_menu
        var height = b.collider.bottomRightCorner.y - b.collider.topLeftCorner.y
        var width = b.collider.bottomRightCorner.x - b.collider.topLeftCorner.x
        b.collider.topLeftCorner = b.pos
        if b.collider.image.width == 0
            fill_rect(b.pos.x, b.pos.y, width, height, b.color)
        else
            b.collider.image |> draw_image(b.pos.x, b.pos.y, b.color, float2(width, height))
        set_font_name("sans")
        set_font_size(b.text.font_size)
        if b.tag != "false"
            text_out(b.text.pos.x, b.text.pos.y, b.tag, TEXT_MENU_COLOR)
        //text_out(100, 520, "Open Sans", make_color(0.2, 0.3, 0.1))
def render_labels(var labels: array<Label>)
    for l in labels
        set_font_name(l.font)
        set_font_size(l.font_size)
        text_out(l.pos.x, l.pos.y, l.text, make_color(0f,1f,1f,1f))

def render_level(var walls: array<Wall>; var triggers: array<Trigger>; var buttons_menu: array<Button_menu>)
    render_walls(walls)
    render_triggers(triggers)
    render_buttons_menu(buttons_menu)
    render_labels(labels)
def render_background()
    fill_rect(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN, BACK_COLOR)