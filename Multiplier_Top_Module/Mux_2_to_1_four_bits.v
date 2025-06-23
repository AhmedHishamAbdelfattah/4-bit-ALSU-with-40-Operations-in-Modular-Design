module Mux_2_to_1_four_bits (
    input [3:0] A , B ,
    input Sel ,
    output [3:0] Out
);

assign Out = ( Sel == 0 ) ? A : B ;

endmodule 
