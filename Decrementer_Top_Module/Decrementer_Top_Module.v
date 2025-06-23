module Decrementer_Top_Module (
      input [3:0] A , B ,
      input Sel ,
      output [3:0] Out ,
      output Negative_Sign_Flag
);

wire [3:0] Total_Sum_A , Total_Sum_B ;
wire neg_Falg_A , neg_Flag_B ;

Decrementer D1( .A ( A ) ,
                .B ( B ) ,
                .A_Dec ( Total_Sum_A ) ,
                .B_Dec ( Total_Sum_B ) ,
                .Negative_Sign_Flag_A ( neg_Falg_A ) , 
                .Negative_Sign_Flag_B ( neg_Flag_B )
              );

Mux_2_to_1_four_bits Mux_1 ( .A ( Total_Sum_A ) , 
                             .B ( Total_Sum_B ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

Mux_2_to_1_one_bit M_1 ( .A( neg_Falg_A ) , 
                         .B( neg_Flag_B ) , 
                         .Sel( Sel ) ,
                         .Out( Negative_Sign_Flag ) 
                       );

endmodule 
