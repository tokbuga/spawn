    (global $MessageEvent.LENGTH                       i32 i32(44))
    (global $MessageEvent.HDRLEN                       i32 i32(20))

    (memory $MessageEvent:data                          4 4 shared)
    (memory $MessageEvent:lastEventId                   4 4 shared)
    (memory $MessageEvent:origin                        4 4 shared)
    (memory $MessageEvent:ports                         4 4 shared)
    (memory $MessageEvent:source                        4 4 shared)

    (global $MessageEvent.OFFSET_DATA                  i32  i32(0))
    (global $MessageEvent.OFFSET_LAST_EVENT_ID         i32  i32(4))
    (global $MessageEvent.OFFSET_ORIGIN                i32  i32(8))
    (global $MessageEvent.OFFSET_PORTS                 i32 i32(12))
    (global $MessageEvent.OFFSET_SOURCE                i32 i32(16))
    (global $MessageEvent.OFFSET_EVENT                 i32 i32(20))

    (global $MessageEvent.LENGTH_DATA                  i32  i32(4))
    (global $MessageEvent.LENGTH_LAST_EVENT_ID         i32  i32(4))
    (global $MessageEvent.LENGTH_ORIGIN                i32  i32(4))
    (global $MessageEvent.LENGTH_PORTS                 i32  i32(4))
    (global $MessageEvent.LENGTH_SOURCE                i32  i32(4))
    (global $MessageEvent.LENGTH_EVENT                 i32 i32(24))

    (alias $Event:data                  $MessageEvent:data/get<ref>ref)
    (alias $MessageEvent:data           $MessageEvent:data/get<ref>ref)
    (alias $MessageEvent:data<ref>ref   $MessageEvent:data/get<ref>ref)

    (func $MessageEvent.from<ref>i32
        (param $this                        <MessageEvent>)
        (result $offset                                i32)

        (local $offset                                 i32)
        (local #offset 
            $malloc(global($MessageEvent.LENGTH))
        )

        $MessageEvent.store<ref.i32>(
            this local($offset)
        )

        local($offset)
    )

    (func $MessageEvent.store<ref.i32>
        (param $this                        <MessageEvent>)
        (param $offset                                 i32)

        $MessageEvent:data/store<i32.i32>(
            local($offset) $MessageEvent:data/get<ref>i32( this )
        )

        $MessageEvent:lastEventId/store<i32.i32>(
            local($offset) $MessageEvent:lastEventId/get<ref>i32( this )
        )

        $MessageEvent:origin/store<i32.i32>(
            local($offset) $MessageEvent:origin/get<ref>i32( this )
        )

        $MessageEvent:ports/store<i32.i32>(
            local($offset) $MessageEvent:ports/get<ref>i32( this )
        )

        $MessageEvent:source/store<i32.i32>(
            local($offset) $MessageEvent:source/get<ref>i32( this )
        )

        $Event.store<ref.i32>( 
            this (i32.add local($offset) global($MessageEvent.OFFSET_EVENT)) 
        )
    )



    (func $MessageEvent:data/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $MessageEvent:data) (i32.mul local($index) global($MessageEvent.LENGTH_DATA)))
    )

    (func $MessageEvent:data/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $MessageEvent:data) (i32.mul local($index) global($MessageEvent.LENGTH_DATA)) local($value))
    )

    (func $MessageEvent:data/get<ref>i32 
        (param $this                        <MessageEvent>) 
        (result $value                                 i32) 

        $ref($MessageEvent:data/get<ref>ref( this )) 
    )

    (func $MessageEvent:data/get<ref>ref 
        (param $this                        <MessageEvent>) 
        (result $value                            <Object>) 

        (apply $self.MessageEvent:data/get this ref) 
    )

    (func $MessageEvent:data/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=0 local($offset))
    )

    (func $MessageEvent:data/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=0 local($offset) local($value))
    )




    (func $MessageEvent:lastEventId/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $MessageEvent:lastEventId) (i32.mul local($index) global($MessageEvent.LENGTH_LAST_EVENT_ID)))
    )

    (func $MessageEvent:lastEventId/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $MessageEvent:lastEventId) (i32.mul local($index) global($MessageEvent.LENGTH_LAST_EVENT_ID)) local($value))
    )

    (func $MessageEvent:lastEventId/get<ref>i32 
        (param $this                        <MessageEvent>) 
        (result $value                                 i32) 

        $ref($MessageEvent:lastEventId/get<ref>ref( this )) 
    )

    (func $MessageEvent:lastEventId/get<ref>ref 
        (param $this                        <MessageEvent>) 
        (result $value                            <Object>) 

        (apply $self.MessageEvent:lastEventId/get this ref) 
    )

    (func $MessageEvent:lastEventId/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=4 local($offset))
    )

    (func $MessageEvent:lastEventId/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=4 local($offset) local($value))
    )




    (func $MessageEvent:origin/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $MessageEvent:origin) (i32.mul local($index) global($MessageEvent.LENGTH_ORIGIN)))
    )

    (func $MessageEvent:origin/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $MessageEvent:origin) (i32.mul local($index) global($MessageEvent.LENGTH_ORIGIN)) local($value))
    )

    (func $MessageEvent:origin/get<ref>i32 
        (param $this                        <MessageEvent>) 
        (result $value                                 i32) 

        $ref($MessageEvent:origin/get<ref>ref( this )) 
    )

    (func $MessageEvent:origin/get<ref>ref 
        (param $this                        <MessageEvent>) 
        (result $value                            <Object>) 

        (apply $self.MessageEvent:origin/get this ref) 
    )

    (func $MessageEvent:origin/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=8 local($offset))
    )

    (func $MessageEvent:origin/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=8 local($offset) local($value))
    )





    (func $MessageEvent:ports/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $MessageEvent:ports) (i32.mul local($index) global($MessageEvent.LENGTH_PORTS)))
    )

    (func $MessageEvent:ports/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $MessageEvent:ports) (i32.mul local($index) global($MessageEvent.LENGTH_PORTS)) local($value))
    )

    (func $MessageEvent:ports/get<ref>i32 
        (param $this                        <MessageEvent>) 
        (result $value                                 i32) 

        $ref($MessageEvent:ports/get<ref>ref( this )) 
    )

    (func $MessageEvent:ports/get<ref>ref 
        (param $this                        <MessageEvent>) 
        (result $value                            <Object>) 

        (apply $self.MessageEvent:ports/get this ref) 
    )

    (func $MessageEvent:ports/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=12 local($offset))
    )

    (func $MessageEvent:ports/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=12 local($offset) local($value))
    )




    (func $MessageEvent:source/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $MessageEvent:source) (i32.mul local($index) global($MessageEvent.LENGTH_SOURCE)))
    )

    (func $MessageEvent:source/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $MessageEvent:source) (i32.mul local($index) global($MessageEvent.LENGTH_SOURCE)) local($value))
    )

    (func $MessageEvent:source/get<ref>i32 
        (param $this                        <MessageEvent>) 
        (result $value                                 i32) 

        $ref($MessageEvent:source/get<ref>ref( this )) 
    )

    (func $MessageEvent:source/get<ref>ref 
        (param $this                        <MessageEvent>) 
        (result $value                            <Object>) 

        (apply $self.MessageEvent:source/get this ref) 
    )

    (func $MessageEvent:source/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=16 local($offset))
    )

    (func $MessageEvent:source/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=16 local($offset) local($value))
    )


