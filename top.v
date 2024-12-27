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
    wire [31:0] a_data, b_data;
    wire [3:0] a_addr, b_addr;
    wire rx_enable, tx_start;
    wire [2:0] current_state;
    wire [3:0] matrix_size;


    // Internal signals
    wire bclk_8, bclk;

        // State encoding
    localparam IDLE = 3'b000,
               RECEIVE_SIZE = 3'b001,
               RECEIVE_MATRIX_A = 3'b010,
               RECEIVE_MATRIX_B = 3'b011,
               COMPUTE = 3'b100,
               SEND_RESULT = 3'b101;

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
        .data(rx_data), // For now, just loop back the received data
        .start(tx_start),
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

    // Instantiate control_unit
    control_unit control_inst (
        .clk(clk),
        .rst(rst),
        .rx_valid(rx_valid),
        .tx_busy(tx_busy),
        .rx_data(rx_data),
        .rx_enable(rx_enable),
        .tx_start(tx_start),
        .current_state(current_state),
        .matrix_size(matrix_size)
    );

    // Addressing logic for matrix memories
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a_addr <= 0;
            b_addr <= 0;
        end else begin
            if (rx_valid && (current_state == RECEIVE_MATRIX_A)) begin
                a_addr <= a_addr + 1;
            end else if (rx_valid && (current_state == RECEIVE_MATRIX_B)) begin
                b_addr <= b_addr + 1;
            end
        end
    end
endmodule