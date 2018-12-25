code cold
   here entry-point

   hex
   ' sp0 >body # x5 lui,
   ' sp0 >body # x5 x5 addi,
   x5 ) S lw,

   ' rp0 >body # x5 lui,
   ' rp0 >body # x5 x5 addi,
   x5 ) R lw,

   ' turnkey # T lui,
   ' turnkey # T T addi,
   4 T )# W lw,
   execute,
   decimal
end-code

latest ' latest0 >body !

\ Start of image.
load-address ' image0 >body !

\ Start of free dictionary.
vhere ' dp0 >body !

\ Allocate space for dictionary and stacks.
vhere
   decimal
   3600 cells vallot  vhere ' limit >body !
     64 cells vallot  vhere ' sp0 >body !
    128 cells vallot  vhere ' rp0 >body !
vhere - dup vallot negate extra-bytes
