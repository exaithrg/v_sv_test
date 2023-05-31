`timescale 1ns/1ps

// 这个版本前仿不需要延时

module NowCode_VL4_2(
    input [7:0]d ,
    input clk,
    input rst,
    output reg input_grant,
    output reg [10:0]out
);

//*************code***********//

reg [1:0] cnt;
reg [7:0] dbk;

always @(posedge clk, negedge rst) begin
    if(!rst) cnt <= 2'b0;
    else cnt <= cnt + 1'b1;
end

always @(posedge clk, negedge rst) begin
    if(!rst) dbk <= 8'b0;
    else if(cnt == 2'b0) dbk <= d;
end

always @(posedge clk, negedge rst) begin
    if(!rst) input_grant <= 1'b0;
    else if(cnt == 2'b0) input_grant <= 1'b1;
    else input_grant <= 1'b0;
end

always @(posedge clk, negedge rst) begin
    if(!rst) out <= 11'b0;
    else begin
        case(cnt)
        0: out <= d;
        1: out <= dbk * 3;
        2: out <= dbk * 7;
        3: out <= dbk << 3;
        endcase
    end
end

//*************code***********//

endmodule