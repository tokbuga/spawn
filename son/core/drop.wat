
    (global $idb.uploads/tmp mut extern)

    ;;indexedDB.open("fs").onupgradeneeded = e => e.target.result.createObjectStore("uploads", { keyPath: "path" });
    (func $uploads.open 
        (local $idbOpenDBRequest <IDBOpenDBRequest>)
        
        local($idbOpenDBRequest
            $IDBFactory:open<ref>ref( 
                text("tmp")
            )
        )
        
        $IDBOpenDBRequest:onsuccess<ref.fun>( 
            local($idbOpenDBRequest)  
            (func $onuploadsopensuccess<ref> 
                (param <Event>)
                (global.set $idb.uploads/tmp
                    $IDBOpenDBRequest:result<ref>ref( 
                        $Event:target( this )
                    )
                )
            )   
        )

        $IDBOpenDBRequest:onupgradeneeded<ref.fun>(
            local($idbOpenDBRequest)  
            (func $onuploadsupgradeneeded<ref>
                (param $this <IDBVersionChangeEvent>)
                (warn <refx2> this text("upgrade needed"))
            )   
        )

        $IDBOpenDBRequest:onblocked<ref.fun>(
            local($idbOpenDBRequest)  
            (func $onuploadsopenblocked<ref>
                (param $this <IDBVersionChangeEvent>)
                (error <refx2> this text("Request was blocked"))
            )   
        )

        $IDBOpenDBRequest:onerror<ref.fun>(
            local($idbOpenDBRequest)  
            (func $onuploadsopenerror<ref>
                (param $this <Event>)
                (error this)
            )   
        )
    )

    (func $uploads.store<ref.funx2>
        (param $file                  <File>)
        (param $onsuccess            funcref)
        (param $onerror              funcref)
        (local $idbRequest      <IDBRequest>)

        local($idbRequest 
            $IndexedDB:put(
                global($idb.uploads/tmp) 
                local($file) 
                $File:name( local($file) )
                text("uploads") 
            )
        )

        $IDBRequest:onerror<ref.fun>( local($idbRequest) local($onerror) )
        $IDBRequest:onsuccess<ref.fun>( local($idbRequest) local($onsuccess) )
    )

    (func $uploads.load<ref.funx2>
        (param $name                      <String>)
        (param $onsuccess                  funcref)
        (param $onerror                    funcref)
        (local $idbRequest            <IDBRequest>)

        local($idbRequest 
            $IndexedDB:get(
                global($idb.uploads/tmp) 
                local($name) 
                text("uploads")
            )
        )

        $IDBRequest:onerror<ref.fun>( local($idbRequest) local($onerror) )
        $IDBRequest:onsuccess<ref.fun>( local($idbRequest) local($onsuccess) )

    )

    (func $onloaduploadsuccess<ref>
        (param $this <Event>)

        (warn
            $IDBRequest:result(
                $Event:target( this )
            )
        )
    )   

    (func $onstoreuploadsuccess<ref>
        (param $this <Event>)

        (warn
            $IDBRequest:result(
                $Event:target( this )
            )
        )
    )   


    (func $onloaduploaderror<ref> (param $this <Event>) (error this))   
    (func $onstoreuploaderror<ref> (param $this <Event>) (error this))   
