
    (func $DragEvent:dataTransfer<ref>ref 
        (param $this                           <DragEvent>) 
        (result $dataTransfer               <DataTransfer>)
        (apply $self.DragEvent:dataTransfer/get this externref)
    )
