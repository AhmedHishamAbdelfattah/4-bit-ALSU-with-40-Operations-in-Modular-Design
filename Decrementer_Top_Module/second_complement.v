module second_complement (
  input [3:0] A ,
  output [3:0] A_New
);

assign A_New[0] = A[0] ^ 1'b0 ;
assign A_New[1] = A[1] ^ A[0] ;
assign A_New[2] = (A[1] | A[2]) ^ A[3] ;
assign A_New[3] = (A[0] | A[1] | A[2]) ^ A[3] ;

endmodule 
