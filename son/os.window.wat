(module 
    (import "self" "memory" (memory $memory 10 10 shared))
    (import "self" "memory" (global $memory externref))

    (include "self/PointerEvent.wat")
    (include "self/MouseEvent.wat")
    (include "self/UIEvent.wat")
    (include "self/DragEvent.wat")
    (include "self/Event.wat")
    (include "self/File.wat")
    (include "self/FileList.wat")
    (include "self/DataTransfer.wat")
    (include "self/Worker.wat")
    (include "self/Object.wat")
    (include "self/WeakSet.wat")
    (include "self/WeakMap.wat")
    (include "self/WeakRef.wat")


    (table $ref 1 65536 externref)

    (global $weak<Set> new WeakSet)
    (global $weak<Map> new WeakMap)

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
        $malloc(i32(24));
        $init()
    )

    (alias $ref $ref<ref>i32)
    (alias $deref $deref<i32>ref)
    (alias $malloc $malloc<i32>i32)

    (func $malloc<i32>i32 
        (param $length                  i32) 
        (result $offset                 i32) 

        (i32.atomic.rmw.add i32(0) local($length))
    )


    (func $deref<i32>ref 
        (param $index                    i32)
        (result $value              <Object>)

        $WeakRef:deref<ref>ref( get($ref local($index)) )
    )

    (func $ref<ref>i32 
        (param $value               <Object>)
        (result $index                   i32)

        (if (null === this)
            (then false return)
        )

        (if (call $WeakMap:hasnt<refx2>i32 
                global($weak<Map>) local($value) 
            )
            (then 
                $WeakMap:set<refx2.i32>(
                    global($weak<Map>) 
                    local($value) 
                    grow($ref 
                        $WeakRef:new<ref>ref(
                            local($value)
                        ) 
                        true
                    )
                )
            )
        )

        $WeakMap:get<refx2>i32(
            global($weak<Map>) local($value) 
        )
    )

    (func $init
        (local $promises <Array>)
        (local $promiseAll <Promise>)

        (local #promises 
            $self.Array.of<ref>ref(
                $self.WebAssembly.compile<ref>ref( global($wasm:shared) )
            )
        )

        local($promiseAll
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
        (local $data                   <Object>)

        local($data $Object:new())
        local($data)x7
        
        (set <refx3> text("memory")       global($memory))
        (set <refx3> text("shared")       local($promises[0]))


        global($worker $Worker:new($workerURL()))

        $Worker:postMessage(
            global($worker) local($data)
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

        (apply $self.addEventListener<ref.fun> 
            self (param text("pointermove") func($onpointermove<ref>))
        )

        (apply $self.addEventListener<ref.fun> 
            self (param text("pointerdown") func($onpointerdown<ref>))
        )

        (warn global($memory))
    )


    (func $onpointermove<ref>
        (param $event                       <PointerEvent>)
        
        (warn <i32>
            $PointerEvent.from<ref>i32( this )
        )
    )

    (func $onpointerdown<ref>
        (param $event                       <PointerEvent>)

        (warn <ref.i32>
            this
            $PointerEvent.from<ref>i32( this )
        )
    )

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

            (local #files.length 
                local($files.length)-- 
            )

            (local #files/i
                $FileList:item<ref.i32>ref(
                    local($files) 
                    local($files.length)
                )
            )
            
            local($files/i.name                $File:name<ref>ref(local($files/i)))
            local($files/i.size                $File:size<ref>i32(local($files/i)))
            local($files/i.lastModified        $File:lastModified<ref>f64(local($files/i)))
            local($files/i.lastModifiedDate    $File:lastModifiedDate<ref>ref(local($files/i)))            

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
)