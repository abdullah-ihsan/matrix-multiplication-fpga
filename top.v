module top (
    input  wire clk,  // System clock
    input  wire rst,  // Reset signal
    input  wire rx,   // UART RX
    input  wire [1:0] b_sel, // Baud rate select
    output wire tx    // UART TX
);
    // Internal connections
    wire [7:0] rx_data;
    wire rx_valid;
    wire tx_busy;

    // Internal signals
    wire bclk_8, bclk;

    // Instantiate BaudRate module
    BaudRate baud_gen (
        .clk(clk),
        .b_sel(b_sel),
        .bclk_8(bclk_8),
        .bclk(bclk)
    );

    // Instantiate uart_rx module
    uart_rx uart_receiver (
        .clk(bclk),
        .rst(rst),
        .rx(rx),
        .data(rx_data),
        .valid(rx_valid)
    );

    // Instantiate uart_tx module
    uart_tx uart_transmitter (
        .clk(bclk),
        .rst(rst),
        .data(rx_data),
        .start(rx_valid), // Start transmission when valid data is received
        .tx(tx),
        .busy(tx_busy)
    );

    // matrix_memory matrix_mem_a (
    //     .clk(clk),
    //     .addr(a_addr),
    //     .write_data(rx_data),
    //     .write_enable(rx_valid),
    //     .read_data(a_data)
    // );

    // matrix_memory matrix_mem_b (
    //     .clk(clk),
    //     .addr(b_addr),
    //     .write_data(rx_data),
    //     .write_enable(rx_valid),
    //     .read_data(b_data)
    // );

    // matrix_multiplier matrix_mult_inst (
    //     .clk(clk),
    //     .rst(rst),
    //     .a_data(a_data),
    //     .b_data(b_data),
    //     .start(mult_start),
    //     .result(mult_result),
    //     .done(mult_done)
    // );

    // control_unit control_inst (
    //     .clk(clk),
    //     .rst(rst),
    //     .rx_valid(rx_valid),
    //     .tx_busy(tx_busy),
    //     .mult_done(mult_done),
    //     .rx_enable(rx_enable),
    //     .tx_start(tx_start),
    //     .mult_start(mult_start)
    // );
endmodule
