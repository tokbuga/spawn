

    (alias $Screen:isExtended            $Screen:isExtended<ref>i32)
    (alias $Screen:width                      $Screen:width<ref>f32)
    (alias $Screen:height                    $Screen:height<ref>f32)
    (alias $Screen:availWidth            $Screen:availWidth<ref>f32)
    (alias $Screen:availHeight          $Screen:availHeight<ref>f32)
    (alias $Screen:availTop                $Screen:availTop<ref>f32)
    (alias $Screen:availLeft              $Screen:availLeft<ref>f32)
    (alias $Screen:colorDepth            $Screen:colorDepth<ref>i32)
    (alias $Screen:pixelDepth            $Screen:pixelDepth<ref>i32)
    (alias $Screen:orientation          $Screen:orientation<ref>ref)
    (alias $Screen:onchange                $Screen:onchange<ref>fun)

    (func $Screen:isExtended<ref>i32 
        (param $this                              <Screen>) 
        (result $value                                 i32) 

        (apply $self.Screen:isExtended/get this i32) 
    )

    (func $Screen:orientation<ref>ref 
        (param $this                              <Screen>) 
        (result $orientation           <ScreenOrientation>) 

        (apply $self.Screen:orientation/get this externref) 
    )

    (func $Screen:availWidth<ref>f32 
        (param $this                              <Screen>) 
        (result $value                                 f32) 

        (apply $self.Screen:availWidth/get this f32) 
    )

    (func $Screen:availHeight<ref>f32 
        (param $this                              <Screen>) 
        (result $value                                 f32) 

        (apply $self.Screen:availHeight/get this f32) 
    )

    (func $Screen:pixelDepth<ref>i32 
        (param $this                              <Screen>) 
        (result $value                                 i32) 

        (apply $self.Screen:pixelDepth/get this i32) 
    )

    (func $Screen:colorDepth<ref>i32 
        (param $this                              <Screen>) 
        (result $value                                 i32) 

        (apply $self.Screen:colorDepth/get this i32) 
    )

    (func $Screen:availTop<ref>f32 
        (param $this                              <Screen>) 
        (result $value                                 f32) 

        (apply $self.Screen:availTop/get this f32) 
    )

    (func $Screen:availLeft<ref>f32 
        (param $this                              <Screen>) 
        (result $value                                 f32) 

        (apply $self.Screen:availLeft/get this f32) 
    )

    (func $Screen:width<ref>f32 
        (param $this                              <Screen>) 
        (result $value                                 f32) 

        (apply $self.Screen:width/get this f32) 
    )

    (func $Screen:height<ref>f32 
        (param $this                              <Screen>) 
        (result $value                                 f32) 

        (apply $self.Screen:height/get this f32) 
    )

    (func $Screen:onchange<ref>fun 
        (param $this                              <Screen>) 
        (result $callback                          funcref) 

        (apply $self.Screen:onchange/get<>fun this (param)) 
    )

    (func $Screen:onchange<ref.fun> 
        (param $this                              <Screen>) 
        (param $callback                           funcref) 

        (apply $self.Screen:onchange/set<fun> this (param local($callback))) 
    )
