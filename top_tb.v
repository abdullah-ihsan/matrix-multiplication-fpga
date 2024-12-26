`timescale 1ns / 1ps

module top_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg rx;
    reg [1:0] b_sel;
    wire tx;

    // Instantiate the top module
    top uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .b_sel(b_sel),
        .tx(tx)
    );

    // Clock generation
    always #5 clk = ~clk; // 100 MHz clock

    // UART RX task to simulate receiving data
    task uart_rx_byte;
        input [7:0] byte;
        integer i;
        begin
            // Start bit
            rx = 0;
            #104160; // Wait for one baud period (9600 baud rate)

            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = byte[i];
                #104160; // Wait for one baud period
            end

            // Stop bit
            rx = 1;
            #104160; // Wait for one baud period
        end
    endtask

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        rx = 1; // Idle state of UART RX
        b_sel = 2'b01; // Set baud rate to 9600

        // Reset the system
        #20;
        rst = 0;

        // Simulate receiving a byte
        #100;
        uart_rx_byte(8'hA5); // Send 0xA5

        // Wait for transmission to complete
        #2000000; // Wait for enough time to complete transmission

        // End simulation
        $stop;
    end

endmodule