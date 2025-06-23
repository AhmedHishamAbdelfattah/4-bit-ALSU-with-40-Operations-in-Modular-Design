module Logic_Shift_Rotate_Operations (
  input [3:0] A , B , 
  output [3:0] Out_1 , Out_2 , Out_3 , Out_4 , Out_5 , Out_6 , Out_7 , Out_8 
);

  assign Out_1 =  { 1'b0 , A[3:1] } ;
  assign Out_2 =  { A[2:0] , 1'b0 } ;
  assign Out_3 =  { 1'b0 , B[3:1] } ;
  assign Out_4 =  { B[2:0] , 1'b0 } ;

  assign Out_5 =  { A[0] , A[3:1] } ;
  assign Out_6 =  { A[2:0] , A[3] } ;
  assign Out_7 =  { B[0] , B[3:1] } ;
  assign Out_8 =  { B[2:0] , B[3] } ;
  
endmodule 
