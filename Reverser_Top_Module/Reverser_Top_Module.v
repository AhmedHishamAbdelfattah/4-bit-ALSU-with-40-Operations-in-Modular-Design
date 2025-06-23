module Reverser_Top_Module (
   input [3:0] A , B , 
   input Sel ,
   output [3:0] Out  
);
 
wire [3:0] A_Rev , B_Rev ;  

Reverser R1 ( .A( A ) ,
              .B( B ) ,
              .A_Rev( A_Rev ) ,
              .B_Rev( B_Rev )  
            ); 
Mux_2_to_1_four_bits Mux_1 ( .A ( A_Rev ) , 
                             .B ( B_Rev ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

endmodule 
