
    (alias $RegExp:new                   $RegExp:new<ref>ref)

    (global $RegExp.MATCH_HEX "[a-f0-9][a-f0-9]")
    (global $RegExp.FLAG_GLOBAL "g")

    (func $RegExp:new<ref>ref 
        (param $source                             <string>) 
        (result $this                              <RegExp>) 

        (new $self.RegExp<ref>ref local($source)) 
    )

    (func $RegExp:new<refx2>ref 
        (param $source                             <string>) 
        (param $flags                              <string>) 
        (result $this                              <RegExp>) 

        (new $self.RegExp<refx2>ref local($source) local($flags)) 
    )

