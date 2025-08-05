(module 
    (import "self" "memory" (memory $memory 1 1 shared))
    (import "self" "memory" (global $memory externref))

    (global $worker                     mut extern)
    (global $workerURL                  mut extern)
    (global $workerScript "
    onmessage = e => {   
        console.log(e) 
        globalThis.onmessage = f => {
            console.warn(f)
        }
        WebAssembly
            .instantiate(e.data.shared, globalThis)
            .then(e => {
            
            })
        ;
    }
    ")

    (start $main
        $init()
    )

    (func $init
        (local $promises <Array>)
        (local $promiseAll <Promise>)

        (local #promises 
            $self.Array.of<refx6>ref(
                $self.WebAssembly.compile<ref>ref( global($wasm:shared) )
                $self.WebAssembly.compile<ref>ref( global($wasm:sys/event) )
                $self.WebAssembly.compile<ref>ref( global($wasm:dev/memory) )    
                $self.WebAssembly.compile<ref>ref( global($wasm:dev/clock) )
                $self.WebAssembly.compile<ref>ref( global($wasm:dev/storage) )
                $self.WebAssembly.compile<ref>ref( global($wasm:dev/ethernet) )
            )
        )

        (local #promiseAll
            (apply $self.Promise.all<ref>ref 
                global($self.Promise) 
                (param local($promises))
            )
        )

        (apply $self.Promise:then<fun>
            local($promiseAll)
            (param func($onallcompile<ref>))
        )
    )

    (func $onallcompile<ref>
        (param $promises                <Array>)
        (local $workerURL                 <URL>)
        (local $workerData             <Object>)

        (global #worker 
            new $self.Worker<ref>ref( 
                $workerURL() 
            )
        )

        (local #workerData $self.Object())

        (set <refx3> local($workerData) text("memory") global($memory))
        (set <refx3> local($workerData) text("shared") local($promises[0]))
        (set <refx3> local($workerData) text("sys/event") local($promises[1]))
        (set <refx3> local($workerData) text("dev/memory") local($promises[2]))
        (set <refx3> local($workerData) text("dev/clock") local($promises[3]))
        (set <refx3> local($workerData) text("dev/storage") local($promises[4]))
        (set <refx3> local($workerData) text("dev/ethernet") local($promises[5]))

        $Worker:postMessage<refx2>(
            global($worker) local($workerData)
        )

        $listen()    
    ) 

    (func $listen
        (apply $self.addEventListener<ref.fun> 
            self (param text("drop") func($ondrop<ref>))
        )

        (apply $self.addEventListener<ref.fun> 
            self (param text("dragover") func($ondragover<ref>))
        )
    )

    (include "self/Event.wat")
    (include "self/DragEvent.wat")
    (include "self/File.wat")
    (include "self/FileList.wat")
    (include "self/DataTransfer.wat")
    (include "self/Worker.wat")

    (func $ondrop<ref>
        (param $event                          <DragEvent>)
        (local $dataTransfer                <DataTransfer>)
        
        (local $files                           <FileList>)
        (local $files.length                           i32)

        (local $files/i                             <File>)
        (local $files/i.name                      <String>)
        (local $files/i.size                           i32)
        (local $files/i.lastModified                   f64)
        (local $files/i.lastModifiedDate            <Date>)

        $Event:preventDefault<ref>( this )

        (local.set $dataTransfer            $DragEvent:dataTransfer<ref>ref( this ))
        (local.set $files       $DataTransfer:files<ref>ref( local($dataTransfer) ))
        (local.set $files.length          $FileList:length<ref>i32( local($files) ))

        (if (i32.eqz local($files.length)) (then return))

        (loop $files/i

            (local.set $files.length    local($files.length)-- )
            (local.set $files/i         $FileList:item<ref.i32>ref(local($files) local($files.length)))

            (local.set $files/i.name                $File:name<ref>ref(local($files/i)))
            (local.set $files/i.size                $File:size<ref>i32(local($files/i)))
            (local.set $files/i.lastModified        $File:lastModified<ref>f64(local($files/i)))
            (local.set $files/i.lastModifiedDate    $File:lastModifiedDate<ref>ref(local($files/i)))            

            (warn <refx2.fun>
                local($files/i.name)
                local($files/i)
                func($onfileupload<ref>)
            )

            (async 
                (apply $self.Blob:arrayBuffer<>ref
                    local($files/i)
                    (param)
                )
                (func $onarraybuffer<ref> 
                    (param $arrayBuffer externref)
                    
                    $Worker:postMessage<refx3>(
                        global($worker) 
                        local($arrayBuffer)
                        $self.Array.of<ref>ref(
                            local($arrayBuffer)
                        )
                    )
                )
            )

            (warn<ref>)

            (br_if $files/i local($files.length))
        )
    )

    

    (func $onfileupload<ref> 
        (param $event <EVent>)
        (log this)
    )

    (func $ondragover<ref> 
        (param $event <DragEvent>)
        
        $Event:preventDefault<ref>( this )
    )

    (func $workerURL
        (result $url <URL>)

        (if (ref.is_null global($workerURL))
            (then 
                (global.set $workerURL
                    $self.URL.createObjectURL<ref>ref(
                        new $self.Blob<ref>ref( 
                            $self.Array.of<ref>ref(
                                global($workerScript)
                            )
                        )
                    )
                )
            )
        )

        global($workerURL)
    )


    (data $wasm:shared "wasm://shared.wat")
    (data $wasm:dev/memory "wasm://dev.memory.wat")
    (data $wasm:dev/clock "wasm://dev.clock.wat")
    (data $wasm:dev/storage "wasm://dev.storage.wat")
    (data $wasm:dev/ethernet "wasm://dev.ethernet.wat")
    (data $wasm:sys/event "wasm://sys.event.wat")

)