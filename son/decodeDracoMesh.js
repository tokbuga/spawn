import "../draco_decoder_gltf.js";

const CHUNK_TYPE_JSON                                      = 0x4E4F534A;
const CHUNK_TYPE_BIN                                       = 0x004E4942;
const POINT_CLOUD                                          = 0;
const TRIANGULAR_MESH                                      = 1;
const MESH_SEQUENTIAL_ENCODING                             = 0;
const MESH_EDGEBREAKER_ENCODING                            = 1;
const METADATA_FLAG_MASK                                   = 32768;
const SEQUENTIAL_ATTRIBUTE_ENCODER_GENERIC                 = 0;
const SEQUENTIAL_ATTRIBUTE_ENCODER_INTEGER                 = 1;
const SEQUENTIAL_ATTRIBUTE_ENCODER_QUANTIZATION            = 2;
const SEQUENTIAL_ATTRIBUTE_ENCODER_NORMALS                 = 3;
const SEQUENTIAL_COMPRESSED_INDICES                        = 0;
const SEQUENTIAL_UNCOMPRESSED_INDICES                      = 1;
const PREDICTION_NONE                                      = -2;
const PREDICTION_DIFFERENCE                                = 0;
const MESH_PREDICTION_PARALLELOGRAM                        = 1;
const MESH_PREDICTION_CONSTRAINED_MULTI_PARALLELOGRAM      = 4;
const MESH_PREDICTION_TEX_COORDS_PORTABLE                  = 5;
const MESH_PREDICTION_GEOMETRIC_NORMAL                     = 6;
const PREDICTION_TRANSFORM_WRAP                            = 1;
const PREDICTION_TRANSFORM_NORMAL_OCTAHEDRON_CANONICALIZED = 3;
const MESH_TRAVERSAL_DEPTH_FIRST                           = 0;
const MESH_TRAVERSAL_PREDICTION_DEGREE                     = 1;
const MESH_VERTEX_ATTRIBUTE                                = 0;
const MESH_CORNER_ATTRIBUTE                                = 1;
const STANDARD_EDGEBREAKER                                 = 0;
const VALENCE_EDGEBREAKER                                  = 2;
const kInvalidCornerIndex                                  = -1;
const LEFT_FACE_EDGE                                       = 0;
const RIGHT_FACE_EDGE                                      = 1;
const kTexCoordsNumComponents                              = 2;
const kMaxNumParallelograms                                = 4;
const kMaxPriority                                         = 3;
const TOPOLOGY_C                                           = 0;
const TOPOLOGY_S                                           = 1;
const TOPOLOGY_L                                           = 3;
const TOPOLOGY_R                                           = 5;
const TOPOLOGY_E                                           = 7;
const MIN_VALENCE                                          = 2;
const MAX_VALENCE                                          = 7;
const NUM_UNIQUE_VALENCES                                  = 6;
const rabs_ans_p8_precision                                = 256;
const rabs_ans_p10_precision                               = 1024;
const rabs_l_base                                          = 4096;
const IO_BASE                                              = 256;
const L_RANS_BASE                                          = 4096;
const TAGGED_RANS_BASE                                     = 16384;
const TAGGED_RANS_PRECISION                                = 4096;
const TAGGED_SYMBOLS                                       = 0;
const RAW_SYMBOLS                                          = 1;
const ITEMS_PER_GLTYPE = {
    SCALAR: 1, VEC2: 2, VEC3: 3, VEC4: 4, 
    MAT4: 16, MAT3: 9, MAT2: 4
};
const VIEWS_FOR_GLCOMPONENTTYPE = {
    [ WebGL2RenderingContext.FLOAT ] : Float32Array,
    [ WebGL2RenderingContext.UNSIGNED_BYTE ] : Uint8Array,
    [ WebGL2RenderingContext.UNSIGNED_INT ] : Uint8Array,
    [ WebGL2RenderingContext.UNSIGNED_SHORT ] : Uint16Array,
};

self.adapter   = await navigator.gpu.requestAdapter();
self.device    = await adapter.requestDevice();

