
    (alias $File:name                   $File:name<ref>ref)

    (func $File:name<ref>ref 
        (param $this                                <File>) 
        (result $name                             <String>)
        (apply $self.File:name/get this externref)
    )

    (func $File:lastModified<ref>f64 
        (param $this                                <File>) 
        (result $lastModified                          f64)
        (apply $self.File:lastModified/get this f64)
    )

    (func $File:lastModifiedDate<ref>ref 
        (param $this                                <File>) 
        (result $lastModifiedDate                   <Date>)
        (apply $self.File:lastModifiedDate/get this externref)
    )

    (func $File:arrayBuffer<ref>ref 
        (param $this                                <File>) 
        (result $promise                         <Promise>)
        (apply $self.Blob:arrayBuffer this externref)
    )

    (func $File:type<ref>ref 
        (param $this                                <File>) 
        (result $type                             <String>)
        (apply $self.Blob:type/get this externref)
    )

    (func $File:size<ref>i32 
        (param $this                                <File>) 
        (result $size                                  i32)
        (apply $self.Blob:size/get this i32)
    )

