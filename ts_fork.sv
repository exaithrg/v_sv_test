`timescale 1ns/1ps

module ts_fork;

int k;
int m;
event eventA;

initial begin
    for (int i=0;i<=2;i++) begin
        fork
            begin
                #i;
            end
            begin
                m = $time;
            end
        join
        ->eventA;
    end
end

always @(eventA) begin
    $display("%d",m);
end

endmodule