self.readAsGltf = async function ( source ) {
    const view = new DataView( source );
    
    const readChunk = async ( offset, length, headers ) => {
        let result = null;
        
        const chunkLength = view.getUint32( offset, true ); offset += 4
        const chunkType   = view.getUint32( offset, true ); offset += 4

        if (offset + chunkLength > source.byteLength) {
            throw new RangeError("ERROR_BUFFER_EXCEED: " + JSON.stringify({
                offset, 
                length,
                chunkLength,
                chunkType, 
                sourceByteLength: source.byteLength
            }, null, "\t"))
        }

        const chunkData = new Uint8Array( 
            source, offset, Math.min(chunkLength, length || chunkLength) 
        );
        // console.log({offset, length, chunkType}, headers, new Uint8Array(source, offset-8).slice())
        
        switch ( chunkType ) {
            case CHUNK_TYPE_JSON:
                result = Object.defineProperties(
                    JSON.parse( decode(chunkData) ), {
                        byteLength : { value : chunkData.byteLength + 8 },
                        source : { value : chunkData.buffer },
                    }
                ); 
                
                let byteOffset = 
                    chunkData.byteOffset + 
                    chunkData.byteLength + 8
                ;

                result.accessors
                    .forEach((accessor, accessor_index) => {

                        const ITEMS_PER_ELEMENT = ITEMS_PER_GLTYPE[accessor.type];
                        const ComponentTypedArray = VIEWS_FOR_GLCOMPONENTTYPE[accessor.componentType];

                        accessor.accessor_index = accessor_index;

                        if (accessor.bufferView > -1) {
                            const accessorBufferView = result.bufferViews[ 
                                accessor.bufferView 
                            ];
                                
                            accessor.componentData = 
                            result.bufferViews[
                                accessor.bufferView 
                            ].bufferData = Reflect.construct(
                                ComponentTypedArray, [
                                    source,
                                    byteOffset + accessorBufferView.byteOffset,
                                    accessor.count * ITEMS_PER_ELEMENT
                                ]
                            );
                        }
                        else {
                            accessor.componentData = Reflect.construct(
                                ComponentTypedArray, [
                                    accessor.count * ITEMS_PER_ELEMENT
                                ]
                            );
                        }

                        accessor.numComponents = ITEMS_PER_GLTYPE[accessor.type];
                    })
                ;

                result.bufferViews
                    .filter(bv => !bv.bufferData)
                    .forEach(bufferView => {
                        bufferView.bufferData = new Uint8Array(
                            source,
                            byteOffset + bufferView.byteOffset,
                            bufferView.byteLength / Uint8Array.BYTES_PER_ELEMENT
                        );
                    })
                ;

                result.nodes
                    .forEach((node, node_index) => {
                        node.node_index = node_index
                    })
                ;

                result.meshes
                    .filter(mesh => mesh.primitives.find(p => p.extensions))
                    .forEach(mesh => 
                        mesh.primitives.forEach(primitive => {
                            for(const ext_name in primitive.extensions) {
                                const extension = primitive.extensions[ ext_name ];
                                const bufferView = result.bufferViews.at( extension.bufferView );

                                if (ext_name.match(/draco/i)) {
                                    const data = decodeDracoMesh( bufferView.bufferData );
                                    
                                    let values_array    = data.indexes;
                                    let accessors_index = primitive.indices;
                                    let accessor_view   = result.accessors[ accessors_index ].componentData;

                                    if (values_array.length !== accessor_view.length) { 
                                        throw "values_array.length != accessor_view.length" 
                                    } else { accessor_view.set( values_array ) };
                                    
                                    for (const attribute_name in primitive.attributes) {

                                        values_array    = data.attributes.find(a => a.attribute_id === extension.attributes[attribute_name]);
                                        accessors_index = primitive.attributes[ attribute_name ];
                                        accessor_view   = result.accessors[ accessors_index ].componentData;

                                        if (values_array.length !== accessor_view.length) { 
                                            throw "values_array.length != accessor_view.length" 
                                        } else { accessor_view.set( values_array ) };
                                    }
                                }
                            }
                        })
                    )
                ;

                result.skins.filter(s => s.inverseBindMatrices > -1).forEach(skin => {

                    Reflect.defineProperty( skin, "inverseBindMatrices", {
                        value: result.accessors.at(
                            skin.inverseBindMatrices
                        ).componentData, 
                        enumerable: true
                    })

                    skin.joints.forEach((node_index, joint_index) => {
                        Reflect.defineProperty( skin.joints, joint_index, {
                            value: result.nodes.at(node_index), 
                            enumerable: true
                        })
                    }) 
                })

                return result;
            break;

            case CHUNK_TYPE_BIN:
                return chunkData;
            break;

            default: throw "CHUNK_TYPE_UNKNOWN:"; break;
        }

        return result;
    }

    let offset = 0;
    
    const magic     = view.getUint32(offset, true); offset += 4;
    const version   = view.getUint32(offset, true); offset += 4;
    const length    = view.getUint32(offset, true); offset += 4;

    const decode    = TextDecoder.prototype.decode.bind( new TextDecoder ); 
    const headers   = await readChunk( offset, length );

    offset += headers.byteLength;
    for await (const chunk of headers.buffers) 
    {
        chunk.data = await readChunk(
            chunk.byteOffset = offset, 
            chunk.byteLength, headers 
        );

        offset += chunk.byteLength;
    }

    return headers;
}

