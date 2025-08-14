
    (alias $DataTransferItem:getAsFile                          $DataTransferItem:getAsFile<ref>ref)
    (alias $DataTransferItem:getAsFileSystemHandle  $DataTransferItem:getAsFileSystemHandle<ref>ref)
    (alias $DataTransferItem:getAsString                     $DataTransferItem:getAsString<ref.fun>)
    (alias $DataTransferItem:kind                                    $DataTransferItem:kind<ref>ref)
    (alias $DataTransferItem:type                                    $DataTransferItem:type<ref>ref)

    (func $DataTransferItem:type<ref>ref 
        (param $this                <DataTransferItem>) 
        (result $type                         <String>)

        (apply $self.DataTransferItem:type/get this ref)
    )

    (func $DataTransferItem:kind<ref>ref 
        (param $this                <DataTransferItem>) 
        (result $kind                         <String>)

        (apply $self.DataTransferItem:kind/get this ref)
    )

    (func $DataTransferItem:getAsFile<ref>ref 
        (param $this                <DataTransferItem>) 
        (result $file                           <File>) 

        (apply $self.DataTransferItem:getAsFile this ref)
    )

    (func $DataTransferItem:getAsFileSystemHandle<ref>ref 
        (param $this                <DataTransferItem>) 
        (result $fileSystemHandle   <FileSystemHandle>) 

        (apply $self.DataTransferItem:getAsFileSystemHandle this ref)
    )

    (func $DataTransferItem:getAsString<ref.fun> 
        (param $this                <DataTransferItem>) 
        (param $callback                       funcref) 

        (apply $self.DataTransferItem:getAsString<fun> this (param local($callback)))
    )

    (func $DataTransferItem:getAsString<refx2> 
        (param $this                <DataTransferItem>) 
        (param $callback                    <Function>) 

        (apply $self.DataTransferItem:getAsString<ref> this (param local($callback)))
    )
