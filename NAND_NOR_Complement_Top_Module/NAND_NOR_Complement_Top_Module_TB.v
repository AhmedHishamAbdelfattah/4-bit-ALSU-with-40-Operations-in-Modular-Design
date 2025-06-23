module NAND_NOR_Complement_Top_Module_TB () ;

   reg [3:0] A , B ; 
   reg [1:0] Sel ;
   wire [3:0] Out ;  
   integer error_count = 0 ;

   NAND_NOR_Complement_Top_Module R1 ( .A ( A ) ,
                                       .B ( B ) , 
                                       .Sel ( Sel ) ,
                                       .Out ( Out ) 
                                     );

    initial begin  
    $monitor("Time = %0t  : A = %b (%0d) : B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) " ,
                     $time , A , A , B , B , Sel , Sel , Out , Out ) ; 
    end 

    initial begin 
     
    // when Sel is 00 which now indicates A NAND B:
    run_test (4'b0001, 4'b1111, 2'b00, 4'b1110); // ~(0001 & 1111) = ~(0001) = 1110
    run_test (4'b0010, 4'b1110, 2'b00, 4'b1101); // ~(0010 & 1110) = ~(0010) = 1101
    run_test (4'b0100, 4'b1010, 2'b00, 4'b1111); // ~(0100 & 1010) = ~(0000) = 1111
    run_test (4'b1000, 4'b1100, 2'b00, 4'b0111); // ~(1000 & 1100) = ~(1000) = 0111
    run_test (4'b1100, 4'b1111, 2'b00, 4'b0011); // ~(1100 & 1111) = ~(1100) = 0011
    run_test (4'b1010, 4'b0110, 2'b00, 4'b1101); // ~(1010 & 0110) = ~(0010) = 1101
    run_test (4'b1111, 4'b0001, 2'b00, 4'b1110); // ~(1111 & 0001) = ~(0001) = 1110
    run_test (4'b0011, 4'b0101, 2'b00, 4'b1110); // ~(0011 & 0101) = ~(0001) = 1110
    run_test (4'b0110, 4'b1011, 2'b00, 4'b1101); // ~(0110 & 1011) = ~(0010) = 1101
    run_test (4'b1001, 4'b1001, 2'b00, 4'b0110); // ~(1001 & 1001) = ~(1001) = 0110
    run_test (4'b0111, 4'b0111, 2'b00, 4'b1000); // ~(0111 & 0111) = ~(0111) = 1000

    // when Sel is 01 which now indicates A NOR B:
    run_test (4'b1000, 4'b0001, 2'b01, 4'b0110); // ~(1000 | 0001) = ~(1001) = 0110
    run_test (4'b0100, 4'b0010, 2'b01, 4'b1001); // ~(0100 | 0010) = ~(0110) = 1001
    run_test (4'b0010, 4'b0100, 2'b01, 4'b1001); // ~(0010 | 0100) = ~(0110) = 1001
    run_test (4'b0001, 4'b1000, 2'b01, 4'b0110); // ~(0001 | 1000) = ~(1001) = 0110
    run_test (4'b0011, 4'b1100, 2'b01, 4'b0000); // ~(0011 | 1100) = ~(1111) = 0000
    run_test (4'b0101, 4'b1010, 2'b01, 4'b0000); // ~(0101 | 1010) = ~(1111) = 0000
    run_test (4'b0000, 4'b1111, 2'b01, 4'b0000); // ~(0000 | 1111) = ~(1111) = 0000
    run_test (4'b1100, 4'b0011, 2'b01, 4'b0000); // ~(1100 | 0011) = ~(1111) = 0000
    run_test (4'b1001, 4'b0110, 2'b01, 4'b0000); // ~(1001 | 0110) = ~(1111) = 0000
    run_test (4'b0010, 4'b1001, 2'b01, 4'b0100); // ~(0010 | 1001) = ~(1011) = 0100
    run_test (4'b0100, 4'b0111, 2'b01, 4'b1000); // ~(0100 | 0111) = ~(0111) = 1000
    
    // when Sel is 10 which now indicates Complement of A (~A)
    run_test (4'b1000, 4'b0000, 2'b10, 4'b0111); // ~1000 = 0111
    run_test (4'b0100, 4'b0000, 2'b10, 4'b1011); // ~0100 = 1011
    run_test (4'b0010, 4'b0000, 2'b10, 4'b1101); // ~0010 = 1101
    run_test (4'b0001, 4'b0000, 2'b10, 4'b1110); // ~0001 = 1110
    run_test (4'b0011, 4'b0000, 2'b10, 4'b1100); // ~0011 = 1100
    run_test (4'b0101, 4'b0000, 2'b10, 4'b1010); // ~0101 = 1010
    run_test (4'b0000, 4'b0000, 2'b10, 4'b1111); // ~0000 = 1111
    run_test (4'b1100, 4'b0000, 2'b10, 4'b0011); // ~1100 = 0011
    run_test (4'b1001, 4'b0000, 2'b10, 4'b0110); // ~1001 = 0110
    run_test (4'b0010, 4'b0000, 2'b10, 4'b1101); // ~0010 = 1101
    run_test (4'b0100, 4'b0000, 2'b10, 4'b1011); // ~0100 = 1011  

    // when Sel is 11 which now indicates Complement of B (~B)
    run_test (4'b0000, 4'b0001, 2'b11, 4'b1110); // ~0001 = 1110
    run_test (4'b0000, 4'b0010, 2'b11, 4'b1101); // ~0010 = 1101
    run_test (4'b0000, 4'b0100, 2'b11, 4'b1011); // ~0100 = 1011
    run_test (4'b0000, 4'b1000, 2'b11, 4'b0111); // ~1000 = 0111
    run_test (4'b0000, 4'b1100, 2'b11, 4'b0011); // ~1100 = 0011
    run_test (4'b0000, 4'b1010, 2'b11, 4'b0101); // ~1010 = 0101
    run_test (4'b0000, 4'b1111, 2'b11, 4'b0000); // ~1111 = 0000
    run_test (4'b0000, 4'b0011, 2'b11, 4'b1100); // ~0011 = 1100
    run_test (4'b0000, 4'b0110, 2'b11, 4'b1001); // ~0110 = 1001
    run_test (4'b0000, 4'b1001, 2'b11, 4'b0110); // ~1001 = 0110
    run_test (4'b0000, 4'b0111, 2'b11, 4'b1000); // ~0111 = 1000

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
