module ALSU_Top_Module (
  input [3:0] A , B , 
  input [5:0] Sel ,
  output [3:0] Out ,
  output Carry_Out ,
  output Negative_Sign_Flag 
);

wire [3:0] Out_1 , Out_2 ;

Arithmetic_Block_Top_Module T_1( .A( A ) ,
                                 .B( B ) ,
                                 .Sel( Sel[4:0] ) ,
                                 .Out( Out_1 ) ,
                                 .Carry_Out( Carry_Out ) ,
                                 .Negative_Sign_Flag( Negative_Sign_Flag )
); 

Logic_Logical_Shift_Unit_Top_Module T_2 ( .A( A ) ,
                                          .B( B ) ,
                                          .Sel( Sel[4:0] ) ,
                                          .Out( Out_2 )
                                        );

Mux_2_to_1_four_bits Mux_1 ( .A ( Out_1 ) , 
                             .B ( Out_2 ),
                             .Sel ( Sel[5] ) , 
                             .Out ( Out )
                           );


endmodule
