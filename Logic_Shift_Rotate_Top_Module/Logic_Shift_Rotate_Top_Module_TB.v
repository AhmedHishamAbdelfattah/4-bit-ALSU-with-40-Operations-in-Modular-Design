module Logic_Shift_Rotate_Top_Module_TB () ;

   reg [3:0] A , B ; 
   reg [2:0] Sel ;
   wire [3:0] Out ;  
   integer error_count = 0 ;

   Logic_Shift_Rotate_Top_Module R1 (  .A ( A ) ,
                                       .B ( B ) , 
                                       .Sel ( Sel ) ,
                                       .Out ( Out ) 
                                     );

    initial begin  
    $monitor("Time = %0t  : A = %b (%0d) : B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) " ,
                     $time , A , A , B , B , Sel , Sel , Out , Out ) ; 
    end 

    initial begin 
     
    // when Sel is 000 which now indicates Logical Shift Right of A
    run_test (4'b0001, 4'b0000, 3'b000, 4'b0000); // 0001 >> 1 = 0000
    run_test (4'b0010, 4'b0000, 3'b000, 4'b0001); // 0010 >> 1 = 0001
    run_test (4'b0100, 4'b0000, 3'b000, 4'b0010); // 0100 >> 1 = 0010
    run_test (4'b1000, 4'b0000, 3'b000, 4'b0100); // 1000 >> 1 = 0100
    run_test (4'b1100, 4'b0000, 3'b000, 4'b0110); // 1100 >> 1 = 0110
    run_test (4'b1010, 4'b0000, 3'b000, 4'b0101); // 1010 >> 1 = 0101
    run_test (4'b1111, 4'b0000, 3'b000, 4'b0111); // 1111 >> 1 = 0111
    run_test (4'b0011, 4'b0000, 3'b000, 4'b0001); // 0011 >> 1 = 0001
    run_test (4'b0110, 4'b0000, 3'b000, 4'b0011); // 0110 >> 1 = 0011
    run_test (4'b1001, 4'b0000, 3'b000, 4'b0100); // 1001 >> 1 = 0100
    run_test (4'b0111, 4'b0000, 3'b000, 4'b0011); // 0111 >> 1 = 0011

    // when Sel is 001 which now indicates Logical Shift Left of A, B is constant
    run_test (4'b0001, 4'b0000, 3'b001, 4'b0010); // 0001 << 1 = 0010
    run_test (4'b0010, 4'b0000, 3'b001, 4'b0100); // 0010 << 1 = 0100
    run_test (4'b0100, 4'b0000, 3'b001, 4'b1000); // 0100 << 1 = 1000
    run_test (4'b1000, 4'b0000, 3'b001, 4'b0000); // 1000 << 1 = 0000 (overflow)
    run_test (4'b1100, 4'b0000, 3'b001, 4'b1000); // 1100 << 1 = 1000
    run_test (4'b1010, 4'b0000, 3'b001, 4'b0100); // 1010 << 1 = 0100
    run_test (4'b1111, 4'b0000, 3'b001, 4'b1110); // 1111 << 1 = 1110
    run_test (4'b0011, 4'b0000, 3'b001, 4'b0110); // 0011 << 1 = 0110
    run_test (4'b0110, 4'b0000, 3'b001, 4'b1100); // 0110 << 1 = 1100
    run_test (4'b1001, 4'b0000, 3'b001, 4'b0010); // 1001 << 1 = 0010
    run_test (4'b0111, 4'b0000, 3'b001, 4'b1110); // 0111 << 1 = 1110

    // when Sel is 010 which now indicates Logical Shift Right of B, A is constant
    run_test (4'b0000, 4'b0001, 3'b010, 4'b0000); // 0001 >> 1 = 0000
    run_test (4'b0000, 4'b0010, 3'b010, 4'b0001); // 0010 >> 1 = 0001
    run_test (4'b0000, 4'b0100, 3'b010, 4'b0010); // 0100 >> 1 = 0010
    run_test (4'b0000, 4'b1000, 3'b010, 4'b0100); // 1000 >> 1 = 0100
    run_test (4'b0000, 4'b1100, 3'b010, 4'b0110); // 1100 >> 1 = 0110
    run_test (4'b0000, 4'b1010, 3'b010, 4'b0101); // 1010 >> 1 = 0101
    run_test (4'b0000, 4'b1111, 3'b010, 4'b0111); // 1111 >> 1 = 0111
    run_test (4'b0000, 4'b0011, 3'b010, 4'b0001); // 0011 >> 1 = 0001
    run_test (4'b0000, 4'b0110, 3'b010, 4'b0011); // 0110 >> 1 = 0011
    run_test (4'b0000, 4'b1001, 3'b010, 4'b0100); // 1001 >> 1 = 0100
    run_test (4'b0000, 4'b0111, 3'b010, 4'b0011); // 0111 >> 1 = 0011

    // when Sel is 011 which now indicates Logical Shift Left of B, A is constant
    run_test (4'b0000, 4'b0001, 3'b011, 4'b0010); // 0001 << 1 = 0010
    run_test (4'b0000, 4'b0010, 3'b011, 4'b0100); // 0010 << 1 = 0100
    run_test (4'b0000, 4'b0100, 3'b011, 4'b1000); // 0100 << 1 = 1000
    run_test (4'b0000, 4'b1000, 3'b011, 4'b0000); // 1000 << 1 = 0000 (overflow ignored)
    run_test (4'b0000, 4'b1100, 3'b011, 4'b1000); // 1100 << 1 = 1000 (last bit shifted out)
    run_test (4'b0000, 4'b1010, 3'b011, 4'b0100); // 1010 << 1 = 0100
    run_test (4'b0000, 4'b1111, 3'b011, 4'b1110); // 1111 << 1 = 1110
    run_test (4'b0000, 4'b0011, 3'b011, 4'b0110); // 0011 << 1 = 0110
    run_test (4'b0000, 4'b0110, 3'b011, 4'b1100); // 0110 << 1 = 1100
    run_test (4'b0000, 4'b1001, 3'b011, 4'b0010); // 1001 << 1 = 0010
    run_test (4'b0000, 4'b0111, 3'b011, 4'b1110); // 0111 << 1 = 1110
    
    // when Sel is 100 which now indicates Rotate Right of A, B is constant
    run_test (4'b0001, 4'b0000, 3'b100, 4'b1000); // 0001 → 1000
    run_test (4'b0010, 4'b0000, 3'b100, 4'b0001); // 0010 → 0001
    run_test (4'b0100, 4'b0000, 3'b100, 4'b0010); // 0100 → 0010
    run_test (4'b1000, 4'b0000, 3'b100, 4'b0100); // 1000 → 0100
    run_test (4'b1100, 4'b0000, 3'b100, 4'b0110); // 1100 → 0110
    run_test (4'b1010, 4'b0000, 3'b100, 4'b0101); // 1010 → 0101
    run_test (4'b1111, 4'b0000, 3'b100, 4'b1111); // 1111 → 1111
    run_test (4'b0011, 4'b0000, 3'b100, 4'b1001); // 0011 → 1001
    run_test (4'b0110, 4'b0000, 3'b100, 4'b0011); // 0110 → 0011
    run_test (4'b1001, 4'b0000, 3'b100, 4'b1100); // 1001 → 1100
    run_test (4'b0111, 4'b0000, 3'b100, 4'b1011); // 0111 → 1011

    // when Sel is 101 which now indicates Rotate Left of A, B is constant
    run_test (4'b0001, 4'b0000, 3'b101, 4'b0010); // 0001 ← 0010
    run_test (4'b0010, 4'b0000, 3'b101, 4'b0100); // 0010 ← 0100
    run_test (4'b0100, 4'b0000, 3'b101, 4'b1000); // 0100 ← 1000
    run_test (4'b1000, 4'b0000, 3'b101, 4'b0001); // 1000 ← 0001
    run_test (4'b1100, 4'b0000, 3'b101, 4'b1001); // 1100 ← 1001
    run_test (4'b1010, 4'b0000, 3'b101, 4'b0101); // 1010 ← 0101
    run_test (4'b1111, 4'b0000, 3'b101, 4'b1111); // 1111 ← 1111
    run_test (4'b0011, 4'b0000, 3'b101, 4'b0110); // 0011 ← 0110
    run_test (4'b0110, 4'b0000, 3'b101, 4'b1100); // 0110 ← 1100
    run_test (4'b1001, 4'b0000, 3'b101, 4'b0011); // 1001 ← 0011
    run_test (4'b0111, 4'b0000, 3'b101, 4'b1110); // 0111 ← 1110
    
    // when Sel is 110 which now indicates Rotate Right of B, A is constant
    run_test (4'b0000, 4'b0001, 3'b110, 4'b1000); // 0001 → 1000
    run_test (4'b0000, 4'b0010, 3'b110, 4'b0001); // 0010 → 0001
    run_test (4'b0000, 4'b0100, 3'b110, 4'b0010); // 0100 → 0010
    run_test (4'b0000, 4'b1000, 3'b110, 4'b0100); // 1000 → 0100
    run_test (4'b0000, 4'b1100, 3'b110, 4'b0110); // 1100 → 0110
    run_test (4'b0000, 4'b1010, 3'b110, 4'b0101); // 1010 → 0101
    run_test (4'b0000, 4'b1111, 3'b110, 4'b1111); // 1111 → 1111
    run_test (4'b0000, 4'b0011, 3'b110, 4'b1001); // 0011 → 1001
    run_test (4'b0000, 4'b0110, 3'b110, 4'b0011); // 0110 → 0011
    run_test (4'b0000, 4'b1001, 3'b110, 4'b1100); // 1001 → 1100
    run_test (4'b0000, 4'b0111, 3'b110, 4'b1011); // 0111 → 1011
  
    // when Sel is 111 which now indicates Rotate Left of B, A is constant
    run_test (4'b0000, 4'b0001, 3'b111, 4'b0010); // 0001 → 0010
    run_test (4'b0000, 4'b0010, 3'b111, 4'b0100); // 0010 → 0100
    run_test (4'b0000, 4'b0100, 3'b111, 4'b1000); // 0100 → 1000
    run_test (4'b0000, 4'b1000, 3'b111, 4'b0001); // 1000 → 0001
    run_test (4'b0000, 4'b1100, 3'b111, 4'b1001); // 1100 → 1001
    run_test (4'b0000, 4'b1010, 3'b111, 4'b0101); // 1010 → 0101
    run_test (4'b0000, 4'b1111, 3'b111, 4'b1111); // 1111 → 1111
    run_test (4'b0000, 4'b0011, 3'b111, 4'b0110); // 0011 → 0110
    run_test (4'b0000, 4'b0110, 3'b111, 4'b1100); // 0110 → 1100
    run_test (4'b0000, 4'b1001, 3'b111, 4'b0011); // 1001 → 0011
    run_test (4'b0000, 4'b0111, 3'b111, 4'b1110); // 0111 → 1110

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
        input [2:0] Sel_in ,
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
