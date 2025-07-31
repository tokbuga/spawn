Object.defineProperties( Number.prototype, {
    hex : { value: function (byteLength = 1) { 
        return `0x` + this.toString(16).padStart(byteLength * 2, 0); 
    }},
})

Object.defineProperties( Buffer.prototype, {
    send : {
        value : function ( sender ) {
            sender.send( this )
        }
    },

    [ Symbol.toPrimitive ] : {
        value : function () {
            Object.setPrototypeOf( this, Pointer.setPrototypeFrom.prototype );
            return;
        }
    }
});

export class Pointer extends Buffer {

    static from ( any ) {
        return Object.setPrototypeOf( super.from(any), this.prototype );
    }

    static alloc ( any ) {
        return Object.setPrototypeOf( super.alloc(any), this.prototype );
    }
    
    slice () {
        return Object.setPrototypeOf( super.slice.apply(this, arguments), this );
    }

    subarray () {
        return Object.setPrototypeOf( super.subarray.apply(this, arguments), this );
    }

    //t0: ARPHeader --> primitive
    static [ Symbol.toPrimitive ] () { 
        Pointer.setPrototypeFrom = this; 
    }

    //t1: ptr --> primitive 
    [ Symbol.toPrimitive ] () { 
        Object.setPrototypeOf( this, Pointer.setPrototypeFrom.prototype ); 
    }
} 

export class ETHHeader extends Pointer {
    get dmac     () { return this.readUIntBE(0, 6);         }
    get smac     () { return this.readUIntBE(6, 6);         }
    get type     () { return this.readUInt16BE(12);         }

    set dmac    (v) { return this.writeUIntBE(v, 0, 6);     }
    set smac    (v) { return this.writeUIntBE(v, 6, 6);     }
    set type    (v) { return this.writeUInt16BE(v, 12);     }
}

export class WSCHeader extends Pointer {
    get mac      () { return this.readUIntBE(0, 6);         }
    get ip4      () { return this.readUInt32BE(6);          }
    get rsv      () { return this.readUInt16BE(10);         }
    get type     () { return this.readUInt16BE(12);         }

    set mac     (v) { return this.writeUIntBE(v, 0, 6);     }
    set ip4     (v) { return this.writeUInt32BE(v,  6);     }
    set rsv     (v) { return this.writeUInt16BE(v, 10);     }
    set type    (v) { return this.writeUInt16BE(v, 12);     }
}


export class IP4Header extends Pointer {
    get ihl     ()  { return this.readUInt8(0);             }
    get tos     ()  { return this.readUInt8(1);             }
    get tlen    ()  { return this.readUInt16BE(2);          }
    get xid     ()  { return this.readUInt16BE(4);          }
    get flags   ()  { return this.readUInt16BE(6);          }
    get ttl     ()  { return this.readUInt8(8);             }
    get proto   ()  { return this.readUInt8(9);             }
    get csum    ()  { return this.readUInt16BE(10);         }
    get saddr   ()  { return this.readUInt32BE(12);         }
    get daddr   ()  { return this.readUInt32BE(16);         }

    set ihl     (v) { return this.writeUInt8(v, 0);         }
    set tos     (v) { return this.writeUInt8(v, 1);         }
    set tlen    (v) { return this.writeUInt16BE(v, 2);      }
    set xid     (v) { return this.writeUInt16BE(v, 4);      }
    set flags   (v) { return this.writeUInt16BE(v, 6);      }
    set ttl     (v) { return this.writeUInt8(v, 8);         }
    set proto   (v) { return this.writeUInt8(v, 9);         }
    set csum    (v) { return this.writeUInt16BE(v, 10);     }
    set saddr   (v) { return this.writeUInt32BE(v, 12);     }
    set daddr   (v) { return this.writeUInt32BE(v, 16);     }
}

export class IP6Header extends Pointer {
    get ihl      () { return this.readUInt8(0);             }
    set ihl     (v) { return this.writeUInt8(v, 0);         }
}

export class IPPacket extends Pointer {
    get eth_dmac     () { return this.readUIntBE(0, 6);     }
    get eth_smac     () { return this.readUIntBE(6, 6);     }
    get eth_type     () { return this.readUInt16BE(12);     }
   
    set eth_dmac    (v) { return this.writeUIntBE(v, 0, 6); }
    set eth_smac    (v) { return this.writeUIntBE(v, 6, 6); }
    set eth_type    (v) { return this.writeUInt16BE(v, 12); }

    get ip4_ihl     ()  { return this.readUInt8(14);        }
    get ip4_tos     ()  { return this.readUInt8(15);        }
    get ip4_tlen    ()  { return this.readUInt16BE(16);     }
    get ip4_xid     ()  { return this.readUInt16BE(18);     }
    get ip4_flags   ()  { return this.readUInt16BE(20);     }
    get ip4_ttl     ()  { return this.readUInt8(22);        }
    get ip4_proto   ()  { return this.readUInt8(23);        }
    get ip4_csum    ()  { return this.readUInt16BE(24);     }
    get ip4_saddr   ()  { return this.readUInt32BE(26);     }
    get ip4_daddr   ()  { return this.readUInt32BE(30);     }

