module four_bit_multiplier (
 input [3:0] A , B ,
 output [7:0] out_multiplier
);

assign out_multiplier[0] = A[0] & B[0] ;
 
wire [4:0] Multiplication_Sec_Out_one ;

four_bit_adder F1 (.A  ({ 1'b0 , (A[3] & B[0]) , (A[2] & B[0]) , (A[1]&B[0]) }) ,
                   .B  ({ (A[3] & B[1]) , (A[2] & B[1]) , (A[1] & B[1]) , (A[0]&B[1]) }) ,
                   .carry_in (1'b0) ,
                   .Sum (Multiplication_Sec_Out_one[3:0]) ,
                   .carry_out (Multiplication_Sec_Out_one[4]) ) ;

assign out_multiplier[1] = Multiplication_Sec_Out_one[0] ;

wire [4:0] Multiplication_Sec_Out_two ;

four_bit_adder F2 (.A  (Multiplication_Sec_Out_one[4:1]) ,
                   .B  ({ (A[3] & B[2]) , (A[2] & B[2]) , (A[1] & B[2]) , (A[0]&B[2]) }) ,
                   .carry_in (1'b0) ,
                   .Sum (Multiplication_Sec_Out_two[3:0]) ,
                   .carry_out (Multiplication_Sec_Out_two[4]) ) ;

assign out_multiplier[2] = Multiplication_Sec_Out_two[0] ;

wire [4:0] Multiplication_Sec_Out_three ;

four_bit_adder F3 (.A  (Multiplication_Sec_Out_two[4:1]) ,
                   .B  ({ (A[3] & B[3]) , (A[2] & B[3]) , (A[1] & B[3]) , (A[0]&B[3]) }) ,
                   .carry_in (1'b0) ,
                   .Sum (Multiplication_Sec_Out_three[3:0]) ,
                   .carry_out (Multiplication_Sec_Out_three[4]) ) ;

assign out_multiplier[7:3] = Multiplication_Sec_Out_three ;

endmodule
