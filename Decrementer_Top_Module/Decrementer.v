module Decrementer (
   input [3:0] A , B ,
   output [3:0] A_Dec , B_Dec ,
   output Negative_Sign_Flag_A , Negative_Sign_Flag_B
);

wire [3:0] A_Dec_Sec_1 , B_Dec_Sec_1 ;
wire [3:0] A_Dec_Sec_2 , B_Dec_Sec_2 ;
wire Carry_Out_A , Carry_Out_B ;

four_bit_adder F1 ( .A ( A ) ,
                    .B ( 4'b1110 ) ,
                    .carry_in ( 1'b1 ) ,
                    .Sum ( A_Dec_Sec_1 ),
                    .carry_out ( Carry_Out_A ) 
                 );

four_bit_adder F2 ( .A ( B ) ,
                    .B ( 4'b1110 ) ,
                    .carry_in ( 1'b1 ) ,
                    .Sum ( B_Dec_Sec_1 ),
                    .carry_out ( Carry_Out_B ) 
                 );

second_complement SC1( .A ( A_Dec_Sec_1 ) ,
                       .A_New ( A_Dec_Sec_2 )
                     );

second_complement SC2( .A ( B_Dec_Sec_1 ) ,
                       .A_New ( B_Dec_Sec_2 )
                     );

assign Negative_Sign_Flag_A = ~ ( Carry_Out_A ) ;
assign Negative_Sign_Flag_B = ~ ( Carry_Out_B ) ;

Mux_2_to_1_four_bits Mux_1 ( .A ( A_Dec_Sec_2 ) , 
                             .B ( A_Dec_Sec_1 ),
                             .Sel ( Carry_Out_A ) , 
                             .Out ( A_Dec )
                           );

Mux_2_to_1_four_bits Mux_2 ( .A ( B_Dec_Sec_2 ) , 
                             .B ( B_Dec_Sec_1 ),
                             .Sel ( Carry_Out_B ) , 
                             .Out ( B_Dec )
                           );

endmodule 
