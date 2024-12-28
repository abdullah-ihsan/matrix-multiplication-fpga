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
    reg [15:0] elements_received;  // Counter for receiving elements
    reg [15:0] elements_sent;      // Counter for sending results
    
    // Calculate total elements needed for one matrix
    wire [15:0] total_elements = matrix_size * matrix_size;
    // Completion flags
    wire matrix_a_done = (elements_received == total_elements - 1) && rx_valid && (current_state == RECEIVE_MATRIX_A);
    wire matrix_b_done = (elements_received == total_elements - 1) && rx_valid && (current_state == RECEIVE_MATRIX_B);
    wire result_done = (elements_sent == 18 && !tx_busy);  // 18 bytes for 9 elements * 2 bytes each

    // State transition logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
            matrix_size <= 0;
            elements_received <= 0;
            elements_sent <= 0;
        end else begin
            current_state <= next_state;
            
            case (current_state)
                RECEIVE_SIZE: begin
                    if (rx_valid) begin
                        matrix_size <= rx_data[3:0];
                        elements_received <= 0;
                    end
                end
                RECEIVE_MATRIX_A: begin
                    if (rx_valid) begin
                        if (matrix_a_done)
                            elements_received <= 0;
                        else
                            elements_received <= elements_received + 1;
                    end
                end
                RECEIVE_MATRIX_B: begin
                    if (rx_valid) begin
                        elements_received <= elements_received + 1;
                    end
                end
                COMPUTE: begin
                    if (mult_done) begin
                        elements_sent <= 0;
                    end
                end
                SEND_RESULT: begin
                    if (!tx_busy) begin
                        elements_sent <= elements_sent + 1;
                    end
                end
            endcase
        end
    end

    // Next state logic
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
                if (matrix_a_done) begin
                    next_state = RECEIVE_MATRIX_B;
                end
            end
            RECEIVE_MATRIX_B: begin
                if (matrix_b_done) begin
                    next_state = COMPUTE;
                end
            end
            COMPUTE: begin
                if (mult_done) begin
                    next_state = SEND_RESULT;
                end
            end
            SEND_RESULT: begin
                if (result_done) begin
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