module Arithmetic_Shift_Top_Module (
    input [3:0] A , B ,
    input [1:0] Sel ,
    output [3:0] out 
);

wire  [3:0] A_Arith_Right , B_Arith_Right , A_Arith_Left , B_Arith_Left ;

Arithmetic_Shift_Unit A1 ( .A ( A ) ,
                           .B ( B ) ,
                           .A_Arith_Right ( A_Arith_Right ) ,
                           .B_Arith_Right ( B_Arith_Right ) ,
                           .A_Arith_Left  ( A_Arith_Left  ) ,
                           .B_Arith_Left  ( B_Arith_Left  )
                         );

Mux_4_to_1 M1 ( .A ( A_Arith_Right ) ,
                .B ( A_Arith_Left ) ,
                .C ( B_Arith_Right ) ,
                .D ( B_Arith_Left  ),
                .Sel ( Sel ) ,
                .out ( out ) 
             );

endmodule 
