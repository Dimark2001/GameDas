require daslib/media


require globalVarAndStruct
def restart_player(var player: Player)
    player.pos = float2(100,100)
    player.velocity = float2(0,0)
    player.speed = 300f
    player.force_jump = 2f*gravity
    player.h_col = 50f // выс коллайдера и спрайта
    player.w_col = 50f
    offsetRL = player.h_col/10f
    offsetDU = player.h_col/100f