
    (alias $Document:createElement  $Document:createElement<refx2>ref)

    (func $Document:createElement<refx2>ref
        (param $this            <Document>)
        (param $localName         <String>)
        (result $element     <HTMLElement>)

        (apply $self.Document:createElement<ref>ref 
            this (param local($localName))
        )
    )