`timescale 1ns/1ps

module test_nowcode_vl4();

// module NowCode_VL4(
//     input [7:0]d ,
//     input clk,
//     input rst,
//     output reg input_grant,
//     output reg [10:0]out
// );

reg clk;
reg rst;
reg [7:0] d;
wire input_grant;
wire [10:0] out;

initial begin
    clk = 1'b0;
    rst = 1'b0;
    d = 100;
    #20;
    rst = 1'b1;
end

always #5 clk = ~clk;

NowCode_VL4_2 u_vl4(
    .d(d),
    .clk(clk),
    .rst(rst),
    .input_grant(input_grant),
    .out(out)
);

endmodule
