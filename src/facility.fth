( Facility words. )

\ Print a "Control Sequence Introducer"
: CSI ( -- ) 27 emit ." [" ;

\ Position the cursor at XY (zero-based)
?: at-xy ( x y -- ) CSI 1+ (.)  [char] ; emit  1+ (.)  [char] H emit ;

\ Clear the screen
?: page ( -- ) CSI [char] H emit  CSI [char] J emit ;

\ key?


( Facility extension words. )

\ ekey
\ ekey>char
\ ekey?
\ emit?
\ ms
\ time&date
