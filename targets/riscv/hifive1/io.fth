\ I/O for the HiFive1 board. Copyright 2018 Jonathan Neuschäfer
hex

( We're in a really weird environment here.
  Words have to be explicitly postponed. )

code emit ( x -- )
   10013000 # x6 lui,   \ UART0 base address
   begin,
     x6 ) x7 lw,
   x7 0=, until,        \ wait until the 'full' flag is clear
   0 S )# x7 lw,        \ read character value from the stack
   x6 ) x7 sw,          \ write character into txdata
   next,
end-code


( The minimal sequence to get a stable UART signal )
code io-init ( -- )
   10008000 # x6 lui,   \ load PRCI base address
   40000000 # x7 lui,   \ hfxoscen
   4 x6 )# x7 sw,       \ write hfxosccfg
   begin,
     4 x6 )# x7 lw,
   x0 x7 <, until,      \ wait for hfxoscrdy (MSB) to light up
   00060000 # x7 lui,   \ load PLL config: input=HFXOSC, bypassed, not selected
   8 x6 )# x7 sw,       \ store PLL config
   00070000 # x7 lui,   \ load PLL config: input=HFXOSC, bypassed, selected
   8 x6 )# x7 sw,       \ store PLL config

   10012000 # x6 lui,   \ load GPIO base address
   3c x6 )# x0 sw,      \ Use IOF0
   00030000 # x7 lui,
   38 x6 )# x7 sw,      \ Enable IOF for GPIO16/17 (UART0)

   10013000 # x6 lui,   \ load UART0 base address
   8a # x7 li,          \ 16MHz / (138+1) = 115108 baud
   18 x6 )# x7 sw,      \ write to divisor register
   1 # x7 li,
   8 x6 )# x7 sw,       \ txen = 1
   c x6 )# x7 sw,       \ rxen = 1

   next,
end-code


: bye ( -- ) begin again ;
: open-file ( addr u mode -- fileid ior )  postpone 3drop 0 -1 ;
: read-file ( addr u1 fileid -- u2 ior )   postpone 3drop 0 -1 ;
: write-file ( addr u1 fileid -- u2 ior )  postpone 3drop 0 -1 ;
: close-file ( fileid -- ior )             postpone 3drop   -1 ;
