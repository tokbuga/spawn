
    (alias $RegExp:new                   $RegExp:new<ref>ref)
    (alias $RegExp:test                  $RegExp:test<refx2>i32)

    (global $RegExp.MATCH_HEX "[a-f0-9][a-f0-9]")
    (global $RegExp.FLAG_GLOBAL "g")
    (global $RegExp.FLAG_IGNORE_CASE "i")

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


    (func $RegExp:test<refx2>i32 
        (param $regexp                             <regexp>) 
        (param $string                             <string>) 
        (result $check                                  i32) 

        (apply $self.RegExp:test<ref>i32 this (param local($string))) 
    )

