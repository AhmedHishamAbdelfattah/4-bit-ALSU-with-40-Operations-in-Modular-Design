module Arithmetic_Shift_Top_Module_TB;

  parameter Width = 4;  
  parameter width_Sel = 2;         
  parameter Output_Width = 4;    
  parameter Delay = 10;    

  reg  [Width-1:0] A, B;      
  reg  [width_Sel-1:0] Sel ;
  wire [Output_Width-1:0] Out;  

  integer error_count = 0;     

Arithmetic_Shift_Top_Module A1 ( .A( A ) ,
                                 .B( B ) ,
                                 .Sel( Sel ) ,
                                 .out( Out ) 
                               );

  initial begin
    $monitor("Time=%0t A=%b (%0d) B=%b (%0d) Sel=%b (%0d) Out=%b (%0d)",
             $time, A, A, B, B, Sel, Sel, Out, Out);
  end

  initial begin

    // when Sel is 00 which indicates Arithmetic Shift Right (A)  
    run_test(4'b1100 , 4'b0000 , 2'b00 , 4'b0110);   
    run_test(4'b0101 , 4'b0000 , 2'b00 , 4'b0010);
    run_test(4'b1111 , 4'b0000 , 2'b00 , 4'b0111); 
    run_test(4'b0011 , 4'b0000 , 2'b00 , 4'b0001);  
    run_test(4'b1010 , 4'b0000 , 2'b00 , 4'b0101);  
    run_test(4'b1101 , 4'b0000 , 2'b00 , 4'b0110); 
    run_test(4'b0001 , 4'b0000 , 2'b00 , 4'b0000);   
    run_test(4'b0010 , 4'b0000 , 2'b00 , 4'b0001);      
    run_test(4'b1000 , 4'b0000 , 2'b00 , 4'b0100);

    // when Sel is 01 which indicates Arithmetic Shift Left (A)  
    run_test(4'b1100 , 4'b0000 , 2'b01 , 4'b1000);   
    run_test(4'b0101 , 4'b0000 , 2'b01 , 4'b1010);
    run_test(4'b1111 , 4'b0000 , 2'b01 , 4'b1110); 
    run_test(4'b0011 , 4'b0000 , 2'b01 , 4'b0110);  
    run_test(4'b1010 , 4'b0000 , 2'b01 , 4'b0100);  
    run_test(4'b1101 , 4'b0000 , 2'b01 , 4'b1010); 
    run_test(4'b0001 , 4'b0000 , 2'b01 , 4'b0010);   
    run_test(4'b0010 , 4'b0000 , 2'b01 , 4'b0100);      
    run_test(4'b1000 , 4'b0000 , 2'b01 , 4'b0000);

    // when Sel is 10 which indicates Arithmetic Shift Right (B)   
    run_test( 4'b0000 , 4'b1100 , 2'b10 , 4'b0110);   
    run_test( 4'b0000 , 4'b0101 , 2'b10 , 4'b0010);
    run_test( 4'b0000 , 4'b1111 , 2'b10 , 4'b0111); 
    run_test( 4'b0000 , 4'b0011 , 2'b10 , 4'b0001);  
    run_test( 4'b0000 , 4'b1010 , 2'b10 , 4'b0101);  
    run_test( 4'b0000 , 4'b1101 , 2'b10 , 4'b0110); 
    run_test( 4'b0000 , 4'b0001 , 2'b10 , 4'b0000);   
    run_test( 4'b0000 , 4'b0010 , 2'b10 , 4'b0001);      
    run_test( 4'b0000 , 4'b1000 , 2'b10 , 4'b0100);
    
    // when Sel is 11 which indicates Arithmetic Shift Left (B)   
    run_test( 4'b0000 , 4'b1100 , 2'b11 , 4'b1000);   
    run_test( 4'b0000 , 4'b0101 , 2'b11 , 4'b1010);
    run_test( 4'b0000 , 4'b1111 , 2'b11 , 4'b1110); 
    run_test( 4'b0000 , 4'b0011 , 2'b11 , 4'b0110);  
    run_test( 4'b0000 , 4'b1010 , 2'b11 , 4'b0100);  
    run_test( 4'b0000 , 4'b1101 , 2'b11 , 4'b1010); 
    run_test( 4'b0000 , 4'b0001 , 2'b11 , 4'b0010);   
    run_test( 4'b0000 , 4'b0010 , 2'b11 , 4'b0100);      
    run_test( 4'b0000 , 4'b1000 , 2'b11 , 4'b0000);
    
    #Delay;
    if (error_count == 0) begin
      $display("All tests passed successfully!");
    end else begin
      $display("Test completed with %0d errors.", error_count);
    end

    $stop; 
  end

  task run_test(
    input [Width-1:0] a_in,
    input [Width-1:0] b_in,
    input [width_Sel-1:0] sel_in,
    input [Output_Width-1:0] Expected_Out
  );
    begin
      A = a_in;
      B = b_in;
      Sel = sel_in;
      #Delay; 
      if (Out !== Expected_Out) begin
        $display("ERROR at time %0t: A=%0d, B=%0d, Sel=%b, Expected out=%0d, Got out=%0d",
                 $time, A, B, Sel, Expected_Out, Out );
        error_count = error_count + 1;
      end else begin
        $display("PASS: A=%0d, B=%0d, Out=%0d", A, B, Sel, Out);
      end
    end
  endtask

endmodule
