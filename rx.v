module uart_rx (
    input  wire clk,        // Baud rate clock
    input  wire rst,        // Reset signal
    input  wire rx,         // UART RX input
    output reg [7:0] data,  // Received data
    output reg valid        // High when a valid byte is received
);

    // Internal signals
    reg [3:0] bit_index = 0;
    reg [7:0] rx_shift = 0;
    reg [1:0] state = 0; // 0: idle, 1: receiving, 2: stop bit

    // UART RX logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_index <= 0;
            rx_shift <= 0;
            valid <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin // Idle state
                    if (rx == 0) begin // Start bit detected
                        state <= 1;
                        bit_index <= 0;
                    end
                    valid <= 0;
                end
                1: begin // Receiving data bits
                    rx_shift[bit_index] <= rx;
                    bit_index <= bit_index + 1;
                    if (bit_index == 7) begin
                        state <= 2;
                        valid <= 1;
                    end
                end
                2: begin // Stop bit
                    if (rx == 1) begin // Stop bit detected
                        data <= rx_shift[7:0];
                    end
                    state <= 0;
                    valid <= 0;
                end
            endcase
        end
    end
endmodule