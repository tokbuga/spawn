
    (alias $ScreenOrientation:angle         $ScreenOrientation:angle<ref>i32)
    (alias $ScreenOrientation:type           $ScreenOrientation:type<ref>ref)
    (alias $ScreenOrientation:lock         $ScreenOrientation:lock<refx2>ref)
    (alias $ScreenOrientation:unlock          $ScreenOrientation:unlock<ref>)
    (alias $ScreenOrientation:onchange   $ScreenOrientation:onchange<ref>fun)

    (func $ScreenOrientation:angle<ref>i32 
        (param $this                   <ScreenOrientation>) 
        (result $value                                 i32) 

        (apply $self.ScreenOrientation:angle/get this i32) 
    )

    (func $ScreenOrientation:type<ref>ref 
        (param $this                   <ScreenOrientation>) 
        (result $type                             <String>) 

        (apply $self.ScreenOrientation:type/get this externref) 
    )

    (func $ScreenOrientation:lock<refx2>ref 
        (param $this                  <ScreenOrientation>) 
        (param $orientation                      <String>) 
        (result $async                          <Promise>) 

        (apply $self.ScreenOrientation:lock<ref>ref this (param local($orientation))) 
    )

    (func $ScreenOrientation:unlock<ref> 
        (param $this                   <ScreenOrientation>) 

        (apply $self.ScreenOrientation:unlock this) 
    )

    (func $ScreenOrientation:onchange<ref>fun 
        (param $this                   <ScreenOrientation>) 
        (result $callback                          funcref) 

        (apply $self.ScreenOrientation:onchange/get<>fun this (param)) 
    )

    (func $ScreenOrientation:onchange<ref.fun> 
        (param $this                   <ScreenOrientation>) 
        (param $callback                           funcref) 

        (apply $self.ScreenOrientation:onchange/set<fun> this (param local($callback))) 
    )
