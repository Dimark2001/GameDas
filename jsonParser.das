
require daslib/media

require fio
require daslib/json
require daslib/json_boost
require globalVarAndStruct
[export]
def read(path: string)
    var levels: array<Level>


    let f = fopen(path, "rb") 
    let data = fread(f) 
    var error = ""
    var json = read_json(data, error)
    for level in (json as _array) 
        var y := level as _object
        var new_level: Level
        new_level.level_name := y["level_name"] as _string
        //var mesh := y["walls"] as _array
        
        var osY := y["walls"] as _array
        
        //print("{osY}")
        resize(new_level.mesh_level, length(osY))
        for numberY in range(length(osY))
            var osX := osY[numberY] as _array
            //var vertical := new_level.mesh_level[numberY]
            //push_clone(new_level.mesh_level[numberY], osY[numberY][0] as _string)

            for i in range(length(osX))
                push_clone(new_level.mesh_level[numberY], osX[i] as _string)

        print(">{new_level.mesh_level}<\n")
        for i in y["type_name"] as _array
            push(new_level.type_name, i as _string)

        for j in y["type_count"] as _array
            push(new_level.type_count, int(j as _number))
        new_level.biom := y["biom"] as _string
        push_clone(levels, new_level)

    return <- levels
    // struct Level
    //     mesh_level: array<array<string>>
    //     level_name: string
    //     type_name: array<string>
    //     type_count: array<int>
    //     biom: string