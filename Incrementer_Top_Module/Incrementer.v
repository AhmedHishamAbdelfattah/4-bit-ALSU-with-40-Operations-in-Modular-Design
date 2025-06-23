module Incrementer ( 
 input [3:0] A , B , 
 output [4:0] A_Inc , B_Inc  
);
four_bit_adder F1 ( .A ( A ) ,
                    .B ( 4'b0001 ) ,
                    .carry_in ( 1'b0 ) ,
                    .Sum ( A_Inc[3:0] ),
                    .carry_out ( A_Inc[4]) 
                 );

four_bit_adder F2 ( .A ( B ) ,
                    .B ( 4'b0001 ) ,
                    .carry_in ( 1'b0 ) ,
                    .Sum ( B_Inc[3:0] ),
                    .carry_out ( B_Inc[4] ) 
                 );


endmodule 
