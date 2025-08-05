
    (func $FileList:length<ref>i32 
        (param $this                            <FileList>) 
        (result $length                                i32)
        (apply $self.FileList:length/get this i32)
    )

    (func $FileList:item<ref.i32>ref 
        (param $this                            <FileList>) 
        (param $index                                  i32) 
        (result $item                               <File>)
        (apply $self.FileList:item<i32>ref this (param local($index)))
    )