self.decodeDracoMesh = function ( bufferData, decodeLength = bufferData.length ) {
    const decoder = new decoderModule.Decoder();
    const attribs = [
        { name: "POSITION", id: decoderModule.POSITION },
        { name: "GENERIC", id: decoderModule.GENERIC },
        { name: "COLOR", id: decoderModule.COLOR },
        { name: "NORMAL", id: decoderModule.NORMAL },
        { name: "TEX_COORD", id: decoderModule.TEX_COORD },                                
    ];

    const dtypes = [
        { name: "DT_FLOAT32", data_type: decoderModule.DT_FLOAT32, array_type: "Float32", prefix: "Float", BYTES_PER_ELEMENT: 4 },
        { name: "DT_UINT32", data_type: decoderModule.DT_UINT32, array_type: "UInt32", prefix: "UInt32", BYTES_PER_ELEMENT: 4 },
        { name: "DT_UINT16", data_type: decoderModule.DT_UINT16, array_type: "UInt16", prefix: "UInt16", BYTES_PER_ELEMENT: 2 },
        { name: "DT_UINT8", data_type: decoderModule.DT_UINT8, array_type: "UInt8", prefix: "UInt8", BYTES_PER_ELEMENT: 1 },
        { name: "DT_BOOL", data_type: decoderModule.DT_BOOL, array_type: "UInt8", prefix: "UInt8", BYTES_PER_ELEMENT: 1 },
        { name: "DT_INT8", data_type: decoderModule.DT_INT8, array_type: "Int8", prefix: "Int8", BYTES_PER_ELEMENT: 1 },
        { name: "DT_INT16", data_type: decoderModule.DT_INT16, array_type: "Int16", prefix: "Int16", BYTES_PER_ELEMENT: 2 },
        { name: "DT_INT32", data_type: decoderModule.DT_INT32, array_type: "Int32", prefix: "Int32", BYTES_PER_ELEMENT: 4 },
        { name: "DT_FLOAT64", data_type: decoderModule.DT_FLOAT64, array_type: "Float64", prefix: "Float", BYTES_PER_ELEMENT: 8 },
    ];
    
    let type,
        vals,
        mesh,
        size,
        attr = new Object(), 
        data = new Object(), 
        dbuf = new decoderModule.DracoUInt32Array()
    ;
    
    switch (decoder.GetEncodedGeometryType(bufferData)) 
    {
        case decoderModule.TRIANGULAR_MESH:
            
            decoder.DecodeArrayToMesh( 
                bufferData, 
                decodeLength, 
                mesh = new decoderModule.Mesh()
            );

            data.num_faces = mesh.num_faces();
            data.num_points = mesh.num_points();
            data.num_attributes = mesh.num_attributes();

            data.indexes = new Array();
            data.attributes = new Array();

            data.length_attributes = 0;
            data.length_bytes = 0;

            for (let i = 0; i < data.num_faces; ++i) {
                decoder.GetFaceFromMesh(mesh, i, dbuf);
                const k = i * 3;
                for (let j=0; j<3; j++) {
                    data.indexes[k + j] = dbuf.GetValue(j); 
                }
            }

            for (const {name, id} of attribs) {
                attr = decoder.GetAttribute(mesh, id);
                vals = new Array();

                Reflect.defineProperty( vals, "attribute_id",   { value: id });
                Reflect.defineProperty( vals, "attribute_name", { value: name });
                Reflect.defineProperty( vals, "attribute_size", { value: attr.size() });
                Reflect.defineProperty( vals, "attribute_type", { value: attr.attribute_type() });
                Reflect.defineProperty( vals, "byte_offset",    { value: attr.byte_offset() });
                Reflect.defineProperty( vals, "byte_stride",    { value: attr.byte_stride() });
                Reflect.defineProperty( vals, "data_type",      { value: attr.data_type() });
                Reflect.defineProperty( vals, "normalized",     { value: attr.normalized() });
                Reflect.defineProperty( vals, "num_components", { value: attr.num_components() });
                Reflect.defineProperty( vals, "unique_id",      { value: attr.unique_id() });

                if (vals.size < 0) { 
                    continue; 
                }

                type = dtypes.find(d => 
                    d.data_type === vals.data_type
                );

                if (!type) {
                    throw { UNDEFINED_DATA_TYPE: vals }
                }

                let kFactor,    
                    kString;

                if (vals.byte_stride === type.BYTES_PER_ELEMENT) {
                    kFactor = "";
                    kString = "SCALER";
                }
                else 
                if (vals.byte_stride > 16) {
                    kFactor = Math.sqrt(vals.byte_stride/type.BYTES_PER_ELEMENT);
                    kString = "MAT"
                }
                else {
                    kFactor = vals.byte_stride/type.BYTES_PER_ELEMENT;
                    kString = "VEC"
                }

                Reflect.defineProperty(vals, "encapsulation", { value: `${kString}${kFactor}` });
                
                Reflect.apply( 
                    decoder[ `GetAttribute${type.prefix}ForAllPoints` ], 
                    decoder,
                    [   mesh, 
                        attr, 
                        dbuf = Reflect.construct( 
                            decoderModule[
                                `Draco${type.array_type}Array`
                            ], []
                        )
                    ]
                );

                size = dbuf.size();

                for (let i = 0; i < size; ++i) {
                    vals[i] = dbuf.GetValue(i);
                }

                Reflect.defineProperty(vals, "attribute_length", { value: size});
                Reflect.defineProperty(vals, "byte_length", { value: size * type.BYTES_PER_ELEMENT});
                Reflect.defineProperty(vals, "draco_type", { value: type});
                Reflect.defineProperty(vals, "count", { value: vals.byte_length/vals.byte_stride });

                data.attributes.push(vals);
            }

            Reflect.defineProperty(data.attributes, "byte_length", { value: data.attributes.map(a => a.byte_length).reduce((a=0,b) => a+b)});
            Reflect.defineProperty(data.attributes, "attribute_length", { value: data.attributes.map(a => a.attribute_length).reduce((a=0,b) => a+b)});
                                                
            decoderModule.destroy(dbuf);
            decoderModule.destroy(mesh);
            decoderModule.destroy(decoder);

            return data;

        break;
            
        case decoderModule.POINT_CLOUD:
            return bufferData
            throw "PC";
        break;
    }
}
    
