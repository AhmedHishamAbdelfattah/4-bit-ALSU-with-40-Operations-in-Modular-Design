module Mux_8_to_1 (
    input [3:0] A , B , C , D , E , F , G , H ,
    input [2:0] Sel ,
    output reg [3:0] out 
);

always @ (*) begin 

case(Sel)

3'b000 : out = A ;
3'b001 : out = B ;
3'b010 : out = C ;
3'b011 : out = D ;
3'b100 : out = E ;
3'b101 : out = F ;
3'b110 : out = G ;
3'b111 : out = H ;

endcase  

end

endmodule 
