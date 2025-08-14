
    (alias $IDBRequest:result    $IDBRequest:result<ref>ref)

    (global $IDBReadyState:OPEN                  i32 i32(1))
    (global $IDBReadyState:CLOSED                i32 i32(0))

    (global $IDBTransactionMode:READ                 "read")
    (global $IDBTransactionMode:WRITE           "readwrite")
    (global $IDBTransactionMode:FLUSH      "readwriteflush")

    (global $IDBTransactionDurability:STRICT       "strict")
    (global $IDBTransactionDurability:RELAXED     "relaxed")
    (global $IDBTransactionDurability:DEFAULT     "default")

    (global $IDBTransactionOptions:DURABILITY  "durability")

    (global $self.indexedDB                             ref)

    (global $self.IDBFactory                            ref)
    (global $self.IDBFactory:cmp                        ref)
    (global $self.IDBFactory:databases                  ref)
    (global $self.IDBFactory:deleteDatabase             ref)
    
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


    (func $IDBRequest:result<ref>ref
        (param $this              <IDBRequest>)
        (result                  <IDBDatabase>) 

        $self.IDBRequest:result/get( this )
    )

    (func $IDBRequest:error<ref>ref
        (param $this              <IDBRequest>)
        (result                 <DOMException>) 

        $self.IDBRequest:error/get( this )
    )

    (func $IDBRequest:source<ref>ref
        (param $this              <IDBRequest>)
        (result    <IDBIndex...IDBObjectStore>) 

        $self.IDBRequest:source/get( this )
    )

    (func $IDBTransaction:objectStore<refx2>ref
        (param $this          <IDBTransaction>)
        (param $storeName             <String>)
        (result               <IDBObjectStore>) 
        
        (apply $self.IDBTransaction:objectStore<ref>ref
            this
            (param local($storeName))
        )
    )

    (func $IDBObjectStore:put<refx2.i32>ref
        (param $this          <IDBTransaction>)
        (param $item                 externref)
        (param $key                        i32)
        (result                   <IDBRequest>) 
        
        (apply $self.IDBObjectStore:put<ref.i32>ref
            this (param 
                local($item)
                local($key)
            )
        )
    )

    (func $IDBObjectStore:put<refx3>ref
        (param $this          <IDBTransaction>)
        (param $item                 externref)
        (param $key                  externref)
        (result                   <IDBRequest>) 
        
        (apply $self.IDBObjectStore:put<refx2>ref
            this (param 
                local($item)
                local($key)
            )
        )
    )

    (func $IDBObjectStore:put<refx2>ref
        (param $this          <IDBTransaction>)
        (param $item                 externref)
        (result                   <IDBRequest>) 
        
        (apply $self.IDBObjectStore:put<ref>ref
            this (param 
                local($item)
            )
        )
    )

    (func $IDBObjectStore:get<refx2>ref
        (param $this          <IDBTransaction>)
        (param $key                   <String>)
        (result                   <IDBRequest>) 
        
        (apply $self.IDBObjectStore:get<ref>ref
            this (param local($key))
        )
    )

    (func $IDBObjectStore:get<ref.i32>ref
        (param $this          <IDBTransaction>)
        (param $key                        i32)
        (result                   <IDBRequest>) 
        
        (apply $self.IDBObjectStore:get<i32>ref
            this (param local($key))
        )
    )

    (func $IDBDatabase:transaction<refx4>ref
        (param $this             <IDBDatabase>)
        (param $storeNames             <Array>)
        (param $mode                  <String>)
        (param $options               <Object>)
        (result               <IDBTransaction>) 
        
        (apply $self.IDBDatabase:transaction<refx3>ref
            this
            (param
                local($storeNames)
                local($mode)
                local($options)
            )
        )
    )

    (func $IDBDatabase:transaction<refx3>ref
        (param $this             <IDBDatabase>)
        (param $storeNames             <Array>)
        (param $mode                  <String>)
        (result               <IDBTransaction>) 
        
        (apply $self.IDBDatabase:transaction<refx2>ref
            this
            (param
                local($storeNames)
                local($mode)
            )
        )
    )

    (func $IDBDatabase:transaction<refx2>ref
        (param $this             <IDBDatabase>)
        (param $storeName             <String>)
        (result               <IDBTransaction>) 
        
        (apply $self.IDBDatabase:transaction<refx2>ref
            this
            (param
                $self.Array.of<ref>ref(
                    local($storeName)
                )
                global($IDBTransactionMode:WRITE)
            )
        )
    )

    (func $IDBOpenDBRequest:error<ref>ref
        (param $this        <IDBOpenDBRequest>)
        (result                 <DOMException>)

        $IDBRequest:error<ref>ref( this )
    )

    (func $IDBOpenDBRequest:result<ref>ref
        (param $this        <IDBOpenDBRequest>)
        (result                  <IDBDatabase>) 

        $IDBRequest:result<ref>ref( this )
    )

    (func $IDBFactory:open<ref>ref
        (param $name                  <String>)
        (result             <IDBOpenDBRequest>) 

        (apply $self.IDBFactory:open<ref>ref
            global($self.indexedDB)
            (param 
                local($name)
            )
        )
    )

    (func $IDBOpenDBRequest:onsuccess<ref.fun>
        (param $this        <IDBOpenDBRequest>)
        (param $callback               funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("success") local($callback))
        )        
    )

    (func $IDBOpenDBRequest:onerror<ref.fun>
        (param $this        <IDBOpenDBRequest>)
        (param $callback               funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("error") local($callback))
        )
    )

    (func $IDBOpenDBRequest:onupgradeneeded<ref.fun>
        (param $this <IDBOpenDBRequest>)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("upgradeneeded") local($callback))
        )
    )

    
    (func $IDBOpenDBRequest:onblocked<ref.fun>
        (param $this <IDBOpenDBRequest>)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("blocked") local($callback))
        )
    )

    (func $IDBRequest:onerror<ref.fun>
        (param $this <IDBRequest>)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("error") local($callback))
        )
    )

    (func $IDBRequest:onsuccess<ref.fun>
        (param $this <IDBRequest>)
        (param $callback funcref)

        (apply $self.EventTarget:addEventListener<ref.fun>
            this (param text("success") local($callback))
        )
    )

    (alias $IndexedDB:put $IndexedDB:put<refx4>ref)

    (func $IndexedDB:put<refx4>ref
        (param $db               <IndexedDB>)
        (param $data                   <Any>)
        (param $key                 <String>)
        (param $objectStoreName     <String>)
        (result                 <IDBRequest>)

        $IDBObjectStore:put<refx3>ref(
            $IDBTransaction:objectStore<refx2>ref(
                $IDBDatabase:transaction<refx2>ref(
                    local($db) 
                    local($objectStoreName)
                )
                local($objectStoreName)
            )
            local($data) 
            local($key)
        )
    )


    (alias $IndexedDB:get   $IndexedDB:get<refx3>ref)
    (func $IndexedDB:get<refx3>ref
        (param $db               <IndexedDB>)
        (param $key                 <String>)
        (param $objectStoreName     <String>)
        (result                 <IDBRequest>)

        (local $transaction <IDBTransaction>)
        (local $objectStore <IDBObjectStore>)
    
        (local.set $transaction
            $IDBDatabase:transaction<refx2>ref(
                local($db) 
                local($objectStoreName)
            )
        )

        (local.set $objectStore
            $IDBTransaction:objectStore<refx2>ref(
                local($transaction)
                local($objectStoreName)
            )
        )

        $IDBObjectStore:get<refx2>ref(
            local($objectStore) 
            local($key)
        )
    )