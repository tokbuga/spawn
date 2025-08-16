
    (alias $CSSStyleDeclaration:setProperty             $CSSStyleDeclaration:setProperty<refx2.f32>)
    (alias $CSSStyleDeclaration:getPropertyValue    $CSSStyleDeclaration:getPropertyValue<refx2>f32)
    (alias $CSSStyleDeclaration:width                            $CSSStyleDeclaration:width<ref>f32)
    (alias $CSSStyleDeclaration:height                          $CSSStyleDeclaration:height<ref>f32)
    (alias $CSSStyleDeclaration:margin                          $CSSStyleDeclaration:margin<ref>f32)

    (func $CSSStyleDeclaration:getPropertyValue<refx2>i32
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (result $value                            i32)

        (apply $self.CSSStyleDeclaration:getPropertyValue<ref>i32 
            this (param local($propertyName))
        )
    )

    (func $CSSStyleDeclaration:getPropertyValue<refx2>f32
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (result $value                            f32)

        (apply $self.CSSStyleDeclaration:getPropertyValue<ref>f32 
            this (param local($propertyName))
        )
    )

    (func $CSSStyleDeclaration:getPropertyValue<refx2>ref
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (result $value                       <String>)

        (apply $self.CSSStyleDeclaration:getPropertyValue<ref>ref 
            this (param local($propertyName))
        )
    )

    (func $CSSStyleDeclaration:setProperty<refx4>
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (param $value                        <String>)
        (param $priority                     <String>)

        (apply $self.CSSStyleDeclaration:setProperty<refx3> 
            this (param local($propertyName) local($value) local($priority))
        )
    )

    (func $CSSStyleDeclaration:setProperty<refx3>
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (param $value                        <String>)

        (apply $self.CSSStyleDeclaration:setProperty<refx2> 
            this (param local($propertyName) local($value))
        )
    )
    
    (func $CSSStyleDeclaration:setProperty<refx2.f32.ref>
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (param $value                             f32)
        (param $priority                     <String>)

        (apply $self.CSSStyleDeclaration:setProperty<ref.f32.ref> 
            this (param local($propertyName) local($value) local($priority))
        )
    )
    
    (func $CSSStyleDeclaration:setProperty<refx2.f32>
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (param $value                             f32)

        (apply $self.CSSStyleDeclaration:setProperty<ref.f32> 
            this (param local($propertyName) local($value))
        )
    )
    
    (func $CSSStyleDeclaration:setProperty<refx2.i32>
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (param $value                             i32)

        (apply $self.CSSStyleDeclaration:setProperty<ref.i32> 
            this (param local($propertyName) local($value))
        )
    )
        
    (func $CSSStyleDeclaration:setProperty<refx2.i32.ref>
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (param $value                             i32)
        (param $priority                     <String>)

        (apply $self.CSSStyleDeclaration:setProperty<ref.i32.ref> 
            this (param local($propertyName) local($value) local($priority))
        )
    )
    
    (func $CSSStyleDeclaration:setProperty<refx2.i32x2>
        (param $this            <CSSStyleDeclaration>)
        (param $propertyName                 <String>)
        (param $value                             i32)
        (param $important                         i32)

        (apply $self.CSSStyleDeclaration:setProperty<ref.i32.ref> 
            this 
            (param 
                local($propertyName) 
                local($value)
                (if (result ref) local($important)
                    (then text("important"))
                    (else text(""))
                )
            )
        )
    )
    
    (func $CSSStyleDeclaration:width<ref.f32>
        (param $this            <CSSStyleDeclaration>)
        (param $value                              f32)

        $CSSStyleDeclaration:setProperty( this text("width") local($value) )
    )
    
    (func $CSSStyleDeclaration:height<ref.f32>
        (param $this            <CSSStyleDeclaration>)
        (param $value                             f32)

        $CSSStyleDeclaration:setProperty( this text("height") local($value) )
    )
    
    (func $CSSStyleDeclaration:margin<ref.f32>
        (param $this            <CSSStyleDeclaration>)
        (param $value                             f32)

        $CSSStyleDeclaration:setProperty( this text("margin") local($value) )
    )
    