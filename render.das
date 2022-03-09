require daslib/media

require globalVarAndStruct

def render_player(var player: Player)
    var height = player.collider.bottomRightCorner.y - player.collider.topLeftCorner.y
    var width = player.collider.bottomRightCorner.x - player.collider.topLeftCorner.x
    fill_rect(player.pos.x, player.pos.y, width, height, PLAYER_COLOR)


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
def render_level(var walls: array<Wall>; var buttons: array<Button>)
    render_walls(walls)
    render_buttons(buttons)

def render_background()
    fill_rect(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN, BACK_COLOR)