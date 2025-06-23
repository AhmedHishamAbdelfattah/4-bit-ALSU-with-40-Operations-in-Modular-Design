module Divider_Module_TB;

  parameter Width = 4;           
  parameter Output_Width = 4;    
  parameter Delay = 10;    

  reg  [Width-1:0] A, B;      
  wire [Output_Width-1:0] Q;  
  wire [Output_Width-1:0] R;  

  integer error_count = 0;     

four_bit_divider Div_1 ( .A ( A ) ,
                         .B ( B ) ,
                         .Q ( Q ) ,
                         .R ( R ) 
                       );

  initial begin
    $monitor("Time=%0t A=%b (%0d) B=%b (%0d) Q=%b (%0d) R=%b (%0d)",
             $time, A, A, B, B, Q, Q, R, R);
  end

  initial begin

    run_test(4'd5 , 4'd4 , 4'd1 , 4'd1);   // 5 / 4 = 1 R1
    run_test(4'd5 , 4'd3 , 4'd1 , 4'd2);   // 5 / 3 = 1 R2
    run_test(4'd0 , 4'd1 , 4'd0 , 4'd0);   // 0 / 1 = 0 R0
    run_test(4'd15, 4'd3 , 4'd5 , 4'd0);   // 15 / 3 = 5 R0
    run_test(4'd3 , 4'd5 , 4'd0 , 4'd3);   // 3 / 5 = 0 R3
    run_test(4'd10, 4'd1 , 4'd10, 4'd0);   // 10 / 1 = 10 R0
    run_test(4'd12, 4'd13, 4'd0 , 4'd12);  // 12 / 13 = 0 R12
    run_test(4'd15, 4'd15, 4'd1 , 4'd0);   // 15 / 15 = 1 R0
    run_test(4'd15, 4'd15, 4'd1 , 4'd0);   // 15 / 15 =1 R0
    run_test(4'd10 , 4'd5 ,4'd2 , 4'd0);   // 10 / 5 =2 R0

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
    input [Output_Width-1:0] expected_out_Q,
    input [Output_Width-1:0] expected_out_R
  );
    begin
      A = a_in;
      B = b_in;
      #Delay; 
      if ((Q !== expected_out_Q) && (R !== expected_out_R) ) begin
        $display("ERROR at time %0t: A=%0d, B=%0d, Expected Q=%0d, Got Q=%0d, Expected R=%0d, Got R=%0d ",
                 $time, A, B, expected_out_Q, Q, expected_out_R, R );
        error_count = error_count + 1;
      end else begin
        $display("PASS: A=%0d, B=%0d, Out=%0d", A, B, Q, R);
      end
    end
  endtask

endmodule
