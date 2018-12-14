get-current
also assembler definitions

[undefined] code-offset [if]
include targets/riscv/params.fth
[then]

\ Register allocation.  x10-x17 are used in Linux syscalls.
: S   x20 ;  \ s4
: R   x21 ;  \ s5
: I   x22 ;  \ s6
: W   x23 ;  \ s7
: T   x24 ;  \ s8

\ Macros.
: op>r     postpone >r postpone 2>r ; compile-only
: opr>     postpone 2r> postpone r> ; compile-only
: fetch,   op>r I ) opr> lw,  4 # I I addi, ;
: pop,     op>r S ) opr> lw,  4 # S S addi, ;
: push,    op>r -4 # S S addi,  S ) opr> sw, ;
: rpop,    op>r R ) opr> lw,  4 # R R addi, ;
: rpush,   op>r -4 # R R addi,  R ) opr> sw, ;
: execute,   W ) T lw,  T ) jr, ;


\ Next.
: next,   W fetch,  execute, ;

previous
set-current
