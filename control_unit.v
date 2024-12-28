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
    output reg [3:0] matrix_size,
    output reg read_enable_a,
    output reg read_enable_b
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


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
            matrix_size <= 0;
            element_count <= 0;
        end else begin
            current_state <= next_state;
        end

        next_state = current_state;

        if (rst) begin
            matrix_size <= 0;
            element_count <= 0;
        end else if (current_state == RECEIVE_SIZE) begin
            matrix_size <= rx_data[3:0]; // Assuming matrix size is sent as a 4-bit value
            element_count <= 0;
        end else if ((current_state == RECEIVE_MATRIX_A || current_state == RECEIVE_MATRIX_B) && rx_valid) begin
            element_count <= element_count + 1;
        end else if (current_state == SEND_RESULT && !tx_busy) begin
            element_count <= element_count + 1;
        end

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
                    element_count = 0;
                end
            end
            RECEIVE_MATRIX_B: begin
                if (element_count == (matrix_size * matrix_size - 1) && rx_valid) begin
                    next_state = COMPUTE;
                end
            end
            COMPUTE: begin
                if (mult_done) begin
                    next_state = SEND_RESULT;
                    element_count = 0;
                end
            end
            SEND_RESULT: begin
                if (element_count == 18 && !tx_busy) begin // 18 bytes for 9 elements * 2 bytes each
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
        read_enable_a = 0;
        read_enable_b = 0;

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
                read_enable_a = 1;
                read_enable_b = 1;
            end
            SEND_RESULT: begin
                tx_start = 1;
            end
        endcase
    end
endmodule