/TESTBENCH

module tb;
  reg [3:0] a,b;
  reg [1:0] opcode;
  wire [3:0] result;
  alu_4bit dut(.a(a),.b(b),.opcode(opcode),.result(result));
initial
begin
  $dumpfile("dump.vcd");$dumpvars;
a=4'b0000; b=4'b0001; opcode=2'b00;
#10
a=4'b0100; b=4'b0110; opcode=2'b01;
#10
a=4'b0110; b=4'b1100; opcode=2'b10;
#10
a=4'b1010; b=4'b1101;  opcode=2'b11;
#10
  $finish();
end
endmodule
