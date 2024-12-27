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
        .clk(bclk),
        .addr(a_addr),
        .write_data(rx_data),
        .write_enable(rx_valid && (current_state == RECEIVE_MATRIX_A)),
        .read_data(a_data)
    );

    // Instantiate matrix_memory for Matrix B
    matrix_memory matrix_mem_b (
        .clk(bclk),
        .addr(b_addr),
        .write_data(rx_data),
        .write_enable(rx_valid && (current_state == RECEIVE_MATRIX_B)),
        .read_data(b_data)
    );

    // Instantiate control_unit
    control_unit control_inst (
        .clk(bclk),
        .rst(rst),
        .rx_valid(rx_valid),
        .tx_busy(tx_busy),
        .rx_data(rx_data),
        .rx_enable(rx_enable),
        .tx_start(tx_start),
        .current_state(current_state),
        .matrix_size(matrix_size)
    );

        // Instantiate Calculator module
    Calculator matrix_mult_inst (
        .clk(bclk),
        .enable_multiplication(mult_start),
        .A00(a_data[15:0]), .A01(a_data[31:16]), .A02(a_data[47:32]),
        .A10(a_data[63:48]), .A11(a_data[79:64]), .A12(a_data[95:80]),
        .A20(a_data[111:96]), .A21(a_data[127:112]), .A22(a_data[143:128]),
        .B00(b_data[15:0]), .B01(b_data[31:16]), .B02(b_data[47:32]),
        .B10(b_data[63:48]), .B11(b_data[79:64]), .B12(b_data[95:80]),
        .B20(b_data[111:96]), .B21(b_data[127:112]), .B22(b_data[143:128]),
        .R00(mult_result[15:0]), .R01(mult_result[31:16]), .R02(mult_result[47:32]),
        .R10(mult_result[63:48]), .R11(mult_result[79:64]), .R12(mult_result[95:80]),
        .R20(mult_result[111:96]), .R21(mult_result[127:112]), .R22(mult_result[143:128])
    );


    // Addressing logic for matrix memories
    always @(posedge bclk or posedge rst) begin
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