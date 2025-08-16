
    (alias $PointerEvent:isPrimary                        $PointerEvent:isPrimary<ref>i32)
    (alias $PointerEvent:pointerType                    $PointerEvent:pointerType<ref>ref)
    (alias $PointerEvent:width                                $PointerEvent:width<ref>i32)
    (alias $PointerEvent:height                              $PointerEvent:height<ref>i32)
    (alias $PointerEvent:altitudeAngle                $PointerEvent:altitudeAngle<ref>f32)
    (alias $PointerEvent:azimuthAngle                  $PointerEvent:azimuthAngle<ref>f32)
    (alias $PointerEvent:persistentDeviceId      $PointerEvent:persistentDeviceId<ref>i32)
    (alias $PointerEvent:pointerId                        $PointerEvent:pointerId<ref>i32)
    (alias $PointerEvent:pressure                          $PointerEvent:pressure<ref>f32)
    (alias $PointerEvent:tangentialPressure      $PointerEvent:tangentialPressure<ref>f32)
    (alias $PointerEvent:tiltX                                $PointerEvent:tiltX<ref>f32)
    (alias $PointerEvent:tiltY                                $PointerEvent:tiltY<ref>f32)
    (alias $PointerEvent:twist                                $PointerEvent:twist<ref>i32)

    (func $PointerEvent:isPrimary<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:isPrimary/get this i32) 
    )

    (func $PointerEvent:pointerType<ref>ref 
        (param $this                        <PointerEvent>) 
        (result $value                            <String>) 

        (apply $self.PointerEvent:pointerType/get this externref) 
    )

    (func $PointerEvent:width<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $width                                 i32) 

        (apply $self.PointerEvent:width/get this i32) 
    )

    (func $PointerEvent:height<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:height/get this i32) 
    )

    (func $PointerEvent:altitudeAngle<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:altitudeAngle/get this f32) 
    )

    (func $PointerEvent:azimuthAngle<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:azimuthAngle/get this f32) 
    )

    (func $PointerEvent:persistentDeviceId<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:persistentDeviceId/get this i32) 
    )

    (func $PointerEvent:pointerId<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:pointerId/get this i32) 
    )

    (func $PointerEvent:pressure<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:pressure/get this f32) 
    )

    (func $PointerEvent:tangentialPressure<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:tangentialPressure/get this f32) 
    )

    (func $PointerEvent:tiltX<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:tiltX/get this f32) 
    )

    (func $PointerEvent:tiltY<ref>f32 
        (param $this                        <PointerEvent>) 
        (result $value                                 f32) 

        (apply $self.PointerEvent:tiltY/get this f32) 
    )

    (func $PointerEvent:twist<ref>i32 
        (param $this                        <PointerEvent>) 
        (result $value                                 i32) 

        (apply $self.PointerEvent:twist/get this i32) 
    )
