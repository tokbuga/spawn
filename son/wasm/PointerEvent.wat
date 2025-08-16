    (global $PointerEvent.LENGTH                      i32 i32(136))
    (global $PointerEvent.HDRLEN                       i32 i32(48))

    (memory $PointerEvent:isPrimary                     1 1 shared)
    (memory $PointerEvent:pointerType                   1 1 shared)
    (memory $PointerEvent:width                         4 4 shared)
    (memory $PointerEvent:height                        4 4 shared)
    (memory $PointerEvent:altitudeAngle                 4 4 shared)
    (memory $PointerEvent:azimuthAngle                  4 4 shared)
    (memory $PointerEvent:persistentDeviceId            4 4 shared)
    (memory $PointerEvent:pointerId                     4 4 shared)
    (memory $PointerEvent:pressure                      4 4 shared)
    (memory $PointerEvent:tangentialPressure            4 4 shared)
    (memory $PointerEvent:tiltX                         4 4 shared)
    (memory $PointerEvent:tiltY                         4 4 shared)
    (memory $PointerEvent:twist                         4 4 shared)

    (global $PointerEvent.OFFSET_IS_PRIMARY            i32  i32(0))
    (global $PointerEvent.OFFSET_POINTER_TYPE          i32  i32(1))
    (global $PointerEvent.OFFSET_PADDING               i32  i32(2))
    (global $PointerEvent.OFFSET_WIDTH                 i32  i32(4))
    (global $PointerEvent.OFFSET_HEIGHT                i32  i32(8))
    (global $PointerEvent.OFFSET_ALTITUDE_ANGLE        i32 i32(12))
    (global $PointerEvent.OFFSET_AZIMUTH_ANGLE         i32 i32(16))
    (global $PointerEvent.OFFSET_PERSISTENT_DEVICE_ID  i32 i32(20))
    (global $PointerEvent.OFFSET_POINTER_ID            i32 i32(24))
    (global $PointerEvent.OFFSET_PRESSURE              i32 i32(28))
    (global $PointerEvent.OFFSET_TANGENTIAL_PRESSURE   i32 i32(32))
    (global $PointerEvent.OFFSET_TILT_X                i32 i32(36))
    (global $PointerEvent.OFFSET_TILT_Y                i32 i32(40))
    (global $PointerEvent.OFFSET_TWIST                 i32 i32(44))
    (global $PointerEvent.OFFSET_MOUSE_EVENT           i32 i32(48))


    (global $PointerEvent.LENGTH_IS_PRIMARY             i32 i32(1))
    (global $PointerEvent.LENGTH_POINTER_TYPE           i32 i32(1))
    (global $PointerEvent.LENGTH_PADDING                i32 i32(2))
    (global $PointerEvent.LENGTH_WIDTH                  i32 i32(4))
    (global $PointerEvent.LENGTH_HEIGHT                 i32 i32(4))
    (global $PointerEvent.LENGTH_ALTITUDE_ANGLE         i32 i32(4))
    (global $PointerEvent.LENGTH_AZIMUTH_ANGLE          i32 i32(4))
    (global $PointerEvent.LENGTH_PERSISTENT_DEVICE_ID   i32 i32(4))
    (global $PointerEvent.LENGTH_POINTER_ID             i32 i32(4))
    (global $PointerEvent.LENGTH_PRESSURE               i32 i32(4))
    (global $PointerEvent.LENGTH_TANGENTIAL_PRESSURE    i32 i32(4))
    (global $PointerEvent.LENGTH_TILT_X                 i32 i32(4))
    (global $PointerEvent.LENGTH_TILT_Y                 i32 i32(4))
    (global $PointerEvent.LENGTH_TWIST                  i32 i32(4))
    (global $PointerEvent.LENGTH_MOUSE_EVENT           i32 i32(88))

    (func $PointerEvent.from<ref>i32
        (param $this                        <PointerEvent>)
        (result $offset                                i32)
        (local $offset                                 i32)
        
        local($offset $malloc(global($PointerEvent.LENGTH)))

        $PointerEvent.store<ref.i32>(
            this local($offset)
        )

        local($offset)
    )

    (func $PointerEvent.store<ref.i32>
        (param $this                        <PointerEvent>)
        (param $offset                                 i32)

        $PointerEvent:width/store<i32.i32>(
            local($offset) $PointerEvent:width/get<ref>i32( this )
        )

        $PointerEvent:height/store<i32.i32>(
            local($offset) $PointerEvent:height/get<ref>i32( this )
        )

        $PointerEvent:altitudeAngle/store<i32.f32>(
            local($offset) $PointerEvent:altitudeAngle/get<ref>f32( this )
        )

        $PointerEvent:azimuthAngle/store<i32.f32>(
            local($offset) $PointerEvent:azimuthAngle/get<ref>f32( this )
        )

        $PointerEvent:persistentDeviceId/store<i32.i32>(
            local($offset) $PointerEvent:persistentDeviceId/get<ref>i32( this )
        )

        $PointerEvent:pointerId/store<i32.i32>(
            local($offset) $PointerEvent:pointerId/get<ref>i32( this )
        )

        $PointerEvent:pressure/store<i32.f32>(
            local($offset) $PointerEvent:pressure/get<ref>f32( this )
        )

        $PointerEvent:tangentialPressure/store<i32.f32>(
            local($offset) $PointerEvent:tangentialPressure/get<ref>f32( this )
        )

        $PointerEvent:tiltX/store<i32.f32>(
            local($offset) $PointerEvent:tiltX/get<ref>f32( this )
        )

        $PointerEvent:tiltY/store<i32.f32>(
            local($offset) $PointerEvent:tiltY/get<ref>f32( this )
        )

        $PointerEvent:twist/store<i32.i32>(
            local($offset) $PointerEvent:twist/get<ref>i32( this )
        )

        $MouseEvent.store<ref.i32>( 
            this 
            (i32.add local($offset) global($PointerEvent.OFFSET_MOUSE_EVENT)) 
        )
    )


    (func $PointerEvent:isPrimary/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $PointerEvent:isPrimary) local($index))
    )

    (func $PointerEvent:isPrimary/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $PointerEvent:isPrimary) local($index) local($value))
    )

    (func $PointerEvent:isPrimary/get<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:isPrimary/get this i32) 
    )

    (func $PointerEvent:isPrimary/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=0 local($offset))
    )

    (func $PointerEvent:isPrimary/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=0 local($offset) local($value))
    )




    (func $PointerEvent:pointerType/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $PointerEvent:pointerType) local($index))
    )

    (func $PointerEvent:pointerType/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $PointerEvent:pointerType) local($index) local($value))
    )

    (func $PointerEvent:pointerType/get<ref>ref 
        (param $this                        <PointerEvent>) 
        (result $value                            <String>) 

        (apply $self.PointerEvent:pointerType/get this externref) 
    )

    (func $PointerEvent:pointerType/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=1 local($offset))
    )

    (func $PointerEvent:pointerType/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=1 local($offset) local($value))
    )



    (func $PointerEvent:width/read<i32>i32 
        (param $index                                  i32) 
        (result $width                                 i32) 

        (i32.load (memory $PointerEvent:width) (i32.mul local($index) global($PointerEvent.LENGTH_WIDTH)))
    )

    (func $PointerEvent:width/write<i32.i32> 
        (param $index                                  i32) 
        (param $width                                  i32) 

        (i32.store (memory $PointerEvent:width) (i32.mul local($index) global($PointerEvent.LENGTH_WIDTH)) local($width))
    )

    (func $PointerEvent:width/get<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $width                                 i32) 

        (apply $self.PointerEvent:width/get this i32) 
    )

    (func $PointerEvent:width/load<i32>i32 
        (param $offset                                 i32) 
        (result $width                                 i32) 

        (i32.load offset=4 local($offset))
    )

    (func $PointerEvent:width/store<i32.i32> 
        (param $offset                                 i32) 
        (param $width                                  i32) 

        (i32.store offset=4 local($offset) local($width))
    )



    (func $PointerEvent:height/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $PointerEvent:height) (i32.mul local($index) global($PointerEvent.LENGTH_HEIGHT)))
    )

    (func $PointerEvent:height/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $PointerEvent:height) (i32.mul local($index) global($PointerEvent.LENGTH_HEIGHT)) local($value))
    )

    (func $PointerEvent:height/get<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:height/get this i32) 
    )

    (func $PointerEvent:height/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=8 local($offset))
    )

    (func $PointerEvent:height/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=8 local($offset) local($value))
    )



    (func $PointerEvent:altitudeAngle/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $PointerEvent:altitudeAngle) (i32.mul local($index) global($PointerEvent.LENGTH_ALTITUDE_ANGLE)))
    )

    (func $PointerEvent:altitudeAngle/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $PointerEvent:altitudeAngle) (i32.mul local($index) global($PointerEvent.LENGTH_ALTITUDE_ANGLE)) local($value))
    )

    (func $PointerEvent:altitudeAngle/get<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:altitudeAngle/get this f32) 
    )

    (func $PointerEvent:altitudeAngle/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=12 local($offset))
    )

    (func $PointerEvent:altitudeAngle/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=12 local($offset) local($value))
    )



    (func $PointerEvent:azimuthAngle/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $PointerEvent:azimuthAngle) (i32.mul local($index) global($PointerEvent.LENGTH_AZIMUTH_ANGLE)))
    )

    (func $PointerEvent:azimuthAngle/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $PointerEvent:azimuthAngle) (i32.mul local($index) global($PointerEvent.LENGTH_AZIMUTH_ANGLE)) local($value))
    )

    (func $PointerEvent:azimuthAngle/get<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:azimuthAngle/get this f32) 
    )

    (func $PointerEvent:azimuthAngle/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=16 local($offset))
    )

    (func $PointerEvent:azimuthAngle/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=16 local($offset) local($value))
    )



    (func $PointerEvent:persistentDeviceId/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $PointerEvent:persistentDeviceId) (i32.mul local($index) global($PointerEvent.LENGTH_PERSISTENT_DEVICE_ID)))
    )

    (func $PointerEvent:persistentDeviceId/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $PointerEvent:persistentDeviceId) (i32.mul local($index) global($PointerEvent.LENGTH_PERSISTENT_DEVICE_ID)) local($value))
    )

    (func $PointerEvent:persistentDeviceId/get<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:persistentDeviceId/get this i32) 
    )

    (func $PointerEvent:persistentDeviceId/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=20 local($offset))
    )

    (func $PointerEvent:persistentDeviceId/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=20 local($offset) local($value))
    )



    (func $PointerEvent:pointerId/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $PointerEvent:pointerId) (i32.mul local($index) global($PointerEvent.LENGTH_POINTER_ID)))
    )

    (func $PointerEvent:pointerId/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $PointerEvent:pointerId) (i32.mul local($index) global($PointerEvent.LENGTH_POINTER_ID)) local($value))
    )

    (func $PointerEvent:pointerId/get<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:pointerId/get this i32) 
    )

    (func $PointerEvent:pointerId/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=24 local($offset))
    )

    (func $PointerEvent:pointerId/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=24 local($offset) local($value))
    )





    (func $PointerEvent:pressure/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $PointerEvent:pressure) (i32.mul local($index) global($PointerEvent.LENGTH_PRESSURE)))
    )

    (func $PointerEvent:pressure/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $PointerEvent:pressure) (i32.mul local($index) global($PointerEvent.LENGTH_PRESSURE)) local($value))
    )

    (func $PointerEvent:pressure/get<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:pressure/get this f32) 
    )

    (func $PointerEvent:pressure/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=28 local($offset))
    )

    (func $PointerEvent:pressure/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=28 local($offset) local($value))
    )




    (func $PointerEvent:tangentialPressure/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $PointerEvent:tangentialPressure) (i32.mul local($index) global($PointerEvent.LENGTH_TANGENTIAL_PRESSURE)))
    )

    (func $PointerEvent:tangentialPressure/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $PointerEvent:tangentialPressure) (i32.mul local($index) global($PointerEvent.LENGTH_TANGENTIAL_PRESSURE)) local($value))
    )

    (func $PointerEvent:tangentialPressure/get<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:tangentialPressure/get this f32) 
    )

    (func $PointerEvent:tangentialPressure/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=32 local($offset))
    )

    (func $PointerEvent:tangentialPressure/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=32 local($offset) local($value))
    )




    (func $PointerEvent:tiltX/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $PointerEvent:tiltX) (i32.mul local($index) global($PointerEvent.LENGTH_TILT_X)))
    )

    (func $PointerEvent:tiltX/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $PointerEvent:tiltX) (i32.mul local($index) global($PointerEvent.LENGTH_TILT_X)) local($value))
    )

    (func $PointerEvent:tiltX/get<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:tiltX/get this f32) 
    )

    (func $PointerEvent:tiltX/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=36 local($offset))
    )

    (func $PointerEvent:tiltX/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=36 local($offset) local($value))
    )





    (func $PointerEvent:tiltY/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $PointerEvent:tiltY) (i32.mul local($index) global($PointerEvent.LENGTH_TILT_Y)))
    )

    (func $PointerEvent:tiltY/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $PointerEvent:tiltY) (i32.mul local($index) global($PointerEvent.LENGTH_TILT_Y)) local($value))
    )

    (func $PointerEvent:tiltY/get<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:tiltY/get this f32) 
    )

    (func $PointerEvent:tiltY/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=40 local($offset))
    )

    (func $PointerEvent:tiltY/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=40 local($offset) local($value))
    )




    (func $PointerEvent:twist/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $PointerEvent:twist) (i32.mul local($index) global($PointerEvent.LENGTH_TWIST)))
    )

    (func $PointerEvent:twist/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $PointerEvent:twist) (i32.mul local($index) global($PointerEvent.LENGTH_TWIST)) local($value))
    )

    (func $PointerEvent:twist/get<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:twist/get this i32) 
    )

    (func $PointerEvent:twist/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=44 local($offset))
    )

    (func $PointerEvent:twist/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=44 local($offset) local($value))
    )


