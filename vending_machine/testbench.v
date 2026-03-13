`timescale 1ns / 1ps
module vending_machine_TB;
//Inputs
reg CLK;
reg RST;
reg START;
reg CANCEL;
reg [2:0] PRODUCT_CODE;
reg ONLINE_PAYMENT;
reg [6:0] COINS;
//Outputs
wire [3:0] STATE;
wire DISPENSE_PRODUCT;
wire [6:0] RETURN_CHANGE_VALUE;
wire [6:0] PRODUCT_PRICE_VALUE;

//clock gen
always begin
    #5 CLK = ~CLK;      //10 ns or 100 MHz
end
initial begin
    CLK = 1'b0;
    RST = 1'b1;
    START = 1'b0;
    CANCEL = 1'b0;
    COINS = 1'b0;
    ONLINE_PAYMENT = 0;
    PRODUCT_CODE = 3'b000;

    //Remove reset
    #100 RST = 1'b0;
    #100;

    //pen dispense with online payment
    START = 1'b1;
    ONLINE_PAYMENT = 1'b1;
    #30 START = 1'b0;
ONLINE_PAYMENT = 1'b0;

#50;
START = 1'b1;
PRODUCT_CODE = 3'b001;
COINS = 7'd60;
#30 START = 1'b0;

#50;
START = 1'b1;
PRODUCT_CODE = 3'b100;
COINS = 7'd20;
#30 START = 1'b0;

#50;
START = 1'b1;
PRODUCT_CODE = 3'b100;
COINS = 7'd30;
#30 START = 1'b0;

#50 $finish;
end

// DUT design under test
vending_machine DUT (

.i_clk (),                //Clock Signal
.i_rst (),                //Reset signal (Active high)

.i_start (START),         //Start Signal
.i_cancel (CANCEL),       //Cancel signal
.i_product_code (PRODUCT_CODE), //Product selection input signal
.i_online_payment (ONLINE_PAYMENT), //Online payment signal
.i_total_coin_value (COINS), //Total no of valid coins inserted

//Outputs
.o_state (STATE),                 //Indicates Current state
.o_dispense_product (DISPENSE_PRODUCT), //To dispense the product
.o_return_change (RETURN_CHANGE_VALUE), //Return change value
.o_product_price (PRODUCT_PRICE_VALUE)  //Indicate the price of the selected product

);