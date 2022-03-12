require daslib/media


require globalVarAndStruct
def restart_player(var player: Player)
    player.pos = float2(80,100)
    player.velocity = float2(0,0)
    player.speed = 200f
    player.force_jump = 4f*gravity
    player.h_col = 80f // выс коллайдера и спрайта
    player.w_col = 80f
    offsetRL = player.h_col/10f
    offsetDU = player.h_col/100f