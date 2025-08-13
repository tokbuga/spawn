
    (alias $wasm.Pointer<Class>       $wasm.Pointer<Class><>ref)
    (alias $wasm.ExtendPointerClass      $wasm.ExtendPointerClass<ref>ref)

    (global $wasm.Pointer<Class> mut extern)
    (global $wasm.classFunctionBody "return class % extends this{}")

    (func $wasm.classFunctionBody<ref>ref
        (param $name <string>)
        (result $body <string>)

        (apply $self.String:replace<refx2>ref
            global($wasm.classFunctionBody)
            (param text("%") local($name))
        )
    )
    
    (func $wasm.Pointer<Class><>ref
        (result $class   <Class>)
        (if (null === global($wasm.Pointer<Class>))
            (then
                global($wasm.Pointer<Class>
                    $self.Reflect.apply<refx3>ref(
                        $self.Function<ref>ref(
                            $wasm.classFunctionBody<ref>ref(
                                text("Pointer")
                            )
                        )
                        (get <refx2>ref self text("Number")) self
                    )
                )
            )
        )

        global($wasm.Pointer<Class>)
    )

    (func $wasm.ExtendSuperClass<refx2>ref
        (param $name <string>)
        (param $super <Class>)
        (result $class   <Class>)

        $self.Reflect.apply<refx3>ref(
            $self.Function<ref>ref(
                $wasm.classFunctionBody<ref>ref(
                    local($name)
                )
            )
            local($super)
            self
        )
    )

    (func $wasm.ExtendPointerClass<ref>ref
        (param $name    <string>)
        (result $class   <Class>)

        $wasm.ExtendSuperClass<refx2>ref(
            local($name) $wasm.Pointer<Class>() 
        )
    )
    