    set ip4_ihl     (v) { return this.writeUInt8(v,14);     }
    set ip4_tos     (v) { return this.writeUInt8(v,15);     }
    set ip4_tlen    (v) { return this.writeUInt16BE(v,16);  }
    set ip4_xid     (v) { return this.writeUInt16BE(v,18);  }
    set ip4_flags   (v) { return this.writeUInt16BE(v,20);  }
    set ip4_ttl     (v) { return this.writeUInt8(v,22);     }
    set ip4_proto   (v) { return this.writeUInt8(v,23);     }
    set ip4_csum    (v) { return this.writeUInt16BE(v,24);  }
    set ip4_saddr   (v) { return this.writeUInt32BE(v,26);  }
    set ip4_daddr   (v) { return this.writeUInt32BE(v,30);  }

    get eth      () { return ETHHeader * this.subarray( 0); }
    get ip4      () { return IP4Header * this.subarray(14); }
    get ip6      () { return IP6Header * this.subarray(14); }
}

export class ARPHeader extends Pointer {
    get htype       () { return this.readUInt16BE(0);       }
    get atype       () { return this.readUInt16BE(2);       }
    get maclen      () { return this.readUInt8(4);          }
    get addrlen     () { return this.readUInt8(5);          }
    get opcode      () { return this.readUInt16BE(6);       }
    get smac        () { return this.readUIntBE(8,6);       }
    get saddr       () { return this.readUInt32BE(14);      }
    get dmac        () { return this.readUIntBE(18,6);      }
    get daddr       () { return this.readUInt32BE(24);      }

    set htype       (v){ return this.writeUInt16BE(0, 0);   }
    set atype       (v){ return this.writeUInt16BE(0, 2);   }
    set maclen      (v){ return this.writeUInt8(0, 4);      }
    set addrlen     (v){ return this.writeUInt8(0, 5);      }
    set opcode      (v){ return this.writeUInt16BE(0, 6);   }
    set smac        (v){ return this.writeUIntBE(0, 8, 6);  }
    set saddr       (v){ return this.writeUInt32BE(0, 14);  }
    set dmac        (v){ return this.writeUIntBE(0, 18, 6); }
    set daddr       (v){ return this.writeUInt32BE(0, 24);  }
}

export class ARPPacket extends Pointer {
    get eth_dmac     () { return this.readUIntBE(0, 6);     }
    get eth_smac     () { return this.readUIntBE(6, 6);     }
    get eth_type     () { return this.readUInt16BE(12);     }

    set eth_dmac    (v) { return this.writeUIntBE(v, 0, 6); }
    set eth_smac    (v) { return this.writeUIntBE(v, 6, 6); }
    set eth_type    (v) { return this.writeUInt16BE(v, 12); }

    get arp_htype    () { return this.readUInt16BE(14);     }
    get arp_atype    () { return this.readUInt16BE(16);     }
    get arp_maclen   () { return this.readUInt8(18);        }
    get arp_addrlen  () { return this.readUInt8(19);        }
    get arp_opcode   () { return this.readUInt16BE(20);     }
    get arp_smac     () { return this.readUIntBE(22,6);     }
    get arp_saddr    () { return this.readUInt32BE(28);     }
    get arp_dmac     () { return this.readUIntBE(32,6);     }
    get arp_daddr    () { return this.readUInt32BE(38);     }

    set arp_htype   (v) { return this.writeUInt16BE(v, 14); }
    set arp_atype   (v) { return this.writeUInt16BE(v, 16); }
    set arp_maclen  (v) { return this.writeUInt8(v, 18);    }
    set arp_addrlen (v) { return this.writeUInt8(v, 19);    }
    set arp_opcode  (v) { return this.writeUInt16BE(v, 20); }
    set arp_smac    (v) { return this.writeUIntBE(v, 22, 6);}
    set arp_saddr   (v) { return this.writeUInt32BE(v, 28); }
    set arp_dmac    (v) { return this.writeUIntBE(v, 32, 6);}
    set arp_daddr   (v) { return this.writeUInt32BE(v, 38); }

    get eth () { return ETHHeader * this.subarray(0);       }
    get arp () { return ARPHeader * this.subarray(14);      }

    get isAnnouncement () {
        return (
            (this.eth_dmac  === ADDR_MAC_BCAST) &&
            (this.arp_dmac  === ADDR_MAC_ANY) &&
            (this.arp_saddr === this.arp_daddr)
        )
    }
}

export const ETHERTYPE_ETH     = 0x0800;
export const ETHERTYPE_ARP     = 0x0806;
export const ETHERTYPE_WSC     = 0x0401;
export const Oxffffffffffff    = 0xffffffffffff;
export const Oxffffffff        = 0xffffffff;
export const Ox000000000000    = 0x000000000000;
export const Ox00000000        = 0x00000000;
export const ADDR_MAC_ANY      = Ox000000000000;
export const ADDR_MAC_BCAST    = Oxffffffffffff;
export const ADDR_MAC_UNKNOWN  = Ox000000000000;
export const ADDR_IP4_ANY      = Ox00000000;
export const ADDR_IP4_BCAST    = Oxffffffff;
export const ADDR_IP4_UNKNOWN  = Ox00000000;
export const ARP_REQUEST       = 0x1;
export const ARP_REPLY         = 0x2;
export const IHL_VERSION_4     = 0x69;
export const IHL_VERSION_6     = 0x96;
export const ETH_ALEN          = 6;
export const MAC_ALEN          = 6;
export const IP4_ALEN          = 4;
export const MAC_ATYPE         = 0x0001;
export const IP4_ATYPE         = 0x0800;
