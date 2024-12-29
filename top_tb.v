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
    always #10 clk = ~clk; // 50 MHz clock (20 ns period)

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

    initial begin
        // Initialize signals
        clk = 0;
        //rst = 1;
        //rx = 1; // Idle state of UART RX
        b_sel = 2'b01; // Set baud rate to 9600

        // Reset the system
        #20;
        //rst = 0;

        // Simulate receiving matrix size (2x2 matrix)
        uart_rx_byte(8'h03);

        // Simulate receiving Matrix A (2x2 matrix)
        uart_rx_byte(8'h01); // A[0][0]
        uart_rx_byte(8'h02); // A[0][1]
        uart_rx_byte(8'h03); // A[1][0]
        uart_rx_byte(8'h04); // A[1][1]
        uart_rx_byte(8'h03); // A[1][0]
        uart_rx_byte(8'h04); // A[1][1]
        uart_rx_byte(8'h04); // A[1][1]
        uart_rx_byte(8'h03); // A[1][0]
        uart_rx_byte(8'h04); // A[1][1]

        // Simulate receiving Matrix B (2x2 matrix)
        uart_rx_byte(8'h05); // B[0][0]
        uart_rx_byte(8'h06); // B[0][1]
        uart_rx_byte(8'h07); // B[1][0]
        uart_rx_byte(8'h08); // B[1][1]
        uart_rx_byte(8'h07); // B[1][0]
        uart_rx_byte(8'h08); // B[1][1]
        uart_rx_byte(8'h08); // B[1][1]
        uart_rx_byte(8'h07); // B[1][0]
        uart_rx_byte(8'h08); // B[1][1]

        // Wait for multiplication and transmission to complete
        #20000000; // Wait for enough time to complete transmission

        // End simulation
        $stop;
    end

endmodule
