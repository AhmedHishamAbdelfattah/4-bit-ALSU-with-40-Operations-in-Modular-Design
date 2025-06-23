module Carry_Out_Adder_Handling (
  input [3:0] Sel ,
  input Carry_Out_From_Adder ,
  output reg Carry_Out_Handled  
);
always@(*) begin 
if(Sel == 4'b0001) begin 
Carry_Out_Handled = 0 ;
end
else if(Sel == 4'b0000)begin 
Carry_Out_Handled = Carry_Out_From_Adder ;
end
end
endmodule 