self.decoderModule = await DracoDecoderModule();

self.multiply          = function (A, B) {
    var R = new Array(16);

    R[0]  = (A[0] * B[ 0])    +    (A[4] * B[ 1])   +    (A[8 ] * B[ 2]) + (A[12] * B[ 3]);
    R[1]  = (A[1] * B[ 0])    +    (A[5] * B[ 1])   +    (A[ 9] * B[ 2]) + (A[13] * B[ 3]);
    R[2]  = (A[2] * B[ 0])    +    (A[6] * B[ 1])   +    (A[10] * B[ 2]) + (A[14] * B[ 3]);
    R[3]  = (A[3] * B[ 0])    +    (A[7] * B[ 1])   +    (A[11] * B[ 2]) + (A[15] * B[ 3]);

    R[4]  = (A[0] * B[ 4])    +    (A[4] * B[ 5])   +    (A[ 8] * B[ 6]) + (A[12] * B[ 7]);
    R[5]  = (A[1] * B[ 4])    +    (A[5] * B[ 5])   +    (A[ 9] * B[ 6]) + (A[13] * B[ 7]);
    R[6]  = (A[2] * B[ 4])    +    (A[6] * B[ 5])   +    (A[10] * B[ 6]) + (A[14] * B[ 7]);
    R[7]  = (A[3] * B[ 4])    +    (A[7] * B[ 5])   +    (A[11] * B[ 6]) + (A[15] * B[ 7]);

    R[8]  = (A[0] * B[ 8])    +    (A[4] * B[ 9])   +    (A[ 8] * B[10]) + (A[12] * B[11]);
    R[9]  = (A[1] * B[ 8])    +    (A[5] * B[ 9])   +    (A[ 9] * B[10]) + (A[13] * B[11]);
    R[10] = (A[2] * B[ 8])    +    (A[6] * B[ 9])   +    (A[10] * B[10]) + (A[14] * B[11]);
    R[11] = (A[3] * B[ 8])    +    (A[7] * B[ 9])   +    (A[11] * B[10]) + (A[15] * B[11]);

    R[12] = (A[0] * B[12])    +    (A[4] * B[13])   +    (A[ 8] * B[14]) + (A[12] * B[15]);
    R[13] = (A[1] * B[12])    +    (A[5] * B[13])   +    (A[ 9] * B[14]) + (A[13] * B[15]);
    R[14] = (A[2] * B[12])    +    (A[6] * B[13])   +    (A[10] * B[14]) + (A[14] * B[15]);
    R[15] = (A[3] * B[12])    +    (A[7] * B[13])   +    (A[11] * B[14]) + (A[15] * B[15]);

    return R;
};

