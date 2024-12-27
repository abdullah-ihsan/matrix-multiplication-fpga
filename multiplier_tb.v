`timescale 1ns / 1ps

module Calculator_tb;
    // Declare testbench variables
    reg clk;
    reg enable_multiplication;
    reg [15:0] A00, A01, A02, A10, A11, A12, A20, A21, A22;  // Matrix A elements
    reg [15:0] B00, B01, B02, B10, B11, B12, B20, B21, B22;  // Matrix B elements
    wire [15:0] R00, R01, R02, R10, R11, R12, R20, R21, R22;  // Matrix C elements (Result)

    // Instantiate the Calculator module (DUT)
    Calculator uut (
        .clk(clk),
        .enable_multiplication(enable_multiplication),
        .A00(A00), .A01(A01), .A02(A02),
        .A10(A10), .A11(A11), .A12(A12),
        .A20(A20), .A21(A21), .A22(A22),
        .B00(B00), .B01(B01), .B02(B02),
        .B10(B10), .B11(B11), .B12(B12),
        .B20(B20), .B21(B21), .B22(B22),
        .R00(R00), .R01(R01), .R02(R02),
        .R10(R10), .R11(R11), .R12(R12),
        .R20(R20), .R21(R21), .R22(R22)
    );

    // Generate clock signal
    always #5 clk = ~clk; // 10 ns clock period

    // Initialize inputs and monitor outputs
    initial begin
        // Initialize clock and enable signals
        clk = 0;
        enable_multiplication = 0;

        // Initialize input matrices for Test Case 1
        A00 = 16'd1; A01 = 16'd0; A02 = 16'd0;
        A10 = 16'd0; A11 = 16'd1; A12 = 16'd0;
        A20 = 16'd0; A21 = 16'd0; A22 = 16'd1;

        B00 = 16'd2; B01 = 16'd3; B02 = 16'd4;
        B10 = 16'd1; B11 = 16'd0; B12 = 16'd6;
        B20 = 16'd7; B21 = 16'd5; B22 = 16'd1;

        // Test Case 1: Multiply identity matrix with another matrix
        $display("Test Case 1: Multiplying Identity Matrix with Another Matrix");
        enable_multiplication = 1; // Enable multiplication
        #10; // Wait for a clock cycle to allow multiplication to complete
        $display("Output Matrix C:");
        $display("%d %d %d", R00, R01, R02);
        $display("%d %d %d", R10, R11, R12);
        $display("%d %d %d", R20, R21, R22);

        // Test Case 2: Multiply two random matrices
        $display("\nTest Case 2: Multiplying Two Random Matrices");

        A00 = 16'd1; A01 = 16'd2; A02 = 16'd3;
        A10 = 16'd4; A11 = 16'd5; A12 = 16'd6;
        A20 = 16'd7; A21 = 16'd8; A22 = 16'd9;

        B00 = 16'd9; B01 = 16'd8; B02 = 16'd7;
        B10 = 16'd6; B11 = 16'd5; B12 = 16'd4;
        B20 = 16'd3; B21 = 16'd2; B22 = 16'd1;

        enable_multiplication = 1; // Enable multiplication
        #10; // Wait for a clock cycle to allow multiplication to complete
        $display("Output Matrix C:");
        $display("%d %d %d", R00, R01, R02);
        $display("%d %d %d", R10, R11, R12);
        $display("%d %d %d", R20, R21, R22);

        // Test Case 3: Zero matrix multiplied with any matrix
        $display("\nTest Case 3: Multiplying Zero Matrix with Another Matrix");

        A00 = 16'd0; A01 = 16'd0; A02 = 16'd0;
        A10 = 16'd0; A11 = 16'd0; A12 = 16'd0;
        A20 = 16'd0; A21 = 16'd0; A22 = 16'd0;

        B00 = 16'd9; B01 = 16'd8; B02 = 16'd7;
        B10 = 16'd6; B11 = 16'd5; B12 = 16'd4;
        B20 = 16'd3; B21 = 16'd2; B22 = 16'd1;

        enable_multiplication = 1; // Enable multiplication
        #10; // Wait for a clock cycle to allow multiplication to complete
        $display("Output Matrix C (Zero Matrix multiplied):");
        $display("%d %d %d", R00, R01, R02);
        $display("%d %d %d", R10, R11, R12);
        $display("%d %d %d", R20, R21, R22);

        $finish;
    end
endmodule