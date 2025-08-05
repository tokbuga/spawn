
    (func $DataTransfer:files<ref>ref 
        (param $this                        <DataTransfer>) 
        (result $files                          <FileList>)
        (apply $self.DataTransfer:files/get this externref)
    )
