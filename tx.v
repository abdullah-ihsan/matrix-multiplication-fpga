module uart_tx (
    input  wire clk,        // Baud rate clock
    input  wire rst,        // Reset signal
    input  wire [7:0] data, // Data to transmit
    input  wire start,      // Signal to start transmission
    output reg tx,          // UART TX output
    output reg busy         // High when transmission is ongoing
);

    // Internal signals
    reg [3:0] bit_index = 0;
    reg [9:0] tx_shift = 0;

    // UART TX logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_index <= 0;
            tx_shift <= 0;
            tx <= 1; // Idle state of UART TX
            busy <= 0;
        end else begin
            // Logic to transmit data, update tx_shift, and set busy
            // (to be implemented based on UART protocol)
        end
    end
endmodule