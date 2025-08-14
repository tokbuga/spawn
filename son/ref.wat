(module 
    (import "self" "memory"     (memory $memory 10 10 shared))
    (import "self" "memory"     (global $memory externref))
    (import "memory" "buffer"   (global $buffer externref))

    (alias $ref $ref<ref>i32)
    (alias $ref.count $ref.count<>i32)
    (alias $ref.rows $ref.rows<>ref)
    (alias $deref $deref<i32>ref)
    (alias $malloc $malloc<i32>i32)

    (include "self/Array.wat")
    (include "self/Object.wat")
    (include "self/WeakMap.wat")
    (include "self/WeakRef.wat")
    (include "self/Math.wat")
    (include "self/Crypto.wat")
    (include "self/RegExp.wat")
    (include "self/String.wat")
    (include "self/Number.wat")
    (include "self/TypedArray.wat")
    (include "self/Event.wat")
    (include "self/MessageEvent.wat")
    (include "self/Buffer.wat")
    (include "self/DataView.wat")
    (include "self/ArrayBuffer.wat")
    (include "self/WebSocket.wat")
    (include "self/Window.wat")
    (include "self/CustomEvent.wat")
    (include "self/MouseEvent.wat")
    (include "self/UIEvent.wat")
    (include "self/EventTarget.wat")
    (include "self/DragEvent.wat")
    (include "self/DataTransfer.wat")
    (include "self/DataTransferItem.wat")
    (include "self/DataTransferItemList.wat")
    (include "self/IDB.wat")
    (include "self/File.wat")

    (include "wasm/Window.wat")

    (include "core/wasm.wat")
    (include "core/self.wat")
    (include "core/console.wat")
    (include "core/uuid.wat")
    (include "core/drop.wat")

    (global $weak<Map> new WeakMap)
    (global $view<Memory> mut extern)



    (table $ref 1 65536 externref)

    (global $ref.DB_HEADER_OFFSET (mut i32) i32(0))
    (global $ref.DB_HEADER_LENGTH i32 i32(16))

    (global $ref.DB_OFFSET (mut i32) i32(0))
    (global $ref.MAX_ROW_COUNT  i32  i32(4))
    (global $ref.BYTES_PER_ROW i32  i32(38))

    (global $ref.OFFSET_ID    i32  i32(0))
    (global $ref.LENGTH_ID    i32  i32(4))

    (global $ref.OFFSET_UUID    i32  i32(4))
    (global $ref.LENGTH_UUID    i32  i32(16))

    (global $ref.OFFSET_PARENT_UUID    i32  i32(20))
    (global $ref.LENGTH_PARENT_UUID    i32  i32(16))
    
    (global $ref.OFFSET_TABLE_INDEX    i32  i32(36))
    (global $ref.LENGTH_TABLE_INDEX    i32  i32(2))


    (global $ws mut extern)

    (global $self.name ref)
    (global $deviceUuid (mut v128) (v128.const i64x2 0 0))

    (start $main
        (warn <ref> text("ref device loaded!"))

        $uploads.open()

        drop($malloc(i32(16)))

        global($deviceUuid
            $fromUuidString<ref>v128( 
                global($self.name)
            )
        )

        global($view<Memory> 
            $Uint8Array:new(
                global($buffer) 
            )
        )


        global($ref.DB_HEADER_OFFSET 
            $malloc(
                (i32.add
                    global($ref.DB_HEADER_LENGTH)
                    (i32.mul
                        global($ref.MAX_ROW_COUNT)
                        global($ref.BYTES_PER_ROW)
                    )
                )
            )
        )

        global($ref.DB_OFFSET 
            (i32.add
                global($ref.DB_HEADER_OFFSET)
                global($ref.DB_HEADER_LENGTH)
            )
        )

        (log<ref> global($buffer))

        $ref.add<ref>v128( global($view<Memory>) );
        $ref.add<ref>v128( self );
        $ref.add<ref>v128( global($buffer) );

        (warn $ref:uuid<i32>ref( i32(2) ) )


        (set <refx3> self text("uuid") $toUuidArray( $ref:uuid<i32>v128( i32(2) ) ))

        (warn $ref:toObject<i32>ref( i32(1) ) )
        (warn <i32> $ref:dbOffset<i32>i32( i32(2) ) )
        (warn $ref.rows() )
        (warn $ref:toBuffer<i32>ref( i32(1) ) )

        $console.table( $ref.rows() )


        $db:new<ref.i32>i32(
            text("eventLoop") i32(128)
        )

        (warn <i32>)

        $ws();



        (; $ps.ALIGN_DB_ALLOCATIONS ;)

        (warn $toUuidString( 

            $db:uuid<i32>v128(
                $db:new<ref.i32>i32(
                    text("secondDB") i32(256)
                )
            )

        ) )

        (warn <refx2> text("deviceUuid:") $toUuidString( global($deviceUuid) ))
    )


    (func $ws (result <WebSocket>)

        (if (null === global($ws))
            (then
                global($ws 
                    $WebSocket:new( text("/sock") )
                )

                $WebSocket:binaryType<refx2>( 
                    global($ws) text("arraybuffer") 
                )

                $WebSocket:onopen<ref.fun>(
                    global($ws) func($ws/onopen<ref>)
                )
                
                $WebSocket:onmessage<ref.fun>(
                    global($ws) func($ws/onmessage<ref>)
                )
            )
        )

        global($ws)
    ) 

    (func $ws/onopen<ref>
        (param $event                   <Event>)
        (warn<refx2> text("ws is open") this)

        $WebSocket:send( 
            global($ws) 
            $ref:toBuffer<i32>ref( i32(1) )
        )

        (warn<refx2> text("buffer sent over ws:") $ref:toBuffer<i32>ref( i32(1) ))

    ) 

    (func $ws/onmessage<ref>
        (param $this             <MessageEvent>)
        (local $data                   <Object>)

        (local #data $MessageEvent:data( this ))

        (if (call $Buffer.isBuffer<ref>i32 local($data) )
            (then $ws/onbuffermessage<ref>( local($data) ))
        )
    ) 

    (func $ws/onbuffermessage<ref>
        (param $buffer <ArrayBuffer>)
        (local $offset i32)
        (warn<refx2> text("ws got buffer message") local($buffer))
        (local #offset $malloc( $ArrayBuffer:byteLength( this ) ))

        (log <i32> local($offset))        
    ) 

    (on $dragover<reF> 
        (param $event <DragEvent>) 
        (call $Event:preventDefault<ref> this)
    )

    (on $drop<reF> 
        (param $this                <DragEvent>) 
        (local $dataTransfer     <DataTransfer>)
        (local $items    <DataTransferItemList>)
        (local $length                      i32)
        (local $item/i       <DataTransferItem>)
        (local $file/i                   <File>)
        
        $Event:preventDefault( this )

        local($dataTransfer                 $DragEvent:dataTransfer( this ))
        local($items            $DataTransfer:items( local($dataTransfer) ))
        local($length         $DataTransferItemList:length( local($items) ))

        (if local($length) 
            (then 
            (loop $length--

                (local #length local($length)--)
                
                (local #item/i     
                    $DataTransferItemList:get( 
                        local($items) 
                        local($length)
                    )
                )

                (local #file/i     
                    $DataTransferItem:getAsFile( 
                        local($item/i)
                    )
                )

                $uploads.store<ref.funx2>(
                    local($file/i) 
                    func($onstoreuploadsuccess<ref>)
                    func($onstoreuploaderror<ref>)
                )

                (br_if $length-- local($length))

            ))
        )
    )

    (on $message<ref>
        (param $this             <MessageEvent>)
        (local $data                   <Object>)

        (local #data $MessageEvent:data( this ))

        (if (call $Buffer.isBuffer<ref>i32 local($data) )
            (then $onbuffermessage<ref>( local($data) ))
        )
    )

    (func $onbuffermessage<ref>
        (param $buffer                  <Buffer>)

        (log this)
    )

    (global $db.OFFSET_UUID      i32 i32(0))
    (global $db.OFFSET_SIZE     i32 i32(16))
    (global $db.OFFSET_USED     i32 i32(20))
    (global $db.OFFSET_FREE     i32 i32(24))
    (global $db.OFFSET_NAME     i32 i32(28))

    (global $db.LENGTH_UUID     i32 i32(16))
    (global $db.LENGTH_SIZE     i32  i32(4))
    (global $db.LENGTH_USED     i32  i32(4))
    (global $db.LENGTH_FREE     i32  i32(4))
    (global $db.LENGTH_NAME     i32 i32(16))
    (global $db.LENGTH          i32 i32(48))

    (func $db:malloc<i32>i32
        (param $db*             i32)
        (param $byteLength      i32)
        (result $offset         i32)

        (i32.atomic.rmw.sub offset=24 local($db*) local($byteLength));
        (i32.atomic.rmw.add offset=20 local($db*) local($byteLength))
    )

    (func $db:new<ref.i32>i32
        (param $name              <string>)
        (param $byteLength             i32)
        (result $db*                   i32)
        (local $db*                    i32)

        (local.set $db* 
            $malloc( 
                (i32.add 
                    global($db.LENGTH) 
                    local($byteLength)
                )
            )
        )

        local($db*)x5

        $db:size<i32.i32>( local($byteLength) )
        $db:used<i32.i32>( i32(0) )
        $db:free<i32.i32>( local($byteLength) )
        $db:name<i32.ref>( local($name) )
        $db:uuid<i32.v128>( $randomUUID() )

        local($db*)
    )

    (func $db:uuid<i32>v128 
        (param $db*             i32)
        (result $uuid          v128)

        (v128.load offset=0 local($db*))
    )

    (func $db:size<i32>i32 
        (param $db*             i32)
        (result $byteLength     i32)

        (i32.atomic.load offset=16 local($db*))
    )

    (func $db:used<i32>i32 
        (param $db*             i32)
        (result $byteLength     i32)

        (i32.atomic.load offset=20 local($db*))
    )

    (func $db:free<i32>i32 
        (param $db*             i32)
        (result $byteLength     i32)

        (i32.atomic.load offset=24 local($db*))
    )

    (func $db:name<i32>ref 
        (param $db*             i32)
        (result $name      <string>)

        null
    )

    (func $db:uuid<i32.v128> 
        (param $db*             i32)
        (param $uuid           v128)

        (v128.store offset=0 local($db*) local($uuid))
    )

    (func $db:size<i32.i32> 
        (param $db*             i32)
        (param $byteLength      i32)

        (i32.atomic.store offset=16 local($db*) local($byteLength))
    )

    (func $db:used<i32.i32> 
        (param $db*             i32)
        (param $byteLength      i32)

        (i32.atomic.store offset=20 local($db*) local($byteLength))
    )

    (func $db:free<i32.i32> 
        (param $db*             i32)
        (param $byteLength      i32)

        (i32.atomic.store offset=24 local($db*) local($byteLength))
    )

    (func $db:name<i32.ref> 
        (param $db*             i32)
        (param $name       <string>)
        
        (local $index           i32)
        (local $charCode        i32)

        (loop $charCodeAt++
            (if (local.tee $charCode 
                    $String:charCodeAt<ref.i32>i32(
                        local($name) local($index)
                    )
                )
                (then
                    (i32.store8 offset=28 
                        (i32.add local($db*) local($index)) 
                        local($charCode)
                    )

                    (br_if $charCodeAt++
                        (i32.ne 
                            global($db.LENGTH_NAME) 
                            (local.tee $index local($index)++)
                        )
                    )
                )
            )
        )
    )


    (func $db:createTable<i32x2>i32
        (param $BYTES_PER_ROW i32)
        (param $MAX_ROW_COUNT i32)
        (result $tbl*         i32)

        $malloc(
            (i32.mul 
                local($BYTES_PER_ROW)
                local($MAX_ROW_COUNT)
            )
        )
    )

    (func $ref.count<>i32
        (result $count i32)
        (i32.load offset=4 global($ref.DB_HEADER_OFFSET))
    )

    (func $ref.rows<>ref
        (result $rows <Array>)
        
        (local $this <Array>)
        (local $count i32)

        (local #this $Array:new<>ref())

        (if (local.tee $count $ref.count())
            (then
                (loop $count--
                    local($count (i32.sub local($count) i32(1)))

                    $Array:unshift<refx2>(
                        this $ref:toObject<i32>ref(
                            local($count)
                        )
                    )

                    (br_if $count-- local($count))
                )
            )
        )

        this
    )

    (func $ref:dbOffset<i32>i32
        (param $id i32)
        (result $offset i32)
        
        (i32.mul global($ref.BYTES_PER_ROW) local($id))
    )

    (func $ref:globalOffset<i32>i32
        (param $id i32)
        (result $offset i32)
        
        (i32.add global($ref.DB_OFFSET) $ref:dbOffset<i32>i32( local($id) ))
    )

    (func $ref:id<>i32
        (result $id i32)
        (i32.atomic.rmw.add offset=4 global($ref.DB_HEADER_OFFSET) i32(1))
    )

    (func $ref:id<i32>i32
        (param $id i32)
        (result $id i32)

        (i32.load offset=0 $ref:globalOffset<i32>i32( local($id) ))
    )

    (func $ref:uuid<i32>v128
        (param $id i32)
        (result $uuid v128)

        (v128.load offset=4 $ref:globalOffset<i32>i32( local($id) ))
    )

    (func $ref:parentUuid<i32>v128
        (param $id i32)
        (result $uuid v128)

        (v128.load offset=20 $ref:globalOffset<i32>i32( local($id) ))
    )

    (func $ref:tableIndex<i32>i32
        (param $id i32)
        (result $index i32)

        (i32.load16_u offset=36 $ref:globalOffset<i32>i32( local($id) ))
    )

    (func $ref:toObject<i32>ref
        (param $id i32)
        (result $json <Object>)
        (local $entries <Object>)

        (local #entries $Array:new<>ref())

        local($entries)x5

        $Array:push<refx2>( $Array.of<ref.i32>ref( text("id") $ref:id<i32>i32( this ) ))
        $Array:push<refx2>( $Array.of<ref.ref>ref( text("uuid") $ref:uuid<i32>ref( this ) ))
        $Array:push<refx2>( $Array.of<ref.ref>ref( text("parentUuid") $ref:parentUuid<i32>ref( this ) ))
        $Array:push<refx2>( $Array.of<ref.i32>ref( text("tableIndex") $ref:tableIndex<i32>i32( this ) ))
        $Array:push<refx2>( $Array.of<ref.ref>ref( text("object") $ref:object<i32>ref( this ) ))

        $Object.fromEntries<ref>ref( 
            local($entries) 
        )
    )

    (func $ref:toBuffer<i32>ref
        (param $id i32)
        (result $buffer <ArrayBuffer>)
        
        $TypedArray:buffer<ref>ref(
            $TypedArray:slice<ref>ref(
                $Uint8Array:new<ref.i32x2>ref(
                    global($buffer)
                    $ref:globalOffset<i32>i32( this ) 
                    global($ref.BYTES_PER_ROW)
                )
            )
        )
    )

    (func $ref:id<i32x2>
        (param $id i32)
        (param $new_id i32)

        (i32.store offset=0 $ref:globalOffset<i32>i32( local($id) ) local($new_id))
    )

    (func $ref:uuid<i32.v128>
        (param $id i32)
        (param $uuid v128)

        (v128.store offset=4 $ref:globalOffset<i32>i32( local($id) ) local($uuid))
    )

    (func $ref:uuid.eq<i32.v128>i32
        (param $id i32)
        (param $uuid v128)
        (result $eq i32)

        (i8x16.all_true (i8x16.eq local($uuid) $ref:uuid<i32>v128( this )))
    )

    (func $ref:parentUuid<i32.v128>
        (param $id i32)
        (param $uuid v128)

        (v128.store offset=20 $ref:globalOffset<i32>i32( local($id) ) local($uuid))
    )

    (func $ref:tableIndex<i32x2>
        (param $id i32)
        (param $index i32)

        (i32.store16 offset=36 $ref:globalOffset<i32>i32( local($id) ) local($index))
    )

    (func $ref:uuid<i32>ref
        (param $id i32)
        (result $uuid <string>)
        (call $toUuidString<v128>ref $ref:uuid<i32>v128( local($id) ) )
    )

    (func $ref:parentUuid<i32>ref
        (param $id i32)
        (result $uuid <string>)
        (call $toUuidString<v128>ref $ref:parentUuid<i32>v128( local($id) ) )
    )

    (func $ref:object<i32>ref
        (param $id i32)
        (result $object ref)
        (call $deref<i32>ref $ref:tableIndex<i32>i32( local($id) ) )
    )

    (func $ref.get
        (param $uuid v128)
        (result ref)
        
        (local $id i32)
        
        local($id $ref.count())

        (if local($id)
            (then
                (loop $count--
                    local($id (i32.sub local($id) i32(1)))

                    (if (call $ref:uuid.eq<i32.v128>i32 local($id) this )
                        (then $ref:object<i32>ref( local($id) ) return)
                    )

                    (br_if $count-- local($id))
                )
            )
        )

        null
    )

    (func $ref.add<ref>v128
        (param $object ref)
        (result $uuid v128)

        (local $id i32)
        (local $uuid v128)
        
        (local #id $ref:id<>i32())
        (local #uuid $randomUUID())

        $ref:id<i32x2>( local($id) local($id) )
        $ref:uuid<i32.v128>( local($id) local($uuid) )
        $ref:tableIndex<i32x2>( local($id) $ref( this ) )

        local($uuid)
    )

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





)
