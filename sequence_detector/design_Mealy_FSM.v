`timescale 1ns / 1ps

module seq_1010_mealy(
    input clk,
    input rst,
    input din,
    output reg dout
);

reg [1:0] state, next_state;

parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

always @(posedge clk) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case(state)

        S0: begin
            if(din)
                next_state = S1;
            else
                next_state = S0;
            dout = 0;
        end

        S1: begin
            if(din)
                next_state = S1;
            else
                next_state = S2;
            dout = 0;
        end

        S2: begin
            if(din)
                next_state = S3;
            else
                next_state = S0;
            dout = 0;
        end

        S3: begin
            if(din) begin
                next_state = S1;
                dout = 0;
            end
            else begin
                next_state = S2;
                dout = 1;
            end
        end

    endcase
end

endmodule