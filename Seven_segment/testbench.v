module SevenSegmentController_tb;
    wire [6:0] seg;          
    SevenSegmentController uut (
        .binary_input(binary_input),
        .seg(seg)
    );
  
    initial begin
       $dumpfile("dump.vcd");$dumpvars;
        binary_input = 4'b0000; #10;
        binary_input = 4'b0001; #10;
        binary_input = 4'b0010; #10;
        binary_input = 4'b0011; #10;
        binary_input = 4'b0100; #10;
        binary_input = 4'b0101; #10;
        binary_input = 4'b0110; #10;
        binary_input = 4'b0111; #10;
        binary_input = 4'b1000; #10;
        binary_input = 4'b1001; #10;
      $finish();
    end

endmodule
