`timescale 1ns/1ps

// 这个版本必须加延时才能正常工作，否则不行，原因是cnt用了阻塞赋值没注意到

module NowCode_VL4(
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
    if(!rst) cnt <= #0.1 2'b0;
    else cnt <= #0.1 cnt + 1'b1;
end

always @(posedge clk, negedge rst) begin
    if(!rst) dbk <= #0.1 8'b0;
    else if(cnt == 2'b0) dbk <= #0.1 d;
end

always @(posedge clk, negedge rst) begin
    if(!rst) input_grant <= #0.1 1'b0;
    else if(cnt == 2'b0) input_grant <= #0.1 1'b1;
    else input_grant <= #0.1 1'b0;
end

always @(posedge clk, negedge rst) begin
    if(!rst) out <= #0.1 11'b0;
    else begin
        case(cnt)
        0: out <= #0.1 d;
        1: out <= #0.1 dbk * 3;
        2: out <= #0.1 dbk * 7;
        3: out <= #0.1 dbk << 3;
        endcase
    end
end

//*************code***********//

endmodule