self.rot_matrix_x      = ( matrix, radians ) => {
    var sin = Math.sin( radians );
    var cos = Math.cos( radians );

    if (radians < 0) { sin *= -1; }

    var M = new Array(16);

    M[0] = 1;  M[4] = 0;    M[ 8] = 0;    M[12] = 0;
    M[1] = 0;  M[5] = cos;  M[ 9] = -sin; M[13] = 0;
    M[2] = 0;  M[6] = sin;  M[10] = cos;  M[14] = 0;
    M[3] = 0;  M[7] = 0;    M[11] = 0;    M[15] = 1;        

    return multiply( matrix, M );
}

self.rot_matrix_y      = ( matrix, radians ) => {
    var sin = Math.sin( radians );
    var cos = Math.cos( radians );

    if (radians < 0) { sin *= -1; }

    var M = new Array(16);

    M[0] = cos;  M[4] = 0;  M[8]  = sin;    M[12] = 0;
    M[1] = 0;    M[5] = 1;  M[9]  = 0;      M[13] = 0;
    M[2] = -sin; M[6] = 0;  M[10] = cos;    M[14] = 0;
    M[3] = 0;    M[7] = 0;  M[11] = 0;      M[15] = 1;  

    return multiply( matrix, M );
}

self.rot_matrix_z      = ( matrix, radians ) => {
    var sin = Math.sin( radians );
    var cos = Math.cos( radians );

    if (radians < 0) { sin *= -1; }

    var M = new Array(16);

    M[0] = cos;  M[4] = -sin;  M[8]  = 0;  M[12] = 0;
    M[1] = sin;  M[5] = cos;   M[9]  = 0;  M[13] = 0;
    M[2] = 0;    M[6] = 0;     M[10] = 1;  M[14] = 0;
    M[3] = 0;    M[7] = 0;     M[11] = 0;  M[15] = 1;

    return multiply( matrix, M );
}

