
    (alias $console.table       $console.table<ref>)

    (global $self.console ref)
    (global $self.console.table ref)

    (func $console.table<ref>
        (param $rows <Array>)
        (call $self.Reflect.apply<refx3> 
            global($self.console.table)
            global($self.console)
            $Array.of<ref>ref( this )
        )
    )