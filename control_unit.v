module control_unit (
    input wire clk,
    input wire rst,
    input wire rx_valid,
    input wire tx_busy,
    input wire mult_done,
    input wire [7:0] rx_data,
    output reg rx_enable,
    output reg tx_start,
    output reg mult_start,
    output reg [2:0] current_state,
    output reg [3:0] matrix_size
);

    // State encoding
    localparam IDLE = 3'b000,
               RECEIVE_SIZE = 3'b001,
               RECEIVE_MATRIX_A = 3'b010,
               RECEIVE_MATRIX_B = 3'b011,
               COMPUTE = 3'b100,
               SEND_RESULT = 3'b101;

    reg [2:0] next_state;
    reg [15:0] element_count;

    // State transition logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
            matrix_size <= 0;
            element_count <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (rx_valid) begin
                    next_state = RECEIVE_SIZE;
                end
            end
            RECEIVE_SIZE: begin
                if (rx_valid) begin
                    next_state = RECEIVE_MATRIX_A;
                end
            end
            RECEIVE_MATRIX_A: begin
                if (element_count == (matrix_size * matrix_size - 1) && rx_valid) begin
                    next_state = RECEIVE_MATRIX_B;
                end
            end
            RECEIVE_MATRIX_B: begin
                if (element_count == (2 * matrix_size * matrix_size - 1) && rx_valid) begin
                    next_state = COMPUTE;
                end
            end
            COMPUTE: begin
                if (mult_done) begin
                    next_state = SEND_RESULT;
                end
            end
            SEND_RESULT: begin
                if (!tx_busy) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Output logic
    always @(*) begin
        // Default values
        rx_enable = 0;
        tx_start = 0;
        mult_start = 0;

        case (current_state)
            IDLE: begin
                rx_enable = 1;
            end
            RECEIVE_SIZE: begin
                rx_enable = 1;
            end
            RECEIVE_MATRIX_A: begin
                rx_enable = 1;
            end
            RECEIVE_MATRIX_B: begin
                rx_enable = 1;
            end
            COMPUTE: begin
                mult_start = 1;
            end
            SEND_RESULT: begin
                tx_start = 1;
            end
        endcase
    end

    // Matrix size and element count
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            matrix_size <= 0;
            element_count <= 0;
        end else if (current_state == RECEIVE_SIZE && rx_valid) begin
            matrix_size <= rx_data[3:0]; // Assuming matrix size is sent as a 4-bit value
            element_count <= 0;
        end else if ((current_state == RECEIVE_MATRIX_A || current_state == RECEIVE_MATRIX_B) && rx_valid) begin
            element_count <= element_count + 1;
        end else if (current_state == SEND_RESULT && !tx_busy) begin
            element_count <= element_count - 1;
        end
    end
endmodule