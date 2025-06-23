module Incrementer_Top_Module (
   input [3:0] A , B ,
   input Sel ,
   output [3:0] Out ,
   output Carry_Out_Inc  
);

wire [3:0] A_INC , B_INC ;
wire Carry_A_Inc , Carry_B_Inc ;

Incrementer Inc_1( .A ( A ) ,
                   .B ( B ) , 
                   .A_Inc ( { Carry_A_Inc , A_INC } ) ,
                   .B_Inc ( { Carry_B_Inc , B_INC } ) 
                 );
Mux_2_to_1_four_bits Mux_1 ( .A ( A_INC ) , 
                             .B ( B_INC ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

Mux_2_to_1_one_bit Mux_2 ( .A( Carry_A_Inc ) , 
                           .B( Carry_B_Inc ) , 
                           .Sel( Sel ) ,
                           .Out( Carry_Out_Inc ) 
                         );
endmodule
