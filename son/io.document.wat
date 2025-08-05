(module
    (memory 1 1)

    (global $self.document ref)
    (global $self.document.body ref)

    (func (export "createElement")

    )

    (func (export "onfiledrop")
        (param $callback funcref)


    )

    (start $main

        (apply $self.addEventListener<ref.fun> 
            global($self.document) 
            (param text("drop") func($ondrop<ref>))
        )

        (apply $self.addEventListener<ref.fun> 
            global($self.document) 
            (param text("dragover") func($ondragover<ref>))
        )
    )

    (func $ondrop<ref>
        (param $event <DragEvent>)
        (warn this)

        (apply $self.Event:preventDefault this)
    )

    (func $ondragover<ref>
        (param $event <DragEvent>)
        (apply $self.Event:preventDefault this)
    )

)