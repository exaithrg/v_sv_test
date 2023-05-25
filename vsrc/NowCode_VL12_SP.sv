`timescale 1ns/1ns

module NowCode_VL12(
    input logic [15:0] in ,
    output logic [15:0] out 
);

    integer i;
    // 15:12 -> 3:0 11:8->7:4 3:0->15:12
    always_comb begin
        for(i=0;i<4;i=i+1) begin
            out[4*i+3 : 4*i] = in[4*(3-i)+3 : 4*(3-i)];
        end
    end

endmodule
