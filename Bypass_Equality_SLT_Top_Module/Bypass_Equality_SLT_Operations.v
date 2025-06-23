module Bypass_Equality_SLT_Operations (
  input [3:0] A , B , 
  output [3:0] Out_1 , Out_2 , Out_3 , Out_4  
);

wire Smaller , Equal ;

four_bit_comparator Comp_1 ( .A( A ),
                             .B( B ),
                             .S( Smaller ),
                             .Eq( Equal )
                           ); 
  assign Out_1 =  A ;
  assign Out_2 =  B ;
  assign Out_3 =  { 3'b000 , Equal } ;
  assign Out_4 =  { 3'b000 , Smaller } ;
  
endmodule 
