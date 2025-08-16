
    (global $HTMLCanvasElement.TAG_NAME "CANVAS")

    (alias $HTMLCanvasElement:captureStream                            $HTMLCanvasElement:captureStream<ref>ref)
    (alias $HTMLCanvasElement:getContext                                $HTMLCanvasElement:getContext<refx3>ref)
    (alias $HTMLCanvasElement:height                                          $HTMLCanvasElement:height<ref>f32)
    (alias $HTMLCanvasElement:width                                            $HTMLCanvasElement:width<ref>f32)
    (alias $HTMLCanvasElement:toBlob                                     $HTMLCanvasElement:toBlob<ref.fun.ref>)
    (alias $HTMLCanvasElement:toDataURL                                    $HTMLCanvasElement:toDataURL<ref>ref)
    (alias $HTMLCanvasElement:transferControlToOffscreen  $HTMLCanvasElement:transferControlToOffscreen<ref>ref)

    (func $HTMLCanvasElement:captureStream<ref>ref
        (param $this                    <HTMLCanvasElement>)
        (result $stream                       <MediaStream>)

        (apply $self.HTMLCanvasElement:captureStream this ref)
    )

    (func $HTMLCanvasElement:captureStream<ref.i32>ref
        (param $this                    <HTMLCanvasElement>)
        (param $frameRate                               i32)
        (result $stream                       <MediaStream>)

        (apply $self.HTMLCanvasElement:captureStream<i32>ref 
            this (param local($frameRate))
        )
    )

    (func $HTMLCanvasElement:getContext<refx3>ref
        (param $this                    <HTMLCanvasElement>)
        (param $contextType                        <String>)
        (param $contextAttributes                  <Object>)
        (result $context                          <Context>)

        (apply $self.HTMLCanvasElement:getContext<refx2>ref 
            this (param local($contextType) local($contextAttributes))
        )
    )

    (func $HTMLCanvasElement:getContext<refx2>ref
        (param $this                    <HTMLCanvasElement>)
        (param $contextType                        <String>)
        (result $context                          <Context>)

        (apply $self.HTMLCanvasElement:getContext<ref>ref 
            this (param local($contextType))
        )
    )

    (func $HTMLCanvasElement:height<ref>f32
        (param $this                    <HTMLCanvasElement>)
        (result                                         f32)

        (apply $self.HTMLCanvasElement:height/get this f32)
    )

    (func $HTMLCanvasElement:height<ref.f32>
        (param $this                    <HTMLCanvasElement>)
        (param $height                                  f32)

        (apply $self.HTMLCanvasElement:height/set<f32> 
            this (param local($height))
        )
    )

    (func $HTMLCanvasElement:width<ref>f32
        (param $this                    <HTMLCanvasElement>)
        (result                                         f32)

        (apply $self.HTMLCanvasElement:width/get this f32)
    )

    (func $HTMLCanvasElement:width<ref.f32>
        (param $this                    <HTMLCanvasElement>)
        (param $width                                   f32)

        (apply $self.HTMLCanvasElement:width/set<f32> 
            this (param local($width))
        )
    )

    (func $HTMLCanvasElement:toBlob<ref.fun.ref.f32>
        (param $this                    <HTMLCanvasElement>)
        (param $callback                            funcref)
        (param $type                               <String>)
        (param $quality                                 f32)

        (apply $self.HTMLCanvasElement:toBlob<fun.ref.f32> 
            this (param local($callback) local($type) local($quality))
        )
    )

    (func $HTMLCanvasElement:toBlob<ref.fun.ref>
        (param $this                    <HTMLCanvasElement>)
        (param $callback                            funcref)
        (param $type                               <String>)

        (apply $self.HTMLCanvasElement:toBlob<fun.ref> 
            this (param local($callback) local($type))
        )
    )

    (func $HTMLCanvasElement:toBlob<ref.fun>
        (param $this                    <HTMLCanvasElement>)
        (param $callback                            funcref)

        (apply $self.HTMLCanvasElement:toBlob<fun> 
            this (param local($callback))
        )
    )

    (func $HTMLCanvasElement:toDataURL<refx2.f32>ref
        (param $this                    <HTMLCanvasElement>)
        (param $type                               <String>)
        (param $quality                                 f32)
        (result $dataURL                              <URL>)

        (apply $self.HTMLCanvasElement:toDataURL<ref.f32>ref 
            this (param local($type) local($quality))
        )
    )

    (func $HTMLCanvasElement:toDataURL<refx2>ref
        (param $this                    <HTMLCanvasElement>)
        (param $type                               <String>)
        (result $dataURL                              <URL>)

        (apply $self.HTMLCanvasElement:toDataURL<ref>ref 
            this (param local($type))
        )
    )

    (func $HTMLCanvasElement:toDataURL<ref>ref
        (param $this                    <HTMLCanvasElement>)
        (result $dataURL                              <URL>)

        (apply $self.HTMLCanvasElement:toDataURL this ref)
    )

    (func $HTMLCanvasElement:transferControlToOffscreen<ref>ref
        (param $this                    <HTMLCanvasElement>)
        (result $offscreenCanvas          <OffscreenCanvas>)

        (apply $self.HTMLCanvasElement:transferControlToOffscreen this ref)
    )