self.scale_matrix      = ( matrix, sx, sy, sz ) => {
    var M = new Array(16);

    M[0] = sx || 1; M[4] = 0;        M[ 8] = 0;        M[12] = 0;
    M[1] = 0;       M[5] = sy || sx; M[ 9] = 0;        M[13] = 0;
    M[2] = 0;       M[6] = 0;        M[10] = sz || sx; M[14] = 0;
    M[3] = 0;       M[7] = 0;        M[11] = 0;        M[15] = 1;
    
    return multiply( matrix, M );
}

self.translate_matrix  = ( matrix, dx, dy, dz ) => {
    var M = new Array(16);
    
    M[0] = 1;  M[4] = 0;  M[ 8] = 0;  M[12] = dx || 0;
    M[1] = 0;  M[5] = 1;  M[ 9] = 0;  M[13] = dy || 0;
    M[2] = 0;  M[6] = 0;  M[10] = 1;  M[14] = dz || 0;
    M[3] = 0;  M[7] = 0;  M[11] = 0;  M[15] = 1;

    return multiply( matrix, M );
}

// Local matrisi hesapla: T * R * S (matris çarpımı sırası önemli!)
// Önce R * S, sonra T ile çarp
self.multiplyMatrices = (A, B) => {
    const result = new Float32Array(16);
    
    if
    (
        (A.length - B.length) || (A.length !== 16) || 
        ((A.byteLength || 64) !== (B.byteLength || 64))
    ) 
    { throw { A, B, multiplyMatrices: 1} }

    for (let i = 0; i < 4; i++) {
        for (let j = 0; j < 4; j++) {
            result[i * 4 + j] = 0;
            for (let k = 0; k < 4; k++) {
                result[i * 4 + j] += A[i * 4 + k] * B[k * 4 + j];
            }
        }
    }

    return result;
}


// Quaternion'ı 4x4 rotasyon matrisine dönüştür
self.quaternionToMatrix = (q) => {
    const x = q[0], y = q[1], z = q[2], w = q[3];
    const x2 = x * x, y2 = y * y, z2 = z * z;
    const xy = x * y, xz = x * z, yz = y * z;
    const wx = w * x, wy = w * y, wz = w * z;

    return new Float32Array([
        1 - 2 * (y2 + z2), 2 * (xy - wz), 2 * (xz + wy), 0,
        2 * (xy + wz), 1 - 2 * (x2 + z2), 2 * (yz - wx), 0,
        2 * (xz - wy), 2 * (yz + wx), 1 - 2 * (x2 + y2), 0,
        0, 0, 0, 1
    ]);
}

self.computeLocalMatrix = (node) => {
    const translation = node.translation || [0, 0, 0]; // Konum vektörü
    const rotation = node.rotation || [0, 0, 0, 1];     // Quaternion rotasyon
    const scale = node.scale || [1, 1, 1];             // Ölçek vektörü


    // Ölçek matrisi (diyagonal)
    const S = new Float32Array([
        scale[0], 0, 0, 0,
        0, scale[1], 0, 0,
        0, 0, scale[2], 0,
        0, 0, 0, 1
    ]);

    // Rotasyon matrisi
    const R = quaternionToMatrix(rotation);

    // Konum matrisi
    const T = new Float32Array([
        1, 0, 0, translation[0],
        0, 1, 0, translation[1],
        0, 0, 1, translation[2],
        0, 0, 0, 1
    ]);

    let localMatrix = multiplyMatrices(R, S); // Önce R * S
        localMatrix = multiplyMatrices(T, localMatrix); // Sonra T * (R * S)

    return localMatrix;
}

self.computeWorldMatrix = (node, parentWorldMatrix = identityMatrix.slice()) => {
    const local = computeLocalMatrix(node);
    const world = multiplyMatrices(local, parentWorldMatrix);
    return world;
};

self.identityMatrix = new Float32Array([
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
]);

