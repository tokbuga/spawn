(module
    (import "self" "MEMORY"  (memory $memory 1 1 shared))
    (import "memory" "malloc"       (func $malloc (param $length i32) (result i32)))
    (import "nil" "array"           (global $nil/array ref))

    (include "self/indexedDB.wat")

    (global $idbName "UUIDStore")
    (global $idb mut extern)
    (global $idbReadyState (mut i32) i32(0))


    (start $main
        $indexedDB.open<ref>( global($idbName))
    )

    (func (export "writeFile")
        (param $path                        <String>)
        (param $file                          <File>)
        (param $callback                     funcref)

        $put<refx2.fun>( 
            local($file) 
            local($path)
            local($callback)
        )
    )

    (func $Event:target<ref>ref
        (param $event                  <Event>)
        (result                       <String>) 

        $self.Event:target/get( this )
    )

    (func $indexedDB.open<ref>
        (param $name <String>)
        (local $request <IDBOpenDBRequest>)

        (local.set $request
            $IDBFactory:open<ref>ref( 
                local($name)
            )
        )

        $listenIDBOpenRequest<ref>(
            local($request)
        )
    )

    (func $listenIDBOpenRequest<ref>
        (param $this <IDBOpenDBRequest>)

        $IDBOpenDBRequest:onsuccess<ref.fun>(
            this ref($idbOpenDBRequest.onsuccess<ref>)
        )

        $IDBOpenDBRequest:onupgradeneeded<ref.fun>(
            this ref($idbOpenDBRequest.onupgradeneeded<ref>)
        )

        $IDBOpenDBRequest:onblocked<ref.fun>(
            this ref($idbOpenDBRequest.onblocked<ref>)
        )

        $IDBOpenDBRequest:onerror<ref.fun>(
            this ref($idbOpenDBRequest.onerror<ref>)
        )
    )

    (func $listenIDBRequest<ref>
        (param $this <IDBRequest>)

        $IDBRequest:onsuccess<ref.fun>(
            this ref($idbRequest.onsuccess<ref>)
        )

        $IDBRequest:onerror<ref.fun>(
            this ref($idbRequest.onerror<ref>)
        )
    )

    (func $listenIDBRequest<ref.fun>
        (param $this <IDBRequest>)
        (param $callback funcref)

        $IDBRequest:onsuccess<ref.fun>(
            this local($callback)
        )

        $IDBRequest:onerror<ref.fun>(
            this ref($idbRequest.onerror<ref>)
        )
    )

    (func $put<refx2.fun>
        (param $file           <File>)
        (param $path         <String>)
        (param $callback      funcref)

        (local $transaction <IDBTransaction>)
        (local $objectStore <IDBObjectStore>)
        (local $idbRequest <IDBRequest>)

        (local.set $transaction
            $IDBDatabase:transaction<refx2>ref(
                global($idb) text("i32x4")
            )
        )

        (local.set $objectStore
            $IDBTransaction:objectStore<refx2>ref(
                local($transaction)
                text("i32x4")
            )
        )

        (local.set $idbRequest
            $IDBObjectStore:put<refx3>ref(
                local($objectStore) 
                local($file)
                local($path)
            )
        )
        
        $listenIDBRequest<ref.fun>(
            local($idbRequest)
            local($callback)
        )
    )

    (func $get<ref>
        (param $path <String>)

        (local $transaction <IDBTransaction>)
        (local $objectStore <IDBObjectStore>)
        (local $idbRequest <IDBRequest>)

        (local.set $transaction
            $IDBDatabase:transaction<refx2>ref(
                global($idb) text("i32x4")
            )
        )

        (local.set $objectStore
            $IDBTransaction:objectStore<refx2>ref(
                local($transaction)
                text("i32x4")
            )
        )

        (local.set $idbRequest
            $IDBObjectStore:get<refx2>ref(
                local($objectStore) 
                local($path)
            )
        )

        $listenIDBRequest<ref>(
            local($idbRequest)
        )
    )

    (func $idbOpenDBRequest.onsuccess<ref>
        (param $this                        <Event>)
        (local $idbOpenDBRequest <IDBOpenDBRequest>)

        (local.set $idbOpenDBRequest
            $Event:target<ref>ref( this )
        )

        (global.set $idb
            $IDBOpenDBRequest:result<ref>ref( 
                local($idbOpenDBRequest)
            )
        )

        (global.set $idbReadyState    
            global($IDBReadyState:OPEN)
        )

        (; $test() ;)
    )   

    (func $idbRequest.onsuccess<ref>
        (param $this <Event>)
        (local $request <IDBRequest>)
        (local $result <Object>)

        (local.set $request
            $Event:target<ref>ref( this )
        )

        (local.set $result
            $IDBRequest:result<ref>ref(
                local($request)
            )
        )

        (local.get $result)
        (log<ref>)
    )   

    (func $idbRequest.onerror<ref>
        (param $this <Event>)
        (error this)
    )   

    (func $idbOpenDBRequest.onerror<ref>
        (param $this <Event>)
        (error this)
    )   

    (func $idbOpenDBRequest.onupgradeneeded<ref>
        (param $this <IDBVersionChangeEvent>)
        (warn <refx2> this text("upgrade needed"))
    )   
    
    (func $idbOpenDBRequest.onblocked<ref>
        (param $this <IDBVersionChangeEvent>)
        (error <refx2> this text("Request was blocked"))
    )   

)