module Reverser_Top_Module_TB () ;

   reg [3:0] A , B ; 
   reg Sel ;
   wire [3:0] Out ;  
   integer error_count = 0 ;

   Reverser_Top_Module R1 ( .A ( A ) ,
                         .B ( B ) , 
                         .Sel ( Sel ) ,
                         .Out ( Out ) 
                       );
    initial begin  
    $monitor("Time = %0t  : A = %b (%0d) : B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) " ,
                     $time , A , A , B , B , Sel , Sel , Out , Out ) ; 
    end 

    initial begin 
     
    // when Sel is 0 which indicates the reverse of A :
    run_test (4'b0001, 4'b0000, 1'b0, 4'b1000); // Reverse of 0001 = 1000
    run_test (4'b0010, 4'b0000, 1'b0, 4'b0100); // Reverse of 0010 = 0100
    run_test (4'b0100, 4'b0000, 1'b0, 4'b0010); // Reverse of 0100 = 0010
    run_test (4'b1000, 4'b0000, 1'b0, 4'b0001); // Reverse of 1000 = 0001
    run_test (4'b1100, 4'b0000, 1'b0, 4'b0011); // Reverse of 1100 = 0011
    run_test (4'b1010, 4'b0000, 1'b0, 4'b0101); // Reverse of 1010 = 0101
    run_test (4'b1111, 4'b0000, 1'b0, 4'b1111); // Reverse of 1111 = 1111
    run_test (4'b0011, 4'b0000, 1'b0, 4'b1100); // Reverse of 0011 = 1100
    run_test (4'b0110, 4'b0000, 1'b0, 4'b0110); // Reverse of 0110 = 0110
    run_test (4'b1001, 4'b0000, 1'b0, 4'b1001); // Reverse of 1001 = 1001
    run_test (4'b0111, 4'b0000, 1'b0, 4'b1110); // Reverse of 0111 = 1110


    // when Sel is 1 which indicates the reverse of B :
    run_test (4'b0000, 4'b0001, 1'b1, 4'b1000); // Reverse of 0001 = 1000
    run_test (4'b0000, 4'b0010, 1'b1, 4'b0100); // Reverse of 0010 = 0100
    run_test (4'b0000, 4'b0100, 1'b1, 4'b0010); // Reverse of 0100 = 0010
    run_test (4'b0000, 4'b1000, 1'b1, 4'b0001); // Reverse of 1000 = 0001
    run_test (4'b0000, 4'b1100, 1'b1, 4'b0011); // Reverse of 1100 = 0011
    run_test (4'b0000, 4'b1010, 1'b1, 4'b0101); // Reverse of 1010 = 0101
    run_test (4'b0000, 4'b1111, 1'b1, 4'b1111); // Reverse of 1111 = 1111
    run_test (4'b0000, 4'b0011, 1'b1, 4'b1100); // Reverse of 0011 = 1100
    run_test (4'b0000, 4'b0110, 1'b1, 4'b0110); // Reverse of 0110 = 0110
    run_test (4'b0000, 4'b1001, 1'b1, 4'b1001); // Reverse of 1001 = 1001
    run_test (4'b0000, 4'b0111, 1'b1, 4'b1110); // Reverse of 0111 = 1110
    
    if ( error_count == 0 ) begin 
    $display("All Cases Passes") ;
    end 
    else begin 
    $display("Test Completed with %0d errors " , error_count ) ;
    end

    $stop ;

    end                    

   task run_test (
        input [3:0] A_in , B_in , 
        input Sel_in ,
        input [3:0] Expected_Out
   );   
     begin 
      
      A = A_in ;
      B = B_in ;
      Sel = Sel_in ;
      # 10 ;
      if ( Out !== Expected_Out ) begin 
      $display ("Error at time %0t : A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , expected_Out = %b (%0d) , gotten Out = %b (%0d) " ,
                $time , A , A , B , B , Sel , Sel, Expected_Out , Expected_Out , Out , Out ) ;
       error_count = error_count + 1 ;
      end 
      else begin  
      $display ("PASS : A = %b (%0d)  , B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) " ,
                       A , A , B , B , Sel , Sel , Out , Out) ;
      end    
     end  
   endtask                     
endmodule 
