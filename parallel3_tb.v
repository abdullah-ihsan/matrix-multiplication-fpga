module Calculator_tb;
    // Testbench signals
    reg clk;
    reg enable_multiplication;
    reg [71:0] A;
    reg [71:0] B;
    wire [143:0] result;
    wire mult_done;

    // Instantiate the Calculator module
    Calculator uut (
        .clk(clk),
        .enable_multiplication(enable_multiplication),
        .A(A),
        .B(B),
        .result(result),
        .mult_done(mult_done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test vectors
    initial begin
        // Initialize signals
        enable_multiplication = 0;
        A = 0;
        B = 0;

        // Wait for a few clock cycles
        #20;

        // Test Case 1: Simple matrix multiplication
        A = {
            8'd1, 8'd2, 8'd3, // Row 1
            8'd4, 8'd5, 8'd6, // Row 2
            8'd7, 8'd8, 8'd9  // Row 3
        };
        B = {
            8'd9, 8'd8, 8'd7, // Row 1
            8'd6, 8'd5, 8'd4, // Row 2
            8'd3, 8'd2, 8'd1  // Row 3
        };

        enable_multiplication = 1;
        #10;
        enable_multiplication = 0;

        // Wait for computation to finish
        #100;

        // Check result
        $display("Result: %h", result);
        $display("Expected: 000000f6 0000014a 0000019e 0000012c 00000186 000001e0 00000162 000001c2 00000222");

        // Test Case 2: Identity matrix multiplication
        A = {
            8'd1, 8'd0, 8'd0, // Row 1
            8'd0, 8'd1, 8'd0, // Row 2
            8'd0, 8'd0, 8'd1  // Row 3
        };
        B = {
            8'd1, 8'd2, 8'd3, // Row 1
            8'd4, 8'd5, 8'd6, // Row 2
            8'd7, 8'd8, 8'd9  // Row 3
        };

        enable_multiplication = 1;
        #10;
        enable_multiplication = 0;

        // Wait for computation to finish
        #100;

        // Check result
        $display("Result: %h", result);
        $display("Expected: 00000003 00000009 0000000f 00000012 00000015 00000018 00000021 00000024 00000027");

        // End simulation
        $finish;
    end
endmodule
