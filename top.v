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
    wire mult_done;
    wire [31:0] a_data, b_data, mult_result;
    wire [3:0] a_addr, b_addr, result_addr;
    wire rx_enable, tx_start, mult_start;
    wire [2:0] current_state;
    wire [3:0] matrix_size;

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
        .start(tx_start),
        .tx(tx),
        .busy(tx_busy)
    );

    // Instantiate control unit
    control_unit control_inst (
        .clk(clk),
        .rst(rst),
        .rx_valid(rx_valid),
        .tx_busy(tx_busy),
        .mult_done(mult_done),
        .rx_data(rx_data),
        .rx_enable(rx_enable),
        .tx_start(tx_start),
        .mult_start(mult_start),
        .current_state(current_state),
        .matrix_size(matrix_size)
    );

    // Instantiate other modules (matrix_memory, matrix_multiplier, etc.)
    // ...
endmodule