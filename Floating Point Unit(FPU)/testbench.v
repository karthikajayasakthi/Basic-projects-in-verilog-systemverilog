//TESTBENCH
// addition
module tb;
  reg [31:0] a,b;
wire sum;
  float_adder dut(.a(a),.b(b),.sum(sum));
initial
begin
  $dumpfile("dump.vcd");$dumpvars;
 a = 32'b00111111100000000000000000000000; 
#10
  b = 32'b01000000000000000000000000000000;
#10

  $display("a=%b;b=%b,sum=%b",a,b,sum);
end
endmodule

//subtraction


module tb;
  reg [31:0] a,b;
wire diff;
  float_sub dut(.a(a),.b(b),.diff(diff));
initial
begin
  $dumpfile("dump.vcd");$dumpvars;
 a = 32'b00111111100000000000000000000000; 
#10
  b = 32'b01000000000000000000000000000000;
#10

  $display("a=%b;b=%b,sum=%b",a,b,diff);
end
endmodule

//multiplication

module tb;
  reg [31:0] a,b;
wire prod;
  float_mul dut(.a(a),.b(b),.prod(prod));
initial
begin
  $dumpfile("dump.vcd");$dumpvars;
 a = 32'b00111111100000000000000000000000; 
#10
  b = 32'b01000000000000000000000000000000;
#10

  $display("a=%b;b=%b,sum=%b",a,b,prod);
end
endmodule

//division

module tb_float_operations;

    reg [31:0] A, B;      // 32-bit registers to store input values A and B
    wire [31:0]  QUOT; // 32-bit wires to store the outputs

    float_divider div (
        .A(A),
        .B(B),
        .QUOT(QUOT)
    );
  initial begin
    $dumpfile("dump.vcd");$dumpvars;
  A = 32'b01000000010000000000000000000000; // 4.0 in IEEE 754 format
#10
        B = 32'b01000000000000000000000000000000; // 2.0 in IEEE 754 format
        #10;
        $display("4.0 / 2.0 = %f (Binary: %b)", QUOT, QUOT);
  end
endmodule

