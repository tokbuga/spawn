
    (global $self.crypto                         externref)

    (alias $crypto.randomUUID      $Crypto:randomUUID<>ref)

    (func $Crypto:randomUUID<>ref 
        (result $uuid                             <String>) 
        (call $Crypto:randomUUID<ref>ref global($self.crypto))
    )

    (func $Crypto:randomUUID<ref>ref 
        (param $this                              <Crypto>) 
        (result $uuid                             <String>) 

        (apply $self.Crypto:randomUUID this ref)
    )

    (func $Crypto:getRandomValues<refx2> 
        (param $this                              <Crypto>) 
        (param $integerArray             <ArrayBufferView>) 

        (apply $self.Crypto:getRandomValues<ref>
            this (param local($integerArray))
        )
    )

    (func $Crypto:getRandomValues<refx2>ref 
        (param $this                              <Crypto>) 
        (param $integerArray             <ArrayBufferView>) 
        (result $integerArray            <ArrayBufferView>) 

        (apply $self.Crypto:getRandomValues<ref>ref
            this (param local($integerArray))
        )
    )

