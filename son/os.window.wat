(module 
    (import "self" "MEMORY"  (memory $memory 1 1 shared))
    (import "self" "MEMORY"  (global $memory externref))

    (import "memory" "malloc" (func $malloc (param $length i32) (result i32)))

    (import "storage" "writeFile"
        (func $fs.writeFile<refx2.fun> 
            (param $path      <String>) 
            (param $file        <File>) 
            (param $callback   funcref) 
        )
    )

    (global $self.document ref)

    (table $func (export "tbl_func") 1 1 funcref)

    (start $main
        (log self)

        $listen:drag/drop()
    )

    (func $listen:drag/drop
        (apply $self.addEventListener<ref.fun> 
            global($self.document) 
            (param text("drop") func($ondrop<ref>))
        )

        (apply $self.addEventListener<ref.fun> 
            global($self.document) 
            (param text("dragover") func($ondragover<ref>))
        )
    )

    (include "self/Event.wat")
    (include "self/DragEvent.wat")
    (include "self/File.wat")
    (include "self/FileList.wat")
    (include "self/DataTransfer.wat")

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

            $fs.writeFile<refx2.fun>(
                local($files/i.name)
                local($files/i)
                func($onfileupload<ref>)
            )

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


    (data $wasm:io/document "wasm://io.document.wat")

)