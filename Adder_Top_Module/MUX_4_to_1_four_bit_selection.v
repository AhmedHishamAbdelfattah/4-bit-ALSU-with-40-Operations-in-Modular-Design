module Mux_4_to_1 (
    input [3:0] A , B , C , D ,
    input [1:0] Sel ,
    output reg [3:0] out 
);

always @ (*) begin 

case(Sel)
2'b00 : out = A ;
2'b01 : out = B ;
2'b10 : out = C ;
2'b11 : out = D ;
endcase  

end

endmodule 
