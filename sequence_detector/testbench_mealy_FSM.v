`timescale 1ns / 1ps

module tb_mealy;

reg clk;
reg rst;
reg din;
wire dout;

seq_1010_mealy uut(
    .clk(clk),
    .rst(rst),
    .din(din),
    .dout(dout)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    din = 0;

    #10 rst = 0;

    #10 din = 1;
    #10 din = 0;
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;
    #10 din = 0;

    #50 $finish;
end

endmodule