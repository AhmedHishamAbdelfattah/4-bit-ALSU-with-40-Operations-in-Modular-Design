module Bypass_Equality_SLT_Top_Module (
   input [3:0] A , B , 
   input [1:0] Sel , 
   output [3:0] Out 
);

wire [3:0] Out_1 , Out_2 , Out_3 , Out_4 ;  

Bypass_Equality_SLT_Operations B_P_1 (.A( A ) ,
                                      .B( B ) , 
                                      .Out_1( Out_1 ) ,
                                      .Out_2( Out_2 ) ,
                                      .Out_3( Out_3 ) ,
                                      .Out_4( Out_4 )  
                                     );

Mux_4_to_1 M_2 (.A   ( Out_1 )  ,
                .B   ( Out_2 ) ,
                .C   ( Out_3 ) ,
                .D   ( Out_4 )  ,
                .Sel ( Sel ) ,
                .out ( Out ) 
               );

endmodule
