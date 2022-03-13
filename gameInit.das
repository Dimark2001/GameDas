require daslib/media


require globalVarAndStruct
def restart_player(var player: Player; pos: float2; height:float; width:float)
    player.pos = pos//float2(80,100)
    player.velocity = float2(0,0)
    player.speed = 200f
    player.force_jump = 4f*gravity
    player.height = height//80f // выс коллайдера и спрайта
    player.width = width //80f
    offsetRL = player.height/10f
    offsetDU = player.width/100f