self.default_node = {
    camera      : -1,
    children    : [],
    skin        : -1,
    matrix      : identityMatrix.slice(),
    mesh        : -1,
    rotation    : Float32Array.of(0,0,0,1),
    scale       : Float32Array.of(1,1,1),
    translation : Float32Array.of(0,0,0),
    weights     : [],
    name        : "",
    extensions  : {},
    extras      : {}
};

self.default_mesh = {
    primitives  : [],
    weights     : [],
    name        : "",
    extensions  : {},
    extras      : {}
};

self.default_skin = {
    inverseBindMatrices : undefined,
    joints      : [],
    name        : "",
    extensions  : {},
    extras      : {}
};

self.default_primitive = {
    attributes  : {},
    indices     : -1,
    material    : -1,
    mode        : 4,
    targets     : [],
    extensions  : {},
    extras      : {}
};

self.default_accessor = {
    bufferView      : -1,
    byteOffset      : -1,
    componentType   : undefined,
    normalized      : false,
    count           : undefined,
    type            : undefined,
    max             : 16,
    min             : 1,
    sparse          : {},
    name            : "",
    extensions      : {},
    extras          : {}
};

self.default_bufferView = {
    buffer          : undefined,
    byteOffset      : 0,
    byteLength      : undefined,
    byteStride      : -1,
    target          : -1,
    name            : "",
    extensions      : {},
    extras          : {}
};


self.nodeAt = (gltf, n) => Object.assign(
    Object(),
    default_node,
    gltf.nodes.at(n)
);

self.meshAt = (gltf, n) => Object.assign(
    Object(),
    default_mesh,
    gltf.meshes.at(n)
);

self.skinAt = (gltf, n) => Object.assign(
    Object(),
    default_skin,
    gltf.skins.at(n)
);

self.meshPritimitiveAt = (mesh, n) => Object.assign(
    Object(),
    default_primitive,
    mesh.primitives.at(n)
);

self.accessorAt = (gltf, n) => Object.assign(
    Object(),
    default_accessor,
    gltf.accessors.at(n)
);

self.bufferViewAt = (gltf, n) => Object.assign(
    Object(),
    default_bufferView,
    gltf.bufferViews.at(n)
);


self.toRadians = (angleInDegrees) => {
    return angleInDegrees * 0.017453292519943295;  // Math.PI / 180
};

self.setIdentity = (M) => {
    M[0] = 1;  M[4] = 0;  M[8] = 0;  M[12] = 0;
    M[1] = 0;  M[5] = 1;  M[9] = 0;  M[13] = 0;
    M[2] = 0;  M[6] = 0;  M[10] = 1; M[14] = 0;
    M[3] = 0;  M[7] = 0;  M[11] = 0; M[15] = 1;

    return M;
};

/** -----------------------------------------------------------------
 * Set a perspective projection matrix based on limits of a frustum.
 * @param left   Number Farthest left on the x-axis
 * @param right  Number Farthest right on the x-axis
 * @param bottom Number Farthest down on the y-axis
 * @param top    Number Farthest up on the y-axis
 * @param near   Number Distance to the near clipping plane along the -Z axis
 * @param far    Number Distance to the far clipping plane along the -Z axis
 * @return Float32Array A perspective transformation matrix
 */
self.perspective = (fovy, aspect, near, far) => {
    var M = new Array(16);

    if (fovy <= 0 || fovy >= 180 || aspect <= 0 || near >= far || near <= 0) {
        console.log('Invalid parameters to createPerspective');
        setIdentity(M);
    }

    var half_fovy   = toRadians(fovy) / 2;
    var top         = near * Math.tan(half_fovy);
    var bottom      = -top;
    var right       = top * aspect;
    var left        = -right;

    var sx = (2 * near) / (right - left);
    var sy = (2 * near) / (top - bottom);

    var c2 = 0 - (far + near) / (far - near);
    var c1 = 2 * (near * far) / (near - far);

    var tx = -near * (left + right) / (right - left);
    var ty = -near * (bottom + top) / (top - bottom);

    M[ 0] = sx;   M[ 4] = .0;   M[ 8] = .0;   M[12] = tx;
    M[ 1] = .0;   M[ 5] = sy;   M[ 9] = .0;   M[13] = ty;
    M[ 2] = .0;   M[ 6] = .0;   M[10] = c2;   M[14] = c1;
    M[ 3] = .0;   M[ 7] = .0;   M[11] = -1;   M[15] = .0;

    return M;
}

