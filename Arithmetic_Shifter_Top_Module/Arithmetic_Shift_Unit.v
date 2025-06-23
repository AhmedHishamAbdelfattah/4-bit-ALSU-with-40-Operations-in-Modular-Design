module Arithmetic_Shift_Unit (
    input  [3:0] A , B ,
    output [3:0] A_Arith_Right , B_Arith_Right , A_Arith_Left , B_Arith_Left
);

assign A_Arith_Right = A >>> 1 ;
assign A_Arith_Left  = A <<< 1 ;

assign B_Arith_Right = B >>> 1 ;
assign B_Arith_Left  = B <<< 1 ;

endmodule 
