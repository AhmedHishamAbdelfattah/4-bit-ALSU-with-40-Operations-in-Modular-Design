module Multiplexer_2_to_1 (
    input A , B , 
    input Sel ,
    output out 
);

assign out = ( Sel == 0 ) ?  A  :  B ;

endmodule 
