( For the HiFive1, we produce a flat image that's placed into SPI flash. )

hex
variable address-field
20400000 constant load-address  ( load to "user" part of the SPI flash )
: exe-header    ( a -- ;  put down a jump, patched in ENTRY-POINT )
                00000297 ,      ( auipc t0, 0 )
                00c2a283 ,      ( lw    t0, 0xc[t0] )
                00028067 ,      ( jr    t0 )
                here address-field !
                41414141 , ;    ( address placeholder )
: entry-point   address-field @ ! ;
: exe-code      s" targets/riscv/hifive1/io.fth" included ;
: extra-bytes   drop ;
: exe-end       ;
decimal
