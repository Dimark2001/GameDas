require gameInit
require globalVarAndStruct
require levelBuild
require menu

def dead_player(var p: Player)
    if spawn_station.open
        var k: int
        create_wall(player.pos, float2(player.height, player.width), 0xffff0077, body)
        restart_player(p)
        spawn_station.open = false
        //spawn_station.type_player[select_index].count--
        if !is_menu && spawn_station.type_player[select_index].count > 0
            spawn_station.type_player[select_index].count--
            update_bar=true
        for i in spawn_station.type_player
            k += i.count
        if k <= 0
            game_over_menu()
        //player.pos = player.start_pos