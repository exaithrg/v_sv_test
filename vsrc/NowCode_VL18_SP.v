`timescale 1ns/1ns

module NowCode_VL18(
    input a, b, c, d, e,
	output [24:0] out
);

    wire [24:0] xx,yy;
    xx = {5{a},5{b},5{c},5{d},5{e}};
    yy = {5{a,b,c,d,e}};
    assign out = ~( xx ^ yy );

endmodule