module Carry_Out_Handling (
   input [3:0] Sel ,
   input Carry_Out_From_Adder_Top_Module ,
   input Carry_Out_From_Incrementer_Top_Module ,
   output reg Carry_Out 
);

always@(*)begin 
if(Sel == 5'b0000 ) begin 
Carry_Out = Carry_Out_From_Adder_Top_Module ;
end
else if(Sel == 5'b1110) begin 
Carry_Out = Carry_Out_From_Incrementer_Top_Module ;
end
else begin
Carry_Out = 1'b0 ;  
end
end
endmodule 
