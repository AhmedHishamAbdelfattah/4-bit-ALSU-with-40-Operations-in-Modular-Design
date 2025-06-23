module Incrementer_Top_Module_TB () ;
  
  parameter Delay = 10 ;
  
   reg [3:0] A , B ;
   reg Sel ;
   wire [3:0] Out ;
   wire Carry_Out_Inc ;
   integer error_count = 0  ;

   Incrementer_Top_Module M_1 ( .A( A ) ,
                                .B( B ) ,
                                .Sel( Sel ) ,
                                .Out( Out ) ,
                                .Carry_Out_Inc( Carry_Out_Inc )  
                              );
   initial begin 
   $monitor("A : %b (%0d) , B : %b (%0d) , Sel : %b (%0d) , Out : %b (%0d) , Carry_Out_Inc : %b (%0d)" ,
             A , A , B , B , Sel , Sel , Out , Out , Carry_Out_Inc , Carry_Out_Inc ) ;
   end 
   
   initial begin 

   // Testing Incremneter for A when Sel = 0
  run_test (4'b0000, 4'b0000, 4'b0, 4'b0001, 4'b0);
  run_test (4'b0001, 4'b0000, 4'b0, 4'b0010, 4'b0);
  run_test (4'b0010, 4'b0000, 4'b0, 4'b0011, 4'b0);
  run_test (4'b0100, 4'b0000, 4'b0, 4'b0101, 4'b0);
  run_test (4'b0101, 4'b0000, 4'b0, 4'b0110, 4'b0);
  run_test (4'b0111, 4'b0000, 4'b0, 4'b1000, 4'b0);
  run_test (4'b0110, 4'b0000, 4'b0, 4'b0111, 4'b0);
  run_test (4'b1000, 4'b0000, 4'b0, 4'b1001, 4'b0);
  run_test (4'b1010, 4'b0000, 4'b0, 4'b1011, 4'b0);
  run_test (4'b1011, 4'b0000, 4'b0, 4'b1100, 4'b0);
  run_test (4'b1111, 4'b0000, 4'b0, 4'b0000, 4'b1);
  run_test (4'b1100, 4'b0000, 4'b0, 4'b1101, 4'b0);
  run_test (4'b1101, 4'b0000, 4'b0, 4'b1110, 4'b0);
  run_test (4'b0011, 4'b0000, 4'b0, 4'b0100, 4'b0);
  
  // Testing Incremneter for B when Sel = 1
  run_test (4'b0000, 4'b0000, 4'b1, 4'b0001, 4'b0);
  run_test (4'b0000, 4'b0001, 4'b1, 4'b0010, 4'b0);
  run_test (4'b0000, 4'b0010, 4'b1, 4'b0011, 4'b0);
  run_test (4'b0000, 4'b0100, 4'b1, 4'b0101, 4'b0);
  run_test (4'b0000, 4'b0101, 4'b1, 4'b0110, 4'b0);
  run_test (4'b0000, 4'b0111, 4'b1, 4'b1000, 4'b0);
  run_test (4'b0000, 4'b0110, 4'b1, 4'b0111, 4'b0);
  run_test (4'b0000, 4'b1000, 4'b1, 4'b1001, 4'b0);
  run_test (4'b0000, 4'b1010, 4'b1, 4'b1011, 4'b0);
  run_test (4'b0000, 4'b1011, 4'b1, 4'b1100, 4'b0);
  run_test (4'b0000, 4'b1111, 4'b1, 4'b0000, 4'b1);
  run_test (4'b0000, 4'b1100, 4'b1, 4'b1101, 4'b0);
  run_test (4'b0000, 4'b1101, 4'b1, 4'b1110, 4'b0);
  run_test (4'b0000, 4'b0011, 4'b1, 4'b0100, 4'b0);


   if (error_count == 0) begin 
   $display("All Cases Passes Successfully");
   end 
   else begin 
   $display("There are %0d errors" , error_count);
   end 

   $stop ;
   end  
   
   task run_test (
      input [3:0] A_in , B_in ,
      input Sel_in ,
      input [3:0] Expected_Out ,
      input Expected_Carry_Out  
   ); 
   begin

    A = A_in ;
    B = B_in ;
    Sel = Sel_in ;
    #Delay 
   
    if ((Out !== Expected_Out) && (Carry_Out_Inc !== Expected_Carry_Out))
    begin
    $display("Error at time : %0t , A : %b , B : %b (%0d) , Sel : %b (%0d) , Expected_Out : %b (%0d) , Gotten Out : %b (%0d)" ,
                A , A , B , B , Sel , Sel , Expected_Out , Expected_Out , Out , Out ) ;
            error_count = error_count + 1 ;    
    end 
    else begin
      $display("PASS : A = %b (%d) , B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d)" ,
                A , A , B , B , Sel , Sel , Out , Out ) ; 
    end 
   end
   endtask

endmodule 
