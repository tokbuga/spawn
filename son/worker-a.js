console.log(3)
addEventListener( "message", ({data: memory}) => {
    
    console.log( new Uint8Array(memory) )
})