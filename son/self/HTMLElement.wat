
    (alias $HTMLElement:oncontextlost    $HTMLElement:oncontextlost<ref>fun)
    (alias $HTMLElement:style                    $HTMLElement:style<ref>ref)

    (func $HTMLElement:oncontextlost<ref>fun
        (param $this                    <HTMLElement>)
        (result $listener                           funcref)

        (apply $self.HTMLElement:oncontextlost/get<>fun this (param))
    )

    (func $HTMLElement:oncontextlost<ref.fun>
        (param $this                    <HTMLElement>)
        (param $listener                            funcref)

        (apply $self.HTMLElement:oncontextlost/set<fun> 
            this (param local($listener))
        )
    )

    (func $HTMLElement:style<ref>ref
        (param $this                    <HTMLElement>)
        (result $style          <CSSStyleDeclaration>)

        (apply $self.HTMLElement:style/get this ref)
    )

    (func $HTMLElement:style<refx2>
        (param $this                    <HTMLElement>)
        (param $style           <CSSStyleDeclaration>)

        (apply $self.HTMLElement:style/set<ref> 
            this (param local($style))
        )
    )