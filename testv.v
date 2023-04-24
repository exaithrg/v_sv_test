`timescale 1ns/100ps

module testv();

reg [7:0] twod_array [0:15][0:15];
reg threed_array[0:15][0:15][0:7];

integer i,j,k;

initial begin
    for(i=0;i<16;i=i+1) begin
        for(j=0;j<16;j=j+1) begin
            // twod_array[i][j][3:0] = 8'b0;   // Legal
            twod_array[i][j] = 8'b0;
            // threed_array[i][j] = 8'b0;  // Illegal. Cannot assign a packed type 'reg[7:0]' to an unpacked type 'reg $[0:7]'.
            // threed_array[i][j][3:0] = 4'b0; // Illegal too
            for(k=0;k<8;k=k+1) begin
                threed_array[i][j][k] = 1'b0;
            end
        end
    end
end

reg signed [7:0] bdata, bd; // sign bit: bdata[7]. bd is 8-bit, too.
reg signed [0:7] ldata, ld; // sign bit: ldata[0]. ld is 8-bit, too.

initial begin
    bdata = -128;
    bd = 1'b1;
    ldata = -128;
    ld = 1'b1;
    # 10;
    bdata = -127;
    bd = -1;
    ldata = -127;
    ld = -1; 
    # 10;
end

reg [15:0] mema [3:0];
reg [0:15] memb [3:0];

reg [15:0] memc [0:3];
reg [0:15] memd [0:3];

reg [16:1] meme [0:3];
reg [1:16] memf [1:4];

initial begin
    // 规律总结：
    // 未指定起始地址时，总是先从小地址开始写，也就是总是先写[0]，不管是[3:0]还是[0:3]
    // 都是往[0]写的时候，写1234进去，[15:0]就是把1234(0001_0010_0011_0100)直接放到[15:0]，也就是[15:12]是1，[11:8]是2
    // 这么说的话，感觉从显示好看的角度来讲，最好用[小:大]，这样小的可以在波形上边显示，不用拉下去
    $readmemh("memh.txt",mema);
    $readmemh("memh.txt",memb);
    $readmemh("memh.txt",memc);
    $readmemh("memh.txt",memd);
    $readmemh("memh.txt",meme);
    $readmemh("memh.txt",memf);
end

reg [15:0] memg [0:3];

initial begin
    // Result: memg[0] = xxxx mem[3]=1234 mem[1]=9ABC
    $readmemh("memh.txt",memg,3,1);
end

reg [0:2] a,b;
reg [4:0] res;
initial begin
    a = 3'b010;
    b = 3'b100;
    res = 5'b0;
    #20;
    res = a+b<<2;   // res = 5'b11000
end

wire [0:7] aaa [5:0];
// assign aaa = 0; // Illegal. Cannot assign a packed type 'reg signed[31:0]' to an unpacked type 'wire[0:7] $[5:0]'.
assign aaa[2] = 8'b0;
assign aaa[5] = 8'b1;

integer temp = 1'bx;
// integer完全相当于reg[31:0]
initial begin
    $display("%d",temp);
end

// cmos也是verilog关键字

reg a24=1'b1;
reg [0:2] b24=3'b001;
wire [6:0] o24;

assign o24={a24,{2{b24}}};

initial begin
    #24;
    $display("%b",o24);
end

// output: 1001001
// o24 = 7'b1001001

endmodule
