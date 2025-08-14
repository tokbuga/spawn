
    (alias $URL.createObjectURL $URL.createObjectURL<reff>ref)
    
    (func $URL.createObjectURL<reff>ref 
        (param $content                             <Blob>) 
        (result $this                                <URL>)

        (apply $self.URL.createObjectURL<ref>ref 
            self (param this)
        )
    )