module Negative_Sign_Adder_Handling(
  input Carry_Out_From_Adder_Handling_Carry_Out ,
  input Sel ,
  output reg Negative_Sign_Flag_Adder   
);
always@(*) begin
if(Sel == 1'b0)begin
  Negative_Sign_Flag_Adder = 1'b0 ;
end
else begin
  if(Carry_Out_From_Adder_Handling_Carry_Out == 1'b1)begin
  Negative_Sign_Flag_Adder = 1'b0 ;
  end
  else begin 
  Negative_Sign_Flag_Adder = 1'b1 ;
  end
end
end

endmodule
