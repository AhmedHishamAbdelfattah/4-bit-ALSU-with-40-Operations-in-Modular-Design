module Bypass_Equality_SLT_Top_Module_TB () ;

   reg [3:0] A , B ; 
   reg [1:0] Sel ;
   wire [3:0] Out ;  
   integer error_count = 0 ;

   Bypass_Equality_SLT_Top_Module R1 ( .A ( A ) ,
                                       .B ( B ) , 
                                       .Sel ( Sel ) ,
                                       .Out ( Out ) 
                                     );

    initial begin  
    $monitor("Time = %0t  : A = %b (%0d) : B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) " ,
                     $time , A , A , B , B , Sel , Sel , Out , Out ) ; 
    end 

    initial begin 
     
    // when Sel is 00 which now indicates Output = A
    run_test (4'b0001, 4'b0000, 2'b00, 4'b0001); // Output = A = 0001
    run_test (4'b0010, 4'b0000, 2'b00, 4'b0010); // Output = A = 0010
    run_test (4'b0100, 4'b0000, 2'b00, 4'b0100); // Output = A = 0100
    run_test (4'b1000, 4'b0000, 2'b00, 4'b1000); // Output = A = 1000
    run_test (4'b1100, 4'b0000, 2'b00, 4'b1100); // Output = A = 1100
    run_test (4'b1010, 4'b0000, 2'b00, 4'b1010); // Output = A = 1010
    run_test (4'b1111, 4'b0000, 2'b00, 4'b1111); // Output = A = 1111
    run_test (4'b0011, 4'b0000, 2'b00, 4'b0011); // Output = A = 0011
    run_test (4'b0110, 4'b0000, 2'b00, 4'b0110); // Output = A = 0110
    run_test (4'b1001, 4'b0000, 2'b00, 4'b1001); // Output = A = 1001
    run_test (4'b0111, 4'b0000, 2'b00, 4'b0111); // Output = A = 0111

    // when Sel is 01 which now indicates Output = B, A is constant
    run_test (4'b0000, 4'b0001, 2'b01, 4'b0001); // Output = B = 0001
    run_test (4'b0000, 4'b0010, 2'b01, 4'b0010); // Output = B = 0010
    run_test (4'b0000, 4'b0100, 2'b01, 4'b0100); // Output = B = 0100
    run_test (4'b0000, 4'b1000, 2'b01, 4'b1000); // Output = B = 1000
    run_test (4'b0000, 4'b1100, 2'b01, 4'b1100); // Output = B = 1100
    run_test (4'b0000, 4'b1010, 2'b01, 4'b1010); // Output = B = 1010
    run_test (4'b0000, 4'b1111, 2'b01, 4'b1111); // Output = B = 1111
    run_test (4'b0000, 4'b0011, 2'b01, 4'b0011); // Output = B = 0011
    run_test (4'b0000, 4'b0110, 2'b01, 4'b0110); // Output = B = 0110
    run_test (4'b0000, 4'b1001, 2'b01, 4'b1001); // Output = B = 1001
    run_test (4'b0000, 4'b0111, 2'b01, 4'b0111); // Output = B = 0111

    // when Sel is 10 which now indicates: Output = 0001 if A == B else 0000
    run_test (4'b1000, 4'b1000, 2'b10, 4'b0001); // A == B → 0001
    run_test (4'b0100, 4'b0000, 2'b10, 4'b0000); // A != B → 0000
    run_test (4'b0010, 4'b0010, 2'b10, 4'b0001); // A == B → 0001
    run_test (4'b0001, 4'b1000, 2'b10, 4'b0000); // A != B → 0000
    run_test (4'b0011, 4'b0011, 2'b10, 4'b0001); // A == B → 0001
    run_test (4'b0101, 4'b1010, 2'b10, 4'b0000); // A != B → 0000
    run_test (4'b0000, 4'b0000, 2'b10, 4'b0001); // A == B → 0001
    run_test (4'b1100, 4'b0011, 2'b10, 4'b0000); // A != B → 0000
    run_test (4'b1001, 4'b1001, 2'b10, 4'b0001); // A == B → 0001
    run_test (4'b0010, 4'b1000, 2'b10, 4'b0000); // A != B → 0000
    run_test (4'b0100, 4'b0100, 2'b10, 4'b0001); // A == B → 0001

    // when Sel is 11 which now indicates: Output = 0001 if A < B, else 0000
    run_test (4'b0000, 4'b0001, 2'b11, 4'b0001); // 0 < 1 → 0001
    run_test (4'b0000, 4'b0010, 2'b11, 4'b0001); // 0 < 2 → 0001
    run_test (4'b0000, 4'b0100, 2'b11, 4'b0001); // 0 < 4 → 0001
    run_test (4'b0000, 4'b1000, 2'b11, 4'b0001); // 0 < 8 → 0001
    run_test (4'b0000, 4'b1100, 2'b11, 4'b0001); // 0 < 12 → 0001
    run_test (4'b0000, 4'b1010, 2'b11, 4'b0001); // 0 < 10 → 0001
    run_test (4'b0000, 4'b1111, 2'b11, 4'b0001); // 0 < 15 → 0001
    run_test (4'b0000, 4'b0011, 2'b11, 4'b0001); // 0 < 3 → 0001
    run_test (4'b0000, 4'b0110, 2'b11, 4'b0001); // 0 < 6 → 0001
    run_test (4'b0000, 4'b1001, 2'b11, 4'b0001); // 0 < 9 → 0001
    run_test (4'b0000, 4'b0111, 2'b11, 4'b0001); // 0 < 7 → 0001
    run_test (4'b1000, 4'b0100, 2'b11, 4'b0000); // 8 > 4 → 0000
    run_test (4'b0111, 4'b0111, 2'b11, 4'b0000); // 7 == 7 → 0000
    run_test (4'b1100, 4'b0011, 2'b11, 4'b0000); // 12 > 3 → 0000
    run_test (4'b1111, 4'b1111, 2'b11, 4'b0000); // 15 == 15 → 0000

    if ( error_count == 0 ) begin 
    $display("All Cases Passes") ;
    end 
    else begin 
    $display("Test Completed with %0d errors" , error_count ) ;
    end

    $stop ;

    end                    

   task run_test (
        input [3:0] A_in , B_in , 
        input [1:0] Sel_in ,
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
