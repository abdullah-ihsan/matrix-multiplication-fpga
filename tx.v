module uart_tx (
    input  wire clk,        // Baud rate clock
    input  wire rst,        // Reset signal
    input  wire [15:0] data, // Data to transmit
    input  wire start,      // Signal to start transmission
    output reg tx,          // UART TX output
    output reg busy         // High when transmission is ongoing
);

    // Internal signals
    reg [4:0] bit_index;
    reg [15:0] tx_shift;
    reg [1:0] state; // 0: idle, 1: start bit, 2: data bits, 3: stop bit

    // Initial block for initialization
    initial begin
        bit_index = 0;
        tx_shift = 0;
        tx = 1; // Idle state of UART TX
        busy = 0;
        state = 0;
    end

    // UART TX logic
    always @(posedge clk) begin
        if (rst) begin
            bit_index <= 0;
            tx_shift <= 0;
            tx <= 1; // Idle state of UART TX
            busy <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin // Idle state
                    if (start) begin
                        state <= 1;
                        tx_shift <= data;
								bit_index <= 0;
                        busy <= 1;
                    end
                end
                1: begin // Start bit
                    tx <= 0; // Start bit
                    state <= 2;
                end
                2: begin // Data bits
					     
                    tx <= tx_shift[bit_index];
                    bit_index <= bit_index + 1;
						  if (bit_index == 15) begin
                        state <= 3;
                    end

                end
                3: begin // Stop bit
                    tx <= 1; // Stop bit
                    state <= 0;
                    busy <= 0;
                end
            endcase
        end
    end
endmodule