
    (alias $DataTransferItemList:add              $DataTransferItemList:add<refx2>)
    (alias $DataTransferItemList:get         $DataTransferItemList:get<ref.i32>ref)
    (alias $DataTransferItemList:clear            $DataTransferItemList:clear<ref>)
    (alias $DataTransferItemList:remove      $DataTransferItemList:remove<ref.i32>)
    (alias $DataTransferItemList:length       $DataTransferItemList:length<ref>i32)

    (func $DataTransferItemList:length<ref>i32 
        (param $this                <DataTransferItemList>) 
        (result $length                                i32)

        (apply $self.DataTransferItemList:length/get this i32)
    )

    (func $DataTransferItemList:clear<ref> 
        (param $this                <DataTransferItemList>) 

        (apply $self.DataTransferItemList:clear this)
    )

    (func $DataTransferItemList:remove<ref.i32> 
        (param $this                <DataTransferItemList>) 
        (param $index                                  i32) 

        (apply $self.DataTransferItemList:remove<i32> this (param local($index)))
    )

    (func $DataTransferItemList:add<refx3>ref 
        (param $this                <DataTransferItemList>) 
        (param $data                              <String>) 
        (param $type                              <String>) 
        (result $item                   <DataTransferItem>) 

        (apply $self.DataTransferItemList:add<refx2>ref
            this (param local($data) local($type))
        )
    )

    (func $DataTransferItemList:get<ref.i32>ref 
        (param $this                <DataTransferItemList>) 
        (param $index                                  i32) 
        (result $item                   <DataTransferItem>) 

        (get <ref.i32>ref this local($index))
    )

    (func $DataTransferItemList:add<refx2> 
        (param $this                <DataTransferItemList>) 
        (param $file                                <File>) 

        (apply $self.DataTransferItemList:add<ref> this (param local($file)))
    )
