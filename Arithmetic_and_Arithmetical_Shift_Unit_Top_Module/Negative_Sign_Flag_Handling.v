module Negative_Sign_Handling(
   input [3:0] Sel ,
   input Negative_Sign_Adder_Flag ,
   input Negative_Sign_Decrementer_Flag ,
   output reg Negative_sign_Flag
);

always@(*)begin
if(Sel == 4'b1100)begin
Negative_sign_Flag = Negative_Sign_Decrementer_Flag ;
end 
else if(Sel == 4'b0000) begin
Negative_sign_Flag = Negative_Sign_Adder_Flag ;
end
else begin
Negative_sign_Flag = 1'b0 ; 
end
end

endmodule 