self.isPowerOf2 = value => {
    return (value & (value - 1)) == 0;
}

self.createShader = (gl, type, source) => {
    const shader = gl.createShader(type);
    gl.shaderSource(shader, source);
    gl.compileShader(shader);
    return shader;
}

self.loadTexture = (gl, url) => {
    const texture = gl.createTexture();
    gl.bindTexture(gl.TEXTURE_2D, texture);

    // Because images have to be download over the internet
    // they might take a moment until they are ready.
    // Until then put a single pixel in the texture so we can
    // use it immediately.
    const level = 0;
    const internalFormat = gl.RGBA;
    const width = 1;
    const height = 1;
    const border = 0;
    const srcFormat = gl.RGBA;
    const srcType = gl.UNSIGNED_BYTE;
    const pixel = new Uint8Array([0, 0, 255, 255]);  // opaque blue
    gl.texImage2D(gl.TEXTURE_2D, level, internalFormat,
                    width, height, border, srcFormat, srcType,
                    pixel);

    const image = new Image();
    image.onload = function() {

        gl.bindTexture(gl.TEXTURE_2D, texture);
        gl.texImage2D(gl.TEXTURE_2D, level, internalFormat,
                        srcFormat, srcType, image);

        // WebGL1 has different requirements for power of 2 images
        // vs non power of 2 images so check if the image is a
        // power of 2 in both dimensions.
        if (isPowerOf2(image.width) && isPowerOf2(image.height)) {
            // Yes, it's a power of 2. Generate mips.
            gl.generateMipmap(gl.TEXTURE_2D);
        } else {
            // No, it's not a power of 2. Turn of mips and set
            // wrapping to clamp to edge
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
        }
    };
    image.src = url;

    return texture;
}

self.bindUIEvents = ( deltaCache, renderer ) => {
    let start_of_mouse_drag;
    let timeoutDelay = 50;
    let timeoutId = null;

    onpointerdown = event => {
        event.preventDefault();
        start_of_mouse_drag = event;
    }

    onpointerup = event => {
        event.preventDefault();        
        start_of_mouse_drag = null;
    }

    addEventListener( "wheel", event => { 
        event.preventDefault();        

        deltaCache.delta_h += event.deltaX;

        if (Number.isInteger(event.deltaY)) {
            deltaCache.delta_v += event.deltaY;
        }
        else {
            deltaCache.delta_z -= event.deltaY;
        }

        clearTimeout(timeoutId);
        timeoutId = setTimeout(renderer, timeoutDelay);

    }, { passive: false })

    onpointermove = event => {
        var delta_x, delta_y, x_limit, y_limit, new_x, new_y;


        //console.log("drag event x,y = " + event.clientX + " " + event.clientY + "  " + event.which);
        if (start_of_mouse_drag) {
            delta_x = -(event.clientX - start_of_mouse_drag.clientX) * 0.1745;
            delta_y =  (event.clientY - start_of_mouse_drag.clientY) * 0.1745;

            deltaCache.delta_x += event.movementX;
            deltaCache.delta_y += event.movementY;

            deltaCache.angle_x += delta_x;
            deltaCache.angle_y += delta_y;
            
            clearTimeout(timeoutId);
            timeoutId = setTimeout(renderer, timeoutDelay);

            start_of_mouse_drag = event;
            event.preventDefault();
        }
    }
};

self.loadFileFromIDBAsArrayBuffer = async filename => await new Promise(done => indexedDB.open("tmp").onsuccess = e => e.target.result.transaction("uploads").objectStore("uploads").get(filename).onsuccess = s => s.target.result.arrayBuffer().then(done));

