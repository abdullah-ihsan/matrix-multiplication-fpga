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
    always #10 clk = ~clk; // 100 MHz clock

    // UART RX task to simulate receiving data
    task uart_rx_byte;
        input [7:0] byte;
        integer i;
        begin
            // Start bit
            rx = 0;
            #208320; // Wait for one baud period (9600 baud rate) at 50 MHz clock

            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = byte[i];
                #208320; // Wait for one baud period
            end

            // Stop bit
            rx = 1;
            #208320; // Wait for one baud period
        end
    endtask
		        integer i;
    initial begin
        // Initialize signals
        clk = 0;
        //rst = 1;
        //rx = 1; // Idle state of UART RX
        b_sel = 2'b01; // Set baud rate to 9600

        // Reset the system
        #20;
        //rst = 0;

        // Simulate receiving matrix size (10x10 matrix)
        uart_rx_byte(8'h0A); // Size for 10x10 matrix (0x0A)

        // Simulate receiving Matrix A (10x10 matrix)
        // We simulate the first 100 elements as a simple example

        for (i = 0; i < 100; i = i + 1) begin
            uart_rx_byte(i + 8'h01); // A[i] = i + 1
        end

        // Simulate receiving Matrix B (10x10 matrix)
        // We simulate the first 100 elements as a simple example
        for (i = 0; i < 100; i = i + 1) begin
            uart_rx_byte(8'hFF - i); // B[i] = 0xFF - i
        end

        // Wait for multiplication and transmission to complete
        #2000000000; // Wait for enough time to complete transmission

        // End simulation
        $stop;
    end

endmodule
