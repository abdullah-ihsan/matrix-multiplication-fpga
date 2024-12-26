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
        .start(tx_start), // Start transmission when valid data is received
        .tx(tx),
        .busy(tx_busy)
    );

    // Instantiate matrix_memory for Matrix A
    matrix_memory matrix_mem_a (
        .clk(clk),
        .addr(a_addr),
        .write_data(rx_data),
        .write_enable(rx_valid && (current_state == RECEIVE_MATRIX_A)),
        .read_data(a_data)
    );

    // Instantiate matrix_memory for Matrix B
    matrix_memory matrix_mem_b (
        .clk(clk),
        .addr(b_addr),
        .write_data(rx_data),
        .write_enable(rx_valid && (current_state == RECEIVE_MATRIX_B)),
        .read_data(b_data)
    );

    // Instantiate matrix_memory for Result
    matrix_memory result_mem (
        .clk(clk),
        .addr(result_addr),
        .write_data(mult_result),
        .write_enable(mult_done),
        .read_data(rx_data) // Reuse rx_data for transmission
    );

    // Instantiate matrix_multiplier
    matrix_multiplier matrix_mult_inst (
        .clk(clk),
        .rst(rst),
        .a_data(a_data),
        .b_data(b_data),
        .start(mult_start),
        .result(mult_result),
        .done(mult_done)
    );

    // Instantiate control_unit
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

    // Addressing logic for matrix memories
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a_addr <= 0;
            b_addr <= 0;
            result_addr <= 0;
        end else begin
            if (rx_valid && (current_state == RECEIVE_MATRIX_A)) begin
                a_addr <= a_addr + 1;
            end else if (rx_valid && (current_state == RECEIVE_MATRIX_B)) begin
                b_addr <= b_addr + 1;
            end else if (mult_done) begin
                result_addr <= result_addr + 1;
            end
        end
    end
endmodule