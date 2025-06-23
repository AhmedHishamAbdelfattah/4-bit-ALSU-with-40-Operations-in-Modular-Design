module Decrementer_Top_Module_TB () ;

parameter Delay = 10 ;

reg [3:0] A , B ;
reg Sel ;
wire [3:0] Out ;
wire Negative_Sign_Flag ;
integer error_count = 0 ;

Decrementer_Top_Module M1( .A ( A ) ,
                           .B ( B ) ,
                           .Sel ( Sel ) ,
                           .Out ( Out ) ,
                           .Negative_Sign_Flag ( Negative_Sign_Flag )
                         );

initial begin 
$monitor (" A : %b  (%0d)   ,  B : %b  (%0d)  , Sel : %b  (%0d)  , Out : %b  (%0d) , Sign : %b (%0d)",
            A  ,  A  , B  , B , Sel , Sel , Out , Out , Negative_Sign_Flag , Negative_Sign_Flag ) ;
end 

initial begin

// when Sel 0 for decrement of A 
run_test(4'b0000, 4'b0000, 1'b0, 4'b0001, 1'b1);
run_test(4'b0001, 4'b0000, 1'b0, 4'b0000, 1'b0);
run_test(4'b0010, 4'b0000, 1'b0, 4'b0001, 1'b0);
run_test(4'b0011, 4'b0000, 1'b0, 4'b0010, 1'b0);
run_test(4'b0100, 4'b0000, 1'b0, 4'b0011, 1'b0);
run_test(4'b0101, 4'b0000, 1'b0, 4'b0100, 1'b0);
run_test(4'b0110, 4'b0000, 1'b0, 4'b0101, 1'b0);
run_test(4'b0111, 4'b0000, 1'b0, 4'b0110, 1'b0);
run_test(4'b1000, 4'b0000, 1'b0, 4'b0111, 1'b0);
run_test(4'b1001, 4'b0000, 1'b0, 4'b1000, 1'b0);
run_test(4'b1010, 4'b0000, 1'b0, 4'b1001, 1'b0);
run_test(4'b1111, 4'b0000, 1'b0, 4'b1110, 1'b0);

// when Sel 1 for decrement of B 
run_test(4'b0000, 4'b0001, 1'b1, 4'b0000, 1'b0);
run_test(4'b0000, 4'b0000, 1'b1, 4'b0001, 1'b1);
run_test(4'b0000, 4'b0010, 1'b1, 4'b0001, 1'b0);
run_test(4'b0000, 4'b0011, 1'b1, 4'b0010, 1'b0);
run_test(4'b0000, 4'b0100, 1'b1, 4'b0011, 1'b0);
run_test(4'b0000, 4'b0101, 1'b1, 4'b0100, 1'b0);
run_test(4'b0000, 4'b0110, 1'b1, 4'b0101, 1'b0);
run_test(4'b0000, 4'b0111, 1'b1, 4'b0110, 1'b0);
run_test(4'b0000, 4'b1000, 1'b1, 4'b0111, 1'b0);
run_test(4'b0000, 4'b1001, 1'b1, 4'b1000, 1'b0);
run_test(4'b0000, 4'b1010, 1'b1, 4'b1001, 1'b0);
run_test(4'b0000, 4'b1111, 1'b1, 4'b1110, 1'b0);

if (error_count == 0) begin  
$display("All Cases Passes Successfully") ; 
end 
else begin
$display("there is %0d errors " , error_count); 
end 

$stop;

end 

task run_test (
   input [3:0] A_in , B_in ,
   input Sel_in ,
   input [3:0] Expected_Out ,
   input Expected_Sign 
);
  begin 
  
  A = A_in ;
  B = B_in ;
  Sel = Sel_in ;
  # Delay  
  if ((Out !== Expected_Out) && ( Negative_Sign_Flag !== Expected_Sign )) begin 
  $display("error at time %0t  when A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , Expected_Out = %b (%0d) , Gotten_Out = %b (%0d) , Expected Sign = %b (%0d) , Negative_Sign_Flag = %b (%0d) ",
            $time , A , A , B , B , Sel , Sel , Expected_Out , Expected_Out , Out , Out , Expected_Sign , Expected_Sign , Negative_Sign_Flag , Negative_Sign_Flag ) ;
            error_count = error_count + 1 ;
  end 
  else 
  $display ("PASS : A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) , Sign = %b (%0d)",
              A , A , B , B , Sel , Sel , Out , Out , Negative_Sign_Flag , Negative_Sign_Flag );
  end  
endtask 

endmodule 
