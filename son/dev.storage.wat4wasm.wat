(module
    
    
    (import "self" "Array"              (func $wat4wasm/Array<>ref (param) (result externref)))
    (import "Reflect" "set"             (func $wat4wasm/Reflect.set<ref.i32x2> (param externref i32 i32) (result)))
    (import "Reflect" "getOwnPropertyDescriptor" (func $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref (param externref externref) (result externref)))
    (import "Reflect" "get"             (func $wat4wasm/Reflect.get<refx2>ref (param externref externref) (result externref)))
    (import "Reflect" "get"             (func $wat4wasm/Reflect.get<refx2>i32 (param externref externref) (result i32)))
    (import "Reflect" "get"             (func $wat4wasm/Reflect.get<refx2>f32 (param externref externref) (result f32)))
    (import "Reflect" "get"             (func $wat4wasm/Reflect.get<refx2>i64 (param externref externref) (result i64)))
    (import "Reflect" "get"             (func $wat4wasm/Reflect.get<refx2>f64 (param externref externref) (result f64)))
    (import "Reflect" "apply"           (func $wat4wasm/Reflect.apply<refx3>ref (param externref externref externref) (result externref)))
    (import "self" "self"               (global $wat4wasm/self externref))
    (import "String" "fromCharCode"     (global $wat4wasm/String.fromCharCode externref))
   
	(import "Reflect" "apply" (func $self.Reflect.apply<refx3>ref (param externref externref externref) (result externref)))
	(import "Array" "of" (func $self.Array.of<>ref  (result externref)))
	(import "Array" "of" (func $self.Array.of<ref>ref (param externref) (result externref)))
	(import "Reflect" "apply" (func $self.Reflect.apply<refx3> (param externref externref externref)))
	(import "Array" "of" (func $self.Array.of<ref.fun>ref (param externref funcref) (result externref)))
	(import "console" "log" (func $self.console.log<ref> (param externref)))
	(import "console" "warn" (func $self.console.warn<ref> (param externref)))
	(import "console" "error" (func $self.console.error<ref> (param externref)))
	(import "console" "warn" (func $self.console.warn<refx2> (param externref externref)))
	(import "console" "error" (func $self.console.error<refx2> (param externref externref)))
	 

    (import "self" "SHARED_MEMORY"  (memory $memory 1 1 shared))
    (import "memory" "malloc"       (func $malloc (param $length i32) (result i32)))
    (import "nil" "array"           (global $nil/array externref))

    (global $self.indexedDB (mut externref) ref.null extern)

    (global $self.IDBFactory (mut externref) ref.null extern)
    (global $self.IDBFactory:cmp (mut externref) ref.null extern)
    (global $self.IDBFactory:databases (mut externref) ref.null extern)
    (global $self.IDBFactory:deleteDatabase (mut externref) ref.null extern)
    
    (global $self.Event:type/get (mut externref) ref.null extern)

    (global $self.IDBRequest (mut externref) ref.null extern)
    (global $self.IDBRequest:readyState/get (mut externref) ref.null extern)

    (global $self.IDBRequest:onerror/get (mut externref) ref.null extern)
    (global $self.IDBRequest:onerror/set (mut externref) ref.null extern)
    (global $self.IDBRequest:onsuccess/get (mut externref) ref.null extern)
    (global $self.IDBRequest:onsuccess/set (mut externref) ref.null extern)

    (global $self.IDBOpenDBRequest (mut externref) ref.null extern)
    (global $self.IDBOpenDBRequest:onblocked/get (mut externref) ref.null extern)
    (global $self.IDBOpenDBRequest:onblocked/set (mut externref) ref.null extern)
    (global $self.IDBOpenDBRequest:onupgradeneeded/get (mut externref) ref.null extern)
    (global $self.IDBOpenDBRequest:onupgradeneeded/set (mut externref) ref.null extern)


    (global $self.IDBDatabase (mut externref) ref.null extern)
    (global $self.IDBDatabase:close (mut externref) ref.null extern)
    (global $self.IDBDatabase:createObjectStore (mut externref) ref.null extern)
    (global $self.IDBDatabase:deleteObjectStore (mut externref) ref.null extern)
    (global $self.IDBDatabase:transaction (mut externref) ref.null extern)
    (global $self.IDBDatabase:name/get (mut externref) ref.null extern)
    (global $self.IDBDatabase:version/get (mut externref) ref.null extern)
    (global $self.IDBDatabase:objectStoreNames/get (mut externref) ref.null extern)

    (global $self.IDBDatabase:onversionchange/get (mut externref) ref.null extern)
    (global $self.IDBDatabase:onversionchange/set (mut externref) ref.null extern)
    (global $self.IDBDatabase:onerror/get (mut externref) ref.null extern)
    (global $self.IDBDatabase:onerror/set (mut externref) ref.null extern)
    (global $self.IDBDatabase:onclose/get (mut externref) ref.null extern)
    (global $self.IDBDatabase:onclose/set (mut externref) ref.null extern)
    (global $self.IDBDatabase:onabort/get (mut externref) ref.null extern)
    (global $self.IDBDatabase:onabort/set (mut externref) ref.null extern)

    (global $self.IDBTransaction (mut externref) ref.null extern)
    (global $self.IDBTransaction:abort (mut externref) ref.null extern)
    (global $self.IDBTransaction:commit (mut externref) ref.null extern)
    (global $self.IDBTransaction:objectStore (mut externref) ref.null extern)
    (global $self.IDBTransaction:db/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:mode/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:objectStoreNames/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:durability/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:error/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:onabort/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:onabort/set (mut externref) ref.null extern)
    (global $self.IDBTransaction:oncomplete/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:oncomplete/set (mut externref) ref.null extern)
    (global $self.IDBTransaction:onerror/get (mut externref) ref.null extern)
    (global $self.IDBTransaction:onerror/set (mut externref) ref.null extern)

    (global $idbName (mut externref) ref.null extern)

    (func $Event:target<ref>ref
        (param $event externref)
        (result (; String ;) externref) 
        (call $self.Reflect.apply<refx3>ref 
            (global.get $self.Event:target/get) (local.get 0) (call $self.Array.of<>ref))
    )

    (func $IDBRequest:result<ref>ref
        (param $idbRequest externref)
        (result (; IDBDatabase ;) externref) 
        (call $self.Reflect.apply<refx3>ref 
            (global.get $self.IDBRequest:result/get) (local.get 0) (call $self.Array.of<>ref))
    )

    (func $IDBRequest:error<ref>ref
        (param $idbRequest externref)
        (result (; DOMException ;) externref) 
        (call $self.Reflect.apply<refx3>ref 
            (global.get $self.IDBRequest:error/get) (local.get 0) (call $self.Array.of<>ref))
    )

    (func $IDBRequest:source<ref>ref
        (param $idbRequest externref)
        (result (; IDBIndex, IDBObjectStore or IDBCursor ;) externref) 
        (call $self.Reflect.apply<refx3>ref 
            (global.get $self.IDBRequest:source/get) (local.get 0) (call $self.Array.of<>ref))
    )

    (func $IDBRequest:transaction<ref>ref
        (param $idbRequest externref)
        (result (; IDBTransaction ;) externref) 
        (call $self.Reflect.apply<refx3>ref 
            (global.get $self.IDBRequest:transaction/get) (local.get 0))
    )

    (func $IDBOpenDBRequest:error<ref>ref
        (param $idbOpenDBRequest externref)
        (result (; DOMException ;) externref) 
        (call $IDBRequest:error<ref>ref (local.get 0))
    )

    (func $IDBOpenDBRequest:result<ref>ref
        (param $idbOpenDBRequest externref)
        (result (; IDBDatabase ;) externref) 
        (call $IDBRequest:result<ref>ref (local.get 0))
    )

    (func $IDBFactory:open<ref>ref
        (param $name externref)
        (result (; IDBOpenDBRequest ;) externref) 

        (call $self.Reflect.apply<refx3>ref 
            (global.get $self.IDBFactory:open)
            (global.get $self.indexedDB)
            (call $self.Array.of<ref>ref (local.get $name))
        )
    )

    (func $IDBOpenDBRequest:onsuccess<ref.fun>
        (param $idbOpenDBRequest externref)
        (param $callback funcref)

        (call $self.Reflect.apply<refx3> 
            (global.get $self.EventTarget:addEventListener)
            (local.get 0) (call $self.Array.of<ref.fun>ref (table.get $extern (i32.const 11)) (local.get $callback))
        )        
    )

    (func $IDBOpenDBRequest:onerror<ref.fun>
        (param $idbOpenDBRequest externref)
        (param $callback funcref)

        (call $self.Reflect.apply<refx3> 
            (global.get $self.EventTarget:addEventListener)
            (local.get 0) (call $self.Array.of<ref.fun>ref (table.get $extern (i32.const 12)) (local.get $callback))
        )
    )

    (func $IDBOpenDBRequest:onupgradeneeded<ref.fun>
        (param $idbOpenDBRequest externref)
        (param $callback funcref)

        (call $self.Reflect.apply<refx3> 
            (global.get $self.EventTarget:addEventListener)
            (local.get 0) (call $self.Array.of<ref.fun>ref (table.get $extern (i32.const 13)) (local.get $callback))
        )
    )

    
    (func $IDBOpenDBRequest:onblocked<ref.fun>
        (param $idbOpenDBRequest externref)
        (param $callback funcref)

        (call $self.Reflect.apply<refx3> 
            (global.get $self.EventTarget:addEventListener)
            (local.get 0) (call $self.Array.of<ref.fun>ref (table.get $extern (i32.const 14)) (local.get $callback))
        )
    )

    (func $IDBRequest:onerror<ref.fun>
        (param $idbRequest externref)
        (param $callback funcref)

        (call $self.Reflect.apply<refx3> 
            (global.get $self.EventTarget:addEventListener)
            (local.get 0) (call $self.Array.of<ref.fun>ref (table.get $extern (i32.const 12)) (local.get $callback))
        )
    )

    (func $IDBRequest:onsuccess<ref.fun>
        (param $idbRequest externref)
        (param $callback funcref)

        (call $self.Reflect.apply<refx3> 
            (global.get $self.EventTarget:addEventListener)
            (local.get 0) (call $self.Array.of<ref.fun>ref (table.get $extern (i32.const 11)) (local.get $callback))
        )
    )

    (start $main) (func $main
(table.set $extern (i32.const 1) (call $wat4wasm/text (i32.const 0) (i32.const 48)))
		(table.set $extern (i32.const 2) (call $wat4wasm/text (i32.const 48) (i32.const 36)))
		(table.set $extern (i32.const 3) (call $wat4wasm/text (i32.const 84) (i32.const 16)))
		(table.set $extern (i32.const 4) (call $wat4wasm/text (i32.const 100) (i32.const 12)))
		(table.set $extern (i32.const 5) (call $wat4wasm/text (i32.const 112) (i32.const 28)))
		(table.set $extern (i32.const 6) (call $wat4wasm/text (i32.const 140) (i32.const 48)))
		(table.set $extern (i32.const 7) (call $wat4wasm/text (i32.const 188) (i32.const 52)))
		(table.set $extern (i32.const 8) (call $wat4wasm/text (i32.const 240) (i32.const 40)))
		(table.set $extern (i32.const 9) (call $wat4wasm/text (i32.const 280) (i32.const 44)))
		(table.set $extern (i32.const 10) (call $wat4wasm/text (i32.const 324) (i32.const 40)))
		(table.set $extern (i32.const 11) (call $wat4wasm/text (i32.const 364) (i32.const 28)))
		(table.set $extern (i32.const 12) (call $wat4wasm/text (i32.const 392) (i32.const 20)))
		(table.set $extern (i32.const 13) (call $wat4wasm/text (i32.const 412) (i32.const 52)))
		(table.set $extern (i32.const 14) (call $wat4wasm/text (i32.const 464) (i32.const 28)))
		(table.set $extern (i32.const 15) (call $wat4wasm/text (i32.const 492) (i32.const 60)))
		(table.set $extern (i32.const 16) (call $wat4wasm/text (i32.const 552) (i32.const 56)))
		(table.set $extern (i32.const 17) (call $wat4wasm/text (i32.const 608) (i32.const 76)))
		(table.set $extern (i32.const 18) (call $wat4wasm/text (i32.const 684) (i32.const 36)))
		(table.set $extern (i32.const 19) (call $wat4wasm/text (i32.const 720) (i32.const 40)))
		(table.set $extern (i32.const 20) (call $wat4wasm/text (i32.const 760) (i32.const 12)))
		(table.set $extern (i32.const 21) (call $wat4wasm/text (i32.const 772) (i32.const 36)))
		(table.set $extern (i32.const 22) (call $wat4wasm/text (i32.const 808) (i32.const 56)))
		(table.set $extern (i32.const 23) (call $wat4wasm/text (i32.const 864) (i32.const 20)))
		(table.set $extern (i32.const 24) (call $wat4wasm/text (i32.const 884) (i32.const 16)))
		(table.set $extern (i32.const 25) (call $wat4wasm/text (i32.const 900) (i32.const 40)))
		(table.set $extern (i32.const 26) (call $wat4wasm/text (i32.const 940) (i32.const 40)))
		(table.set $extern (i32.const 27) (call $wat4wasm/text (i32.const 980) (i32.const 28)))
		(table.set $extern (i32.const 28) (call $wat4wasm/text (i32.const 1008) (i32.const 12)))
		(table.set $extern (i32.const 29) (call $wat4wasm/text (i32.const 1020) (i32.const 36)))
		(table.set $extern (i32.const 30) (call $wat4wasm/text (i32.const 1056) (i32.const 64)))
		(table.set $extern (i32.const 31) (call $wat4wasm/text (i32.const 1120) (i32.const 36)))
		(table.set $extern (i32.const 32) (call $wat4wasm/text (i32.const 1156) (i32.const 60)))
		(table.set $extern (i32.const 33) (call $wat4wasm/text (i32.const 1216) (i32.const 44)))
		(table.set $extern (i32.const 34) (call $wat4wasm/text (i32.const 1260) (i32.const 20)))
		(table.set $extern (i32.const 35) (call $wat4wasm/text (i32.const 1280) (i32.const 68)))
		(table.set $extern (i32.const 36) (call $wat4wasm/text (i32.const 1348) (i32.const 68)))
		(table.set $extern (i32.const 37) (call $wat4wasm/text (i32.const 1416) (i32.const 44)))
		(table.set $extern (i32.const 38) (call $wat4wasm/text (i32.const 1460) (i32.const 16)))
		(table.set $extern (i32.const 39) (call $wat4wasm/text (i32.const 1476) (i32.const 28)))
		(table.set $extern (i32.const 40) (call $wat4wasm/text (i32.const 1504) (i32.const 64)))
		(table.set $extern (i32.const 41) (call $wat4wasm/text (i32.const 1568) (i32.const 60)))
		(table.set $extern (i32.const 42) (call $wat4wasm/text (i32.const 1628) (i32.const 28)))
		(table.set $extern (i32.const 43) (call $wat4wasm/text (i32.const 1656) (i32.const 28)))
		(table.set $extern (i32.const 44) (call $wat4wasm/text (i32.const 1684) (i32.const 56)))
		(table.set $extern (i32.const 45) (call $wat4wasm/text (i32.const 1740) (i32.const 20)))
		(table.set $extern (i32.const 46) (call $wat4wasm/text (i32.const 1760) (i32.const 24)))
		(table.set $extern (i32.const 47) (call $wat4wasm/text (i32.const 1784) (i32.const 44)))
		(table.set $extern (i32.const 48) (call $wat4wasm/text (i32.const 1828) (i32.const 8)))
		(table.set $extern (i32.const 49) (call $wat4wasm/text (i32.const 1836) (i32.const 16)))
		(table.set $extern (i32.const 50) (call $wat4wasm/text (i32.const 1852) (i32.const 40)))
		(table.set $extern (i32.const 51) (call $wat4wasm/text (i32.const 1892) (i32.const 40)))
		(table.set $extern (i32.const 52) (call $wat4wasm/text (i32.const 1932) (i32.const 24)))
		(table.set $extern (i32.const 53) (call $wat4wasm/text (i32.const 1956) (i32.const 24)))
		(table.set $extern (i32.const 54) (call $wat4wasm/text (i32.const 1980) (i32.const 24)))
		(table.set $extern (i32.const 55) (call $wat4wasm/text (i32.const 2004) (i32.const 16)))
		(table.set $extern (i32.const 56) (call $wat4wasm/text (i32.const 2020) (i32.const 44)))
		(table.set $extern (i32.const 57) (call $wat4wasm/text (i32.const 2064) (i32.const 64)))
		(table.set $extern (i32.const 58) (call $wat4wasm/text (i32.const 2128) (i32.const 12)))


        (memory.fill (i32.const 0) (i32.const 0) (i32.const 2140))
        

(global.set $idbName (table.get $extern (i32.const 58)))


        (global.set $self.indexedDB
            (call $wat4wasm/Reflect.get<refx2>ref
                (global.get $wat4wasm/self)
                (table.get $extern (i32.const 18)) 
            )
        )
        
        (global.set $self.IDBFactory
            (call $wat4wasm/Reflect.get<refx2>ref
                (global.get $wat4wasm/self)
                (table.get $extern (i32.const 19)) 
            )
        )
        
        (global.set $self.IDBFactory:cmp
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 19)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 20)) 
            )
        )
        
        (global.set $self.IDBFactory:databases
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 19)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 21)) 
            )
        )
        
        (global.set $self.IDBFactory:deleteDatabase
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 19)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 22)) 
            )
        )
        
        (global.set $self.Event:type/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 23)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 24)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest
            (call $wat4wasm/Reflect.get<refx2>ref
                (global.get $wat4wasm/self)
                (table.get $extern (i32.const 25)) 
            )
        )
        
        (global.set $self.IDBRequest:readyState/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 26)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest:onerror/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 27)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest:onerror/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 27)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBRequest:onsuccess/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 29)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest:onsuccess/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 29)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBOpenDBRequest
            (call $wat4wasm/Reflect.get<refx2>ref
                (global.get $wat4wasm/self)
                (table.get $extern (i32.const 30)) 
            )
        )
        
        (global.set $self.IDBOpenDBRequest:onblocked/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 30)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 31)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBOpenDBRequest:onblocked/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 30)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 31)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBOpenDBRequest:onupgradeneeded/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 30)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 32)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBOpenDBRequest:onupgradeneeded/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 30)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 32)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBDatabase
            (call $wat4wasm/Reflect.get<refx2>ref
                (global.get $wat4wasm/self)
                (table.get $extern (i32.const 33)) 
            )
        )
        
        (global.set $self.IDBDatabase:close
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 34)) 
            )
        )
        
        (global.set $self.IDBDatabase:createObjectStore
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 35)) 
            )
        )
        
        (global.set $self.IDBDatabase:deleteObjectStore
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 36)) 
            )
        )
        
        (global.set $self.IDBDatabase:transaction
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 37)) 
            )
        )
        
        (global.set $self.IDBDatabase:name/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 38)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBDatabase:version/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 39)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBDatabase:objectStoreNames/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 40)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBDatabase:onversionchange/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 41)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBDatabase:onversionchange/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 41)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBDatabase:onerror/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 27)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBDatabase:onerror/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 27)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBDatabase:onclose/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 42)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBDatabase:onclose/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 42)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBDatabase:onabort/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 43)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBDatabase:onabort/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 33)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 43)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBTransaction
            (call $wat4wasm/Reflect.get<refx2>ref
                (global.get $wat4wasm/self)
                (table.get $extern (i32.const 44)) 
            )
        )
        
        (global.set $self.IDBTransaction:abort
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 45)) 
            )
        )
        
        (global.set $self.IDBTransaction:commit
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 46)) 
            )
        )
        
        (global.set $self.IDBTransaction:objectStore
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 47)) 
            )
        )
        
        (global.set $self.IDBTransaction:db/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 48)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:mode/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 49)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:objectStoreNames/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 40)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:durability/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 50)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:error/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 12)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:onabort/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 43)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:onabort/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 43)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBTransaction:oncomplete/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 51)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:oncomplete/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 51)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.IDBTransaction:onerror/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 27)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBTransaction:onerror/set
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 44)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 27)) 
                )
                (table.get $extern (i32.const 28)) 
            )
        )
        
        (global.set $self.MessageEvent.prototype.data/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 1)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 3)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.Event:target/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 23)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 52)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest:result/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 53)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest:error/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 12)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest:source/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 54)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBRequest:transaction/get
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 25)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                    (table.get $extern (i32.const 37)) 
                )
                (table.get $extern (i32.const 4)) 
            )
        )
        
        (global.set $self.IDBFactory:open
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 19)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 55)) 
            )
        )
        
        (global.set $self.EventTarget:addEventListener
            (call $wat4wasm/Reflect.get<refx2>ref
                (call $wat4wasm/Reflect.get<refx2>ref 
                            (call $wat4wasm/Reflect.get<refx2>ref 
                                (global.get $wat4wasm/self) 
                                (table.get $extern (i32.const 56)) 
                            ) 
                            (table.get $extern (i32.const 2)) 
                        )
                (table.get $extern (i32.const 57)) 
            )
        )
        
 
        (call $self.console.log<ref> (table.get $extern (i32.const 15)))        

        (call $indexedDB.open<ref> 
            (global.get $idbName)
        )
    )

    (func $indexedDB.open<ref>
        (param $name externref)
        (local $idbOpenDBRequest externref)

        (local.set $idbOpenDBRequest
            (call $IDBFactory:open<ref>ref  
                (local.get $name)
            )
        )

        (call $listenIDBOpenRequest<ref> 
            (local.get $idbOpenDBRequest)
        )

        (call $self.console.warn<ref> (local.get $idbOpenDBRequest))
    )

    (func $listenIDBOpenRequest<ref>
        (param $idbOpenDBRequest externref)

        (call $IDBOpenDBRequest:onsuccess<ref.fun> 
            (local.get $idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onsuccess<ref>)
        )

        (call $IDBOpenDBRequest:onupgradeneeded<ref.fun> 
            (local.get $idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onupgradeneeded<ref>)
        )

        (call $IDBOpenDBRequest:onblocked<ref.fun> 
            (local.get $idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onblocked<ref>)
        )

        (call $IDBOpenDBRequest:onerror<ref.fun> 
            (local.get $idbOpenDBRequest) 
            (ref.func $idbOpenDBRequest.onerror<ref>)
        )
    )

    (func $idbOpenDBRequest.onsuccess<ref>
        (param $event externref)
        (local $idbOpenDBRequest externref)
        (local $idbDatabase externref)

        (call $self.console.log<ref> (local.get 0))

        (local.set $idbOpenDBRequest
            (call $Event:target<ref>ref  (local.get 0) )
        )

        (local.set $idbDatabase
            (call $IDBOpenDBRequest:result<ref>ref  
                (local.get $idbOpenDBRequest)
            )
        )

        (call $self.console.log<ref> 
            (call $Event:target<ref>ref  (local.get 0) ) 
        )
    )   

    (func $idbOpenDBRequest.onerror<ref>
        (param $event externref)
        (call $self.console.error<ref> (local.get 0))
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
        (param $idbVersionChangeEvent externref)
        (call $self.console.warn<refx2> (local.get 0) (table.get $extern (i32.const 16)))
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
        (param $idbVersionChangeEvent externref)
        (call $self.console.error<refx2> (local.get 0) (table.get $extern (i32.const 17)))
    )   


	(global $self.MessageEvent.prototype.data/get (mut externref) ref.null extern)



	(global $self.Event:target/get (mut externref) ref.null extern)
	(global $self.IDBRequest:result/get (mut externref) ref.null extern)
	(global $self.IDBRequest:error/get (mut externref) ref.null extern)
	(global $self.IDBRequest:source/get (mut externref) ref.null extern)
	(global $self.IDBRequest:transaction/get (mut externref) ref.null extern)
	(global $self.IDBFactory:open (mut externref) ref.null extern)
	(global $self.EventTarget:addEventListener (mut externref) ref.null extern)

	(elem $wat4wasm/refs funcref (ref.func $idbOpenDBRequest.onsuccess<ref>) (ref.func $idbOpenDBRequest.onupgradeneeded<ref>) (ref.func $idbOpenDBRequest.onblocked<ref>) (ref.func $idbOpenDBRequest.onerror<ref>))

    (table $extern 59 59 externref)

    (func $wat4wasm/text 
        (param $offset i32)
        (param $length i32)
        (result externref)
        (local $array externref)

        (if (i32.eqz (local.get $length))
            (then (return (ref.null extern)))
        )

        (local.set $array 
            (call $wat4wasm/Array<>ref)
        )

        (loop $length--
            (local.set $length
                (i32.sub (local.get $length) (i32.const 4))
            )
                
            (call $wat4wasm/Reflect.set<ref.i32x2>
                (local.get $array)
                (i32.div_u (local.get $length) (i32.const 4))
                (i32.trunc_f32_u	
                    (f32.load 
                        (i32.add 
                            (local.get $offset)
                            (local.get $length)
                        )
                    )
                )
            )

            (br_if $length-- (local.get $length))
        )

        (call $wat4wasm/Reflect.apply<refx3>ref
            (global.get $wat4wasm/String.fromCharCode)
            (ref.null extern)
            (local.get $array)
        )
    )

    (data (i32.const 0) "\00\00\9a\42\00\00\ca\42\00\00\e6\42\00\00\e6\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\8a\42\00\00\ec\42\00\00\ca\42\00\00\dc\42\00\00\e8\42\00\00\e0\42\00\00\e4\42\00\00\de\42\00\00\e8\42\00\00\de\42\00\00\e8\42\00\00\f2\42\00\00\e0\42\00\00\ca\42\00\00\c8\42\00\00\c2\42\00\00\e8\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\e8\42\00\00\e8\42\00\00\d2\42\00\00\da\42\00\00\ca\42\00\00\de\42\00\00\ea\42\00\00\e8\42\00\00\92\42\00\00\c8\42\00\00\d8\42\00\00\ca\42\00\00\88\42\00\00\ca\42\00\00\c2\42\00\00\c8\42\00\00\d8\42\00\00\d2\42\00\00\dc\42\00\00\ca\42\00\00\e8\42\00\00\d2\42\00\00\da\42\00\00\ca\42\00\00\a4\42\00\00\ca\42\00\00\da\42\00\00\c2\42\00\00\d2\42\00\00\dc\42\00\00\d2\42\00\00\dc\42\00\00\ce\42\00\00\c8\42\00\00\d2\42\00\00\c8\42\00\00\a8\42\00\00\d2\42\00\00\da\42\00\00\ca\42\00\00\de\42\00\00\ea\42\00\00\e8\42\00\00\e0\42\00\00\ca\42\00\00\e4\42\00\00\cc\42\00\00\de\42\00\00\e4\42\00\00\da\42\00\00\c2\42\00\00\dc\42\00\00\c6\42\00\00\ca\42\00\00\e8\42\00\00\d2\42\00\00\da\42\00\00\ca\42\00\00\9e\42\00\00\e4\42\00\00\d2\42\00\00\ce\42\00\00\d2\42\00\00\dc\42\00\00\e6\42\00\00\ea\42\00\00\c6\42\00\00\c6\42\00\00\ca\42\00\00\e6\42\00\00\e6\42\00\00\ca\42\00\00\e4\42\00\00\e4\42\00\00\de\42\00\00\e4\42\00\00\ea\42\00\00\e0\42\00\00\ce\42\00\00\e4\42\00\00\c2\42\00\00\c8\42\00\00\ca\42\00\00\dc\42\00\00\ca\42\00\00\ca\42\00\00\c8\42\00\00\ca\42\00\00\c8\42\00\00\c4\42\00\00\d8\42\00\00\de\42\00\00\c6\42\00\00\d6\42\00\00\ca\42\00\00\c8\42\00\00\d0\42\00\00\d2\42\00\00\00\42\00\00\cc\42\00\00\e4\42\00\00\de\42\00\00\da\42\00\00\00\42\00\00\e6\42\00\00\e8\42\00\00\de\42\00\00\e4\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\ea\42\00\00\e0\42\00\00\ce\42\00\00\e4\42\00\00\c2\42\00\00\c8\42\00\00\ca\42\00\00\00\42\00\00\dc\42\00\00\ca\42\00\00\ca\42\00\00\c8\42\00\00\ca\42\00\00\c8\42\00\00\a4\42\00\00\ca\42\00\00\e2\42\00\00\ea\42\00\00\ca\42\00\00\e6\42\00\00\e8\42\00\00\00\42\00\00\ee\42\00\00\c2\42\00\00\e6\42\00\00\00\42\00\00\c4\42\00\00\d8\42\00\00\de\42\00\00\c6\42\00\00\d6\42\00\00\ca\42\00\00\c8\42\00\00\d2\42\00\00\dc\42\00\00\c8\42\00\00\ca\42\00\00\f0\42\00\00\ca\42\00\00\c8\42\00\00\88\42\00\00\84\42\00\00\92\42\00\00\88\42\00\00\84\42\00\00\8c\42\00\00\c2\42\00\00\c6\42\00\00\e8\42\00\00\de\42\00\00\e4\42\00\00\f2\42\00\00\c6\42\00\00\da\42\00\00\e0\42\00\00\c8\42\00\00\c2\42\00\00\e8\42\00\00\c2\42\00\00\c4\42\00\00\c2\42\00\00\e6\42\00\00\ca\42\00\00\e6\42\00\00\c8\42\00\00\ca\42\00\00\d8\42\00\00\ca\42\00\00\e8\42\00\00\ca\42\00\00\88\42\00\00\c2\42\00\00\e8\42\00\00\c2\42\00\00\c4\42\00\00\c2\42\00\00\e6\42\00\00\ca\42\00\00\8a\42\00\00\ec\42\00\00\ca\42\00\00\dc\42\00\00\e8\42\00\00\e8\42\00\00\f2\42\00\00\e0\42\00\00\ca\42\00\00\92\42\00\00\88\42\00\00\84\42\00\00\a4\42\00\00\ca\42\00\00\e2\42\00\00\ea\42\00\00\ca\42\00\00\e6\42\00\00\e8\42\00\00\e4\42\00\00\ca\42\00\00\c2\42\00\00\c8\42\00\00\f2\42\00\00\a6\42\00\00\e8\42\00\00\c2\42\00\00\e8\42\00\00\ca\42\00\00\de\42\00\00\dc\42\00\00\ca\42\00\00\e4\42\00\00\e4\42\00\00\de\42\00\00\e4\42\00\00\e6\42\00\00\ca\42\00\00\e8\42\00\00\de\42\00\00\dc\42\00\00\e6\42\00\00\ea\42\00\00\c6\42\00\00\c6\42\00\00\ca\42\00\00\e6\42\00\00\e6\42\00\00\92\42\00\00\88\42\00\00\84\42\00\00\9e\42\00\00\e0\42\00\00\ca\42\00\00\dc\42\00\00\88\42\00\00\84\42\00\00\a4\42\00\00\ca\42\00\00\e2\42\00\00\ea\42\00\00\ca\42\00\00\e6\42\00\00\e8\42\00\00\de\42\00\00\dc\42\00\00\c4\42\00\00\d8\42\00\00\de\42\00\00\c6\42\00\00\d6\42\00\00\ca\42\00\00\c8\42\00\00\de\42\00\00\dc\42\00\00\ea\42\00\00\e0\42\00\00\ce\42\00\00\e4\42\00\00\c2\42\00\00\c8\42\00\00\ca\42\00\00\dc\42\00\00\ca\42\00\00\ca\42\00\00\c8\42\00\00\ca\42\00\00\c8\42\00\00\92\42\00\00\88\42\00\00\84\42\00\00\88\42\00\00\c2\42\00\00\e8\42\00\00\c2\42\00\00\c4\42\00\00\c2\42\00\00\e6\42\00\00\ca\42\00\00\c6\42\00\00\d8\42\00\00\de\42\00\00\e6\42\00\00\ca\42\00\00\c6\42\00\00\e4\42\00\00\ca\42\00\00\c2\42\00\00\e8\42\00\00\ca\42\00\00\9e\42\00\00\c4\42\00\00\d4\42\00\00\ca\42\00\00\c6\42\00\00\e8\42\00\00\a6\42\00\00\e8\42\00\00\de\42\00\00\e4\42\00\00\ca\42\00\00\c8\42\00\00\ca\42\00\00\d8\42\00\00\ca\42\00\00\e8\42\00\00\ca\42\00\00\9e\42\00\00\c4\42\00\00\d4\42\00\00\ca\42\00\00\c6\42\00\00\e8\42\00\00\a6\42\00\00\e8\42\00\00\de\42\00\00\e4\42\00\00\ca\42\00\00\e8\42\00\00\e4\42\00\00\c2\42\00\00\dc\42\00\00\e6\42\00\00\c2\42\00\00\c6\42\00\00\e8\42\00\00\d2\42\00\00\de\42\00\00\dc\42\00\00\dc\42\00\00\c2\42\00\00\da\42\00\00\ca\42\00\00\ec\42\00\00\ca\42\00\00\e4\42\00\00\e6\42\00\00\d2\42\00\00\de\42\00\00\dc\42\00\00\de\42\00\00\c4\42\00\00\d4\42\00\00\ca\42\00\00\c6\42\00\00\e8\42\00\00\a6\42\00\00\e8\42\00\00\de\42\00\00\e4\42\00\00\ca\42\00\00\9c\42\00\00\c2\42\00\00\da\42\00\00\ca\42\00\00\e6\42\00\00\de\42\00\00\dc\42\00\00\ec\42\00\00\ca\42\00\00\e4\42\00\00\e6\42\00\00\d2\42\00\00\de\42\00\00\dc\42\00\00\c6\42\00\00\d0\42\00\00\c2\42\00\00\dc\42\00\00\ce\42\00\00\ca\42\00\00\de\42\00\00\dc\42\00\00\c6\42\00\00\d8\42\00\00\de\42\00\00\e6\42\00\00\ca\42\00\00\de\42\00\00\dc\42\00\00\c2\42\00\00\c4\42\00\00\de\42\00\00\e4\42\00\00\e8\42\00\00\92\42\00\00\88\42\00\00\84\42\00\00\a8\42\00\00\e4\42\00\00\c2\42\00\00\dc\42\00\00\e6\42\00\00\c2\42\00\00\c6\42\00\00\e8\42\00\00\d2\42\00\00\de\42\00\00\dc\42\00\00\c2\42\00\00\c4\42\00\00\de\42\00\00\e4\42\00\00\e8\42\00\00\c6\42\00\00\de\42\00\00\da\42\00\00\da\42\00\00\d2\42\00\00\e8\42\00\00\de\42\00\00\c4\42\00\00\d4\42\00\00\ca\42\00\00\c6\42\00\00\e8\42\00\00\a6\42\00\00\e8\42\00\00\de\42\00\00\e4\42\00\00\ca\42\00\00\c8\42\00\00\c4\42\00\00\da\42\00\00\de\42\00\00\c8\42\00\00\ca\42\00\00\c8\42\00\00\ea\42\00\00\e4\42\00\00\c2\42\00\00\c4\42\00\00\d2\42\00\00\d8\42\00\00\d2\42\00\00\e8\42\00\00\f2\42\00\00\de\42\00\00\dc\42\00\00\c6\42\00\00\de\42\00\00\da\42\00\00\e0\42\00\00\d8\42\00\00\ca\42\00\00\e8\42\00\00\ca\42\00\00\e8\42\00\00\c2\42\00\00\e4\42\00\00\ce\42\00\00\ca\42\00\00\e8\42\00\00\e4\42\00\00\ca\42\00\00\e6\42\00\00\ea\42\00\00\d8\42\00\00\e8\42\00\00\e6\42\00\00\de\42\00\00\ea\42\00\00\e4\42\00\00\c6\42\00\00\ca\42\00\00\de\42\00\00\e0\42\00\00\ca\42\00\00\dc\42\00\00\8a\42\00\00\ec\42\00\00\ca\42\00\00\dc\42\00\00\e8\42\00\00\a8\42\00\00\c2\42\00\00\e4\42\00\00\ce\42\00\00\ca\42\00\00\e8\42\00\00\c2\42\00\00\c8\42\00\00\c8\42\00\00\8a\42\00\00\ec\42\00\00\ca\42\00\00\dc\42\00\00\e8\42\00\00\98\42\00\00\d2\42\00\00\e6\42\00\00\e8\42\00\00\ca\42\00\00\dc\42\00\00\ca\42\00\00\e4\42\00\00\ee\42\00\00\cc\42\00\00\e6\42")
)