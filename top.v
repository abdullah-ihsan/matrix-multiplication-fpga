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
    wire [71:0] a_data, b_data; // 9 elements * 8 bits each
    reg [3:0] a_addr, b_addr;
    wire [143:0] mult_result;
    wire rx_enable, tx_start, mult_start;
    wire [2:0] current_state;
    wire [3:0] matrix_size;
    wire [3:0] read_addr_a, read_addr_b;
    wire read_enable_a, read_enable_b;
    wire mult_done;

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
        .clk(bclk),
        .addr(a_addr),
        .write_data(rx_data),
        .write_enable(rx_valid && (current_state == RECEIVE_MATRIX_A)),
        .read_enable(read_enable_a),
        //.read_data(),
        .a_data(a_data)
    );

    // Instantiate matrix_memory for Matrix B
    matrix_memory matrix_mem_b (
        .clk(bclk),
        .addr(b_addr),
        .write_data(rx_data),
        .write_enable(rx_valid && (current_state == RECEIVE_MATRIX_B)),
        .read_enable(read_enable_b),
        //.read_data(),
        .a_data(b_data)
    );

    // Instantiate control_unit
    control_unit control_inst (
        .clk(bclk),
        .rst(rst),
        .rx_valid(rx_valid),
        .tx_busy(tx_busy),
        .mult_done(mult_done),
        .rx_data(rx_data),
        .rx_enable(rx_enable),
        .tx_start(tx_start),
        .mult_start(mult_start),
        .current_state(current_state),
        .matrix_size(matrix_size),
        .read_enable_a(read_enable_a),
        .read_enable_b(read_enable_b)
    );

    // Instantiate Calculator module
    Calculator matrix_mult_inst (
        .clk(bclk),
        .enable_multiplication(mult_start),
        .A(a_data),
        .B(b_data),
        .result(mult_result)
    );

    // Addressing logic for matrix memories
    always @(posedge bclk or posedge rst) begin
        if (rst) begin
            a_addr <= 0;
            b_addr <= 0;
            result_index <= 0;
            result_byte <= 0;
        end 
        else begin
            if (rx_valid && (current_state == RECEIVE_MATRIX_A)) begin
                a_addr <= a_addr + 1;
            end else if (rx_valid && (current_state == RECEIVE_MATRIX_B)) begin
                b_addr <= b_addr + 1;
            end else if (current_state == SEND_RESULT && !tx_busy) begin
            result_byte <= mult_result[(result_index*8) +: 8];
            result_index <= result_index + 1;
        end
        end
    end
endmodule