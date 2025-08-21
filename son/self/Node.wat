
    (alias $Node:parentElement  $Node:parentElement<ref>ref)

    (func $Node:parentElement<ref>ref
        (param $this                                 <Node>)
        (result $parent                           <Element>)

        (apply $self.Node:parentElement/get this ref)
    )