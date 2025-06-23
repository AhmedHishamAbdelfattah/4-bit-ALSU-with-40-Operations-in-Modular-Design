module Multiplier_Top_Module (
     input [3:0] A , B ,
     input Sel ,
     output [3:0] Out 
);

wire [7:0] Temp ;

four_bit_multiplier Mul_1 ( .A ( A ) , 
                            .B ( B ) ,
                            .out_multiplier ( Temp )
                          );

Mux_2_to_1_four_bits Mux_1 ( .A ( Temp[3:0] ) , 
                             .B ( Temp[7:4] ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

endmodule 
