
    (func $Blob:size<ref>i32 
        (param $this                                <Blob>) 
        (result $size                                  i32)
        (apply $self.Blob:size/get this i32)
    )

    (func $Blob:type<ref>ref 
        (param $this                                <Blob>) 
        (result $type                             <String>)
        (apply $self.Blob:type/get this externref)
    )


    (alias $Blob:new        $Blob:new<ref>ref)


    (func $Blob:new<ref>ref 
        (param $content                            <Array>) 
        (result $this                               <Blob>)
        (new $self.Blob<ref>ref this)
    )

