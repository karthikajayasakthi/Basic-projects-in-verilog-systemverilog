//addition

//DATA FLOW

module float_adder(a,b,sum);
  input [31:0]a,b;
output sum;
wire siga,sigb,sigs;
  wire [7:0]expa,expb,exps;
  wire [23:0] fraca,fracb,fracs;
  assign siga=a[31];
  assign expa=a[30:23];
  assign fraca={1'b1,a[22:0]};
  assign sigb=b[31];
  assign expb=b[30:23];
  assign fracb={1'b1,b[22:0]};
  wire [23:0]align_fraca,align_fracb;
  wire [7:0]align_expa,align_expb;
assign align_fraca=fraca;
assign align_fracb=fracb;
assign align_expa=expa;
assign align_expb=expb;
//add fraction
  wire [24:0] sum_frac;
assign sum_frac=align_fraca+align_fracb;
//normalize the result
  assign sigs=sum_frac[24];
assign exps=align_expa+1;
  assign fracs=sum_frac[23:1];
//combine into a 32 bit result
  assign sum={sigs,exps,fracs};
endmodule

//float subtract

//DATAFLOW

module float_sub(a,b,diff);
  input [31:0]a,b;
output diff;
wire siga,sigb,sigd;
  wire [7:0]expa,expb,expd;
  wire [23:0] fraca,fracb,frad;
  assign siga=a[31];
  assign expa=a[30:23];
  assign fraca={1'b1,a[22:0]};
  assign sigb=b[31];
  assign expb=b[30:23];
  assign fracb={1'b1,b[22:0]};
  wire [23:0]align_fraca,align_fracb;
  wire [7:0]align_expa,align_expb;
assign align_fraca=fraca;
assign align_fracb=fracb;
assign align_expa=expa;
assign align_expb=expb;
//add fraction
  wire [24:0] diff_frac;
assign diff_frac=align_fraca+align_fracb;
//normalize the result
  assign sigd=diff_frac[24];
assign expd=align_expa+1;
  assign fracd=diff_frac[23:1];
//combine into a 32 bit result
  assign diff={sigd,expd,fracd};
endmodule


//MULTIPLICATION

//DATA FLOW
module float_mul(a,b,prod);
  input [31:0]a,b;
output prod;
wire siga,sigb,sigp;
  wire [7:0]expa,expb,expp;
  wire [23:0] fraca,fracb,frap;
  assign siga=a[31];
  assign expa=a[30:23];
  assign fraca={1'b1,a[22:0]};
  assign sigb=b[31];
  assign expb=b[30:23];
  assign fracb={1'b1,b[22:0]};
  wire [23:0]align_fraca,align_fracb;
  wire [7:0]align_expa,align_expb;
assign align_fraca=fraca;
assign align_fracb=fracb;
assign align_expa=expa;
assign align_expb=expb;
//add fraction
  wire [24:0] prod_frac;
assign prod_frac=align_fraca*align_fracb;
 wire [8:0] exp_sum;
    assign exp_sum = expa + expb - 127; 
 assign signP = signA ^ signB;  
    assign expP = exp_sum[7:0];   
    assign fracP = prod_frac[46:24]; 
//combine into a 32 bit result
  assign prod={sigp,expp,fracp};
endmodule

/DIVISION

//DATA FLOW

module float_divider (
    input [31:0] A,  // 32-bit input A (floating point)
    input [31:0] B,  // 32-bit input B (floating point)
    output [31:0] QUOT // 32-bit output QUOT (floating point)
);
    wire signA, signB, signQ; // Sign bits of A, B, and the result
    wire [7:0] expA, expB, expQ; // Exponents of A, B, and the result
    wire [22:0] fracA, fracB, fracQ; // Fractions (mantissas) of A, B, and the result

    // Extract sign, exponent, and fraction from A and B
    assign signA = A[31];
    assign expA = A[30:23];
    assign fracA = {1'b1, A[22:0]}; // Add implicit leading 1

    assign signB = B[31];
    assign expB = B[30:23];
    assign fracB = {1'b1, B[22:0]}; // Add implicit leading 1

    // Divide the fractions
    wire [46:0] quot_frac;  // Quotient of fractions with extra bits for the result
    assign quot_frac = fracA / fracB;

    // Subtract exponents (bias of 127 for both operands)
    wire [8:0] exp_diff;
    assign exp_diff = expA - expB + 127;  // Bias adjustment

    // Normalize the result (simplified)
    assign signQ = signA ^ signB;  // Result sign is XOR of A and B signs
    assign expQ = exp_diff[7:0];   // Use the 8 most significant bits as the exponent
    assign fracQ = quot_frac[46:24]; // Take the upper 23 bits of the quotient

    // Combine into a 32-bit result
    assign QUOT = {signQ, expQ, fracQ};
    
endmodule


