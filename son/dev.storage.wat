(module
    (import "self" "SHARED_MEMORY"  (memory $memory 1 1 shared))
    (import "memory" "malloc"       (func $malloc (param $length i32) (result i32)))
    (import "nil" "array"           (global $nil/array ref))

    (global $self.indexedDB                             ref)

    (global $self.IDBFactory                            ref)
    (global $self.IDBFactory:cmp                        ref)
    (global $self.IDBFactory:databases                  ref)
    (global $self.IDBFactory:deleteDatabase             ref)
    
    (global $self.Event:type/get                        ref)

    (global $self.IDBRequest                            ref)
    (global $self.IDBRequest:readyState/get             ref)

    (global $self.IDBRequest:onerror/get                ref)
    (global $self.IDBRequest:onerror/set                ref)
    (global $self.IDBRequest:onsuccess/get              ref)
    (global $self.IDBRequest:onsuccess/set              ref)

    (global $self.IDBOpenDBRequest                      ref)
    (global $self.IDBOpenDBRequest:onblocked/get        ref)
    (global $self.IDBOpenDBRequest:onblocked/set        ref)
    (global $self.IDBOpenDBRequest:onupgradeneeded/get  ref)
    (global $self.IDBOpenDBRequest:onupgradeneeded/set  ref)


    (global $self.IDBDatabase                           ref)
    (global $self.IDBDatabase:close                     ref)
    (global $self.IDBDatabase:createObjectStore         ref)
    (global $self.IDBDatabase:deleteObjectStore         ref)
    (global $self.IDBDatabase:transaction               ref)
    (global $self.IDBDatabase:name/get                  ref)
    (global $self.IDBDatabase:version/get               ref)
    (global $self.IDBDatabase:objectStoreNames/get      ref)

    (global $self.IDBDatabase:onversionchange/get       ref)
    (global $self.IDBDatabase:onversionchange/set       ref)
    (global $self.IDBDatabase:onerror/get               ref)
    (global $self.IDBDatabase:onerror/set               ref)
    (global $self.IDBDatabase:onclose/get               ref)
    (global $self.IDBDatabase:onclose/set               ref)
    (global $self.IDBDatabase:onabort/get               ref)
    (global $self.IDBDatabase:onabort/set               ref)

    (global $self.IDBTransaction                        ref)
    (global $self.IDBTransaction:abort                  ref)
    (global $self.IDBTransaction:commit                 ref)
    (global $self.IDBTransaction:objectStore            ref)
    (global $self.IDBTransaction:db/get                 ref)
    (global $self.IDBTransaction:mode/get               ref)
    (global $self.IDBTransaction:objectStoreNames/get   ref)
    (global $self.IDBTransaction:durability/get         ref)
    (global $self.IDBTransaction:error/get              ref)
    (global $self.IDBTransaction:onabort/get            ref)
    (global $self.IDBTransaction:onabort/set            ref)
    (global $self.IDBTransaction:oncomplete/get         ref)
    (global $self.IDBTransaction:oncomplete/set         ref)
    (global $self.IDBTransaction:onerror/get            ref)
    (global $self.IDBTransaction:onerror/set            ref)

    (global $idbName "wfs")

    (func $Event:target<ref>ref
        (param $event ref)
        (result (; String ;) ref) 
        (apply $self.Event:target/get<>ref this (param))
    )

    (func $IDBRequest:result<ref>ref
        (param $idbRequest ref)
        (result (; IDBDatabase ;) ref) 
        (apply $self.IDBRequest:result/get<>ref this (param))
    )

    (func $IDBRequest:error<ref>ref
        (param $idbRequest ref)
        (result (; DOMException ;) ref) 
        (apply $self.IDBRequest:error/get<>ref this (param))
    )

    (func $IDBRequest:source<ref>ref
        (param $idbRequest ref)
        (result (; IDBIndex, IDBObjectStore or IDBCursor ;) ref) 
        (apply $self.IDBRequest:source/get<>ref this (param))
    )

    (func $IDBRequest:transaction<ref>ref
        (param $idbRequest ref)
        (result (; IDBTransaction ;) ref) 
        (apply $self.IDBRequest:transaction/get<>ref this)
    )

    (func $IDBOpenDBRequest:error<ref>ref
        (param $idbOpenDBRequest ref)
        (result (; DOMException ;) ref) 
        (call $IDBRequest:error<ref>ref this)
    )

    (func $IDBOpenDBRequest:result<ref>ref
        (param $idbOpenDBRequest ref)
        (result (; IDBDatabase ;) ref) 
        (call $IDBRequest:result<ref>ref this)
    )

    (func $IDBFactory:open<ref>ref
        (param $name ref)
        (result (; IDBOpenDBRequest ;) ref) 

        (apply $self.IDBFactory:open<ref>ref
            global($self.indexedDB)
            (param local($name))
        )
    )

    (func $IDBOpenDBRequest:onsuccess<ref.fun>
        (param $idbOpenDBRequest ref)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("success") local($callback))
        )        
    )

    (func $IDBOpenDBRequest:onerror<ref.fun>
        (param $idbOpenDBRequest ref)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("error") local($callback))
        )
    )

    (func $IDBOpenDBRequest:onupgradeneeded<ref.fun>
        (param $idbOpenDBRequest ref)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("upgradeneeded") local($callback))
        )
    )

    
    (func $IDBOpenDBRequest:onblocked<ref.fun>
        (param $idbOpenDBRequest ref)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("blocked") local($callback))
        )
    )

    (func $IDBRequest:onerror<ref.fun>
        (param $idbRequest ref)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("error") local($callback))
        )
    )

    (func $IDBRequest:onsuccess<ref.fun>
        (param $idbRequest ref)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("success") local($callback))
        )
    )

    (start $main
        (log text("hi from storage"))        

        $indexedDB.open<ref>(
            global($idbName)
        )
    )

    (func $indexedDB.open<ref>
        (param $name ref)
        (local $idbOpenDBRequest ref)

        (local.set $idbOpenDBRequest
            $IDBFactory:open<ref>ref( 
                local($name)
            )
        )

        $listenIDBOpenRequest<ref>(
            local($idbOpenDBRequest)
        )

        (warn<ref> local($idbOpenDBRequest))
    )

    (func $listenIDBOpenRequest<ref>
        (param $idbOpenDBRequest ref)

        $IDBOpenDBRequest:onsuccess<ref.fun>(
            local($idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onsuccess<ref>)
        )

        $IDBOpenDBRequest:onupgradeneeded<ref.fun>(
            local($idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onupgradeneeded<ref>)
        )

        $IDBOpenDBRequest:onblocked<ref.fun>(
            local($idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onblocked<ref>)
        )

        $IDBOpenDBRequest:onerror<ref.fun>(
            local($idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onerror<ref>)
        )
    )

    (func $idbOpenDBRequest.onsuccess<ref>
        (param $event ref)
        (local $idbOpenDBRequest ref)
        (local $idbDatabase ref)

        (log this)

        (local.set $idbOpenDBRequest
            $Event:target<ref>ref( this )
        )

        (local.set $idbDatabase
            $IDBOpenDBRequest:result<ref>ref( 
                local($idbOpenDBRequest)
            )
        )

        (log <ref> 
            $Event:target<ref>ref( this ) 
        )
    )   

    (func $idbOpenDBRequest.onerror<ref>
        (param $event ref)
        (error this)
    )   

    (;  Event->IDBVersionChangeEvent
    ;;  The upgradeneeded event is fired when an attempt was made to 
    ;;  open a database with a version number higher than its current 
    ;;  version.

        IDBVersionChangeEvent.oldVersion
    ;;  Returns the old version of the database.

        IDBVersionChangeEvent.newVersion 
    ;;  Returns the new version of the database.
    ;)
    (func $idbOpenDBRequest.onupgradeneeded<ref>
        (param $idbVersionChangeEvent ref)
        (warn <refx2> this text("upgrade needed"))
    )   

    (;  Event->IDBVersionChangeEvent

    ;;  The blocked handler is executed when an open connection to 
    ;;  a database is blocking a versionchange transaction on the 
    ;;  same database.

        IDBVersionChangeEvent.oldVersion
    ;;  Returns the old version of the database.

        IDBVersionChangeEvent.newVersion 
    ;;  Returns the new version of the database.
    ;)
    (func $idbOpenDBRequest.onblocked<ref>
        (param $idbVersionChangeEvent ref)
        (error <refx2> this text("Request was blocked"))
    )   

)