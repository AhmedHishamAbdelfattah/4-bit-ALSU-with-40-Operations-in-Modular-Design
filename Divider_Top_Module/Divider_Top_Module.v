module Divider_Top_Module (
    input [3:0] A , B ,
    input Sel ,
    output [3:0] Out 
);

wire [3:0] Quotient , Remainder ;

four_bit_divider Div_1 ( .A ( A ) ,
                         .B ( B ) ,
                         .Q (Quotient) ,
                         .R (Remainder) 
                       );

Mux_2_to_1_four_bits Mux_2 ( .A ( Quotient ) , 
                             .B ( Remainder ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

endmodule 
