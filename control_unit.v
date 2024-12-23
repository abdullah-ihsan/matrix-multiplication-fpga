module control_unit (
    input  wire clk,       // System clock
    input  wire rst,       // Reset signal
    input  wire rx_valid,  // UART RX data valid
    input  wire tx_busy,   // UART TX busy signal
    input  wire mult_done, // Matrix multiplication done
    output reg rx_enable,  // Enable UART RX
    output reg tx_start,   // Start UART TX
    output reg mult_start  // Start multiplication
);
    // FSM states
    typedef enum logic [2:0] {
        IDLE,
        RECEIVE_DATA,
        COMPUTE,
        SEND_RESULT
    } state_t;
    state_t current_state, next_state;

    // FSM transitions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // FSM next state logic
    always @(*) begin
        case (current_state)
            IDLE: next_state = rx_valid ? RECEIVE_DATA : IDLE;
            RECEIVE_DATA: next_state = COMPUTE;
            COMPUTE: next_state = mult_done ? SEND_RESULT : COMPUTE;
            SEND_RESULT: next_state = tx_busy ? SEND_RESULT : IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output control signals
    always @(*) begin
        rx_enable = (current_state == RECEIVE_DATA);
        mult_start = (current_state == COMPUTE);
        tx_start = (current_state == SEND_RESULT);
    end
endmodule
