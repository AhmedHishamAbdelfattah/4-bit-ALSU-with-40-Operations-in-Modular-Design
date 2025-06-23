module four_bit_adder (
       input [3:0] A , B ,
       input carry_in ,
       output [3:0] Sum ,
       output carry_out 
);

wire [0:2] carry_int ;

full_adder f1 ( A[0] , B[0] , carry_in     , Sum[0] , carry_int[0] ) ;
full_adder f2 ( A[1] , B[1] , carry_int[0] , Sum[1] , carry_int[1] ) ;
full_adder f3 ( A[2] , B[2] , carry_int[1] , Sum[2] , carry_int[2] ) ;
full_adder f4 ( A[3] , B[3] , carry_int[2] , Sum[3] , carry_out    ) ;

endmodule 
