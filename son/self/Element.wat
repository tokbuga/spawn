
    (alias $Element:append                 $Element:append<refx2>)
    (alias $Element:clientWidth      $Element:clientWidth<ref>f32)
    (alias $Element:clientHeight    $Element:clientHeight<ref>f32)

    (func $Element:append<refx2>
        (param $this                              <Element>)
        (param $node                                 <Node>)

        (apply $self.Element:append<ref> this (param local($node)))
    )

    (func $Element:clientWidth<ref>f32
        (param $this                              <Element>)
        (result $width                                  f32)

        (apply $self.Element:clientWidth/get this f32)
    )

    (func $Element:clientHeight<ref>f32
        (param $this                              <Element>)
        (result $height                                 f32)

        (apply $self.Element:clientHeight/get this f32)
    )
