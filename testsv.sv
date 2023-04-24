// 下面system verilog代码的执行输出结果是？
module testsv();

program test;
    initial begin for(int i=0; i<3; i++)
        fork
            $write(i);
        join_none
            #0 $display("\n");
    end
endprogram

// foreach不需要定义变量，从左往右遍历
program top;
    bit [3:0] data;
    bit [0:3] data2;
    initial begin
        data = 4'h2;
        data2 = 4'h2;
        foreach (data[i]) begin
            $display("data[%1d]=0x%0h",i,data[i]);
        end        
        foreach (data2[j]) begin
            $display("data2[%1d]=0x%0h",j,data2[j]);
        end
    end
endprogram

// output:
// #           3          3          3data[3]=0x0
// # data[2]=0x0
// # data[1]=0x1
// # data[0]=0x0

int md[2][3]='{'{0,1,2},'{3,4,5}};
initial begin
	$display("Initial value: ");
	foreach(md[i,j])
		$display("md[%0d][%0d]=%0d",i,j,md[i][j]);
	$display("New value: ");
	md='{'{9,8,7},'{3{32'd5}}}; //对数组最后三个元素赋值为5
	foreach(md[i,j])
		$display("md[%0d][%0d]=%0d",i,j,md[i][j]);
end

// output:
// Initial value:
// md[0][0]=0
// md[0][1]=1
// md[0][2]=2
// md[1][0]=3
// md[1][1]=4
// md[1][2]=5
// New value:
// md[0][0]=9
// md[0][1]=8
// md[0][2]=7
// md[1][0]=5
// md[1][1]=5
// md[1][2]=5

// 注：foreach循环会遍历原始声明中的数组范围。
// 数组f[5]等同于f[0:4]，因此foreach(f[i])等同于for(int i=0;i<=4;i++)。
// 对于数组rev[6:2]来说foreach(rev[I])等同于for(int I=6;i>=2;i–)。

endmodule
