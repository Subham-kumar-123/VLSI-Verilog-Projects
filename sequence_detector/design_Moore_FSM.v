`timescale 1ns / 1ps

module seq_1010_moore(
    input clk,
    input rst,
    input din,
    output reg dout
);

reg [2:0] state, next_state;

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100;

always @(posedge clk) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
        S0: next_state = din ? S1 : S0;
        S1: next_state = din ? S1 : S2;
        S2: next_state = din ? S3 : S0;
        S3: next_state = din ? S1 : S4;
        S4: next_state = din ? S3 : S0;
        default: next_state = S0;
    endcase
end

always @(*) begin
    if(state == S4)
        dout = 1'b1;
    else
        dout = 1'b0;
end

endmodule