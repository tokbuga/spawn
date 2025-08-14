
    (alias $DataTransfer:files          $DataTransfer:files<ref>ref)
    (alias $DataTransfer:items          $DataTransfer:items<ref>ref)

    (func $DataTransfer:files<ref>ref 
        (param $this                        <DataTransfer>) 
        (result $files                          <FileList>)
        (apply $self.DataTransfer:files/get this externref)
    )

    (func $DataTransfer:items<ref>ref 
        (param $this                        <DataTransfer>) 
        (result $items              <DataTransferItemList>)
        (apply $self.DataTransfer:items/get this externref)
    )
