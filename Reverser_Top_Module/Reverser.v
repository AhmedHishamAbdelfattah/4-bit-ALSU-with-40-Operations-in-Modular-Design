module Reverser(
   input [3:0] A , B ,
   output [3:0] A_Rev , B_Rev  
); 

 assign A_Rev = {A[0] , A[1] , A[2] , A[3]} ;
 assign B_Rev = {B[0] , B[1] , B[2] , B[3]} ;

endmodule 
