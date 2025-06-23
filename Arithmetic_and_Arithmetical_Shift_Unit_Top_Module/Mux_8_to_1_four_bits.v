module Mux_8_to_1_four_bits (
  input [3:0] A , B , C , D , E , F , G , H ,
  input [3:0] Sel ,
  output reg [3:0] Out 
); 
always@(*) begin 
if ( ( Sel == 4'b0000 ) || ( Sel == 4'b0001) ) 
 Out = A ;
else if ( Sel == 4'b0010 ) 
 Out = B ;
else if ( Sel == 4'b0110 )
 Out = C ;
else if ( Sel == 4'b1010 ) 
 Out = D ;
else if ( (Sel == 4'b0101) || (Sel == 4'b0111) )
 Out = E ;
else if ( Sel == 4'b1000 )
 Out = F ;
else if ( Sel == 4'b1110 )
 Out = G ;
else if ( Sel == 4'b1100 )
 Out = H ;       
end 
endmodule
