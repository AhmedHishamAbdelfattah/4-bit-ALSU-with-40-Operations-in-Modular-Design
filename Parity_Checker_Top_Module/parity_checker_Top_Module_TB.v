module parity_checker_Top_Module_TB () ;
  
      parameter Delay = 10 ;
   
      reg [3:0] A , B ;
      reg Sel ;
      wire [3:0] out ; 
      integer error_count = 0 ;

parity_checker_Top_Module P_1 ( .A( A ) ,
                                .B( B ) ,
                                .Sel( Sel ) ,
                                .out( out ) 
                              ); 
initial begin 
$monitor("A = %b (%0d)  ,  B = %b (%0d)  ,  Sel = %b (%0d)  ,  out = %b (%0d)" , 
           A , A , B , B , Sel , Sel , out , out ) ;
end 

initial begin 

// when Sel is 0 which indicates Parity_Checker_A

run_test(4'b0000, 4'b0000, 1'b0, 4'b0000); // 0 ones -> even
run_test(4'b0001, 4'b0000, 1'b0, 4'b0001); // 1 one  -> odd
run_test(4'b0010, 4'b0000, 1'b0, 4'b0001); // 1 one  -> odd
run_test(4'b0011, 4'b0000, 1'b0, 4'b0000); // 2 ones -> even
run_test(4'b0100, 4'b0000, 1'b0, 4'b0001); // 1 one  -> odd
run_test(4'b0101, 4'b0000, 1'b0, 4'b0000); // 2 ones -> even
run_test(4'b0110, 4'b0000, 1'b0, 4'b0000); // 2 ones -> even
run_test(4'b0111, 4'b0000, 1'b0, 4'b0001); // 3 ones -> odd
run_test(4'b1000, 4'b0000, 1'b0, 4'b0001); // 1 one  -> odd
run_test(4'b1001, 4'b0000, 1'b0, 4'b0000); // 2 ones -> even
run_test(4'b1010, 4'b0000, 1'b0, 4'b0000); // 2 ones -> even
run_test(4'b1011, 4'b0000, 1'b0, 4'b0001); // 3 ones -> odd
run_test(4'b1100, 4'b0000, 1'b0, 4'b0000); // 2 ones -> even
run_test(4'b1101, 4'b0000, 1'b0, 4'b0001); // 3 ones -> odd
run_test(4'b1110, 4'b0000, 1'b0, 4'b0001); // 3 ones -> odd
run_test(4'b1111, 4'b0000, 1'b0, 4'b0000); // 4 ones -> even


// when Sel is 1 which indicates Parity_Checker_B
run_test(4'b0000, 4'b0000, 1'b1, 4'b0000); // 0 ones -> even
run_test(4'b0000, 4'b0001, 1'b1, 4'b0001); // 1 one  -> odd
run_test(4'b0000, 4'b0010, 1'b1, 4'b0001); // 1 one  -> odd
run_test(4'b0000, 4'b0011, 1'b1, 4'b0000); // 2 ones -> even
run_test(4'b0000, 4'b0100, 1'b1, 4'b0001); // 1 one  -> odd
run_test(4'b0000, 4'b0101, 1'b1, 4'b0000); // 2 ones -> even
run_test(4'b0000, 4'b0110, 1'b1, 4'b0000); // 2 ones -> even
run_test(4'b0000, 4'b0111, 1'b1, 4'b0001); // 3 ones -> odd
run_test(4'b0000, 4'b1000, 1'b1, 4'b0001); // 1 one  -> odd
run_test(4'b0000, 4'b1001, 1'b1, 4'b0000); // 2 ones -> even
run_test(4'b0000, 4'b1010, 1'b1, 4'b0000); // 2 ones -> even
run_test(4'b0000, 4'b1011, 1'b1, 4'b0001); // 3 ones -> odd
run_test(4'b0000, 4'b1100, 1'b1, 4'b0000); // 2 ones -> even
run_test(4'b0000, 4'b1101, 1'b1, 4'b0001); // 3 ones -> odd
run_test(4'b0000, 4'b1110, 1'b1, 4'b0001); // 3 ones -> odd
run_test(4'b0000, 4'b1111, 1'b1, 4'b0000); // 4 ones -> even

if (error_count == 0) begin 
$display("All Cases Passed");
end
else begin 
$display("there is %0d errors" , error_count);
end

$stop;
end

task run_test (
 input [3:0] A_in ,
 input [3:0] B_in , 
 input Sel_in ,
 input [3:0] Expected_Out 
);
begin 
A = A_in ;
B = B_in ;
Sel = Sel_in ;

#Delay ;

if (out !== Expected_Out ) begin 
$display("there is an error at time (%0t) when A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , out = %b (%0d) , Expected_out = %b (%0d)",
            $time , A , A , B , B , Sel , Sel , out , out , Expected_Out , Expected_Out ) ;
     error_count = error_count + 1 ;       
end
else begin 
$display("PASS : A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , out = %b (%0d)",
           A , A , B , B , Sel , Sel , out , out );
end
end 
endtask
endmodule 
