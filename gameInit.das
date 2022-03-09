require daslib/media


require globalVarAndStruct
def restart_player(var player: Player)
    player.pos = float2(100,100)
    player.velocity = float2(0,0)
    player.speed = 500f
    player.force_jump = 800f
    player.h_col = 100f // выс коллайдера и спрайта
    player.w_col = 100f
    offsetRL = player.h_col/10f
    offsetDU = player.h_col/100f