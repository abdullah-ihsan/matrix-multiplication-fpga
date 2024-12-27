`timescale 1ns / 1ps

module MatrixMultiplier_tb;
    // Declare testbench variables
    reg [31:0] A [0:2][0:2]; // Input matrix A
    reg [31:0] B [0:2][0:2]; // Input matrix B
    wire [31:0] C [0:2][0:2]; // Output matrix C

    // Instantiate the design under test (DUT)
    MatrixMultiplier uut (
        .A(A),
        .B(B),
        .C(C)
    );

    // Initialize inputs and monitor outputs
    initial begin
        // Initialize waveform dump
        $dumpfile("MatrixMultiplier_tb.vcd");
        $dumpvars(0, MatrixMultiplier_tb);

        // Test Case 1
        $display("Test Case 1: Multiplying Identity Matrix with Another Matrix");
        A[0][0] = 1; A[0][1] = 0; A[0][2] = 0;
        A[1][0] = 0; A[1][1] = 1; A[1][2] = 0;
        A[2][0] = 0; A[2][1] = 0; A[2][2] = 1;

        B[0][0] = 2; B[0][1] = 3; B[0][2] = 4;
        B[1][0] = 1; B[1][1] = 0; B[1][2] = 6;
        B[2][0] = 7; B[2][1] = 5; B[2][2] = 1;

        #10; // Wait for computations
        $display("Output Matrix C:");
        $display("%d %d %d", C[0][0], C[0][1], C[0][2]);
        $display("%d %d %d", C[1][0], C[1][1], C[1][2]);
        $display("%d %d %d", C[2][0], C[2][1], C[2][2]);

        // Test Case 2
        $display("\nTest Case 2: Multiplying Two Random Matrices");
        A[0][0] = 1; A[0][1] = 2; A[0][2] = 3;
        A[1][0] = 4; A[1][1] = 5; A[1][2] = 6;
        A[2][0] = 7; A[2][1] = 8; A[2][2] = 9;

        B[0][0] = 9; B[0][1] = 8; B[0][2] = 7;
        B[1][0] = 6; B[1][1] = 5; B[1][2] = 4;
        B[2][0] = 3; B[2][1] = 2; B[2][2] = 1;

        #10; // Wait for computations
        $display("Output Matrix C:");
        $display("%d %d %d", C[0][0], C[0][1], C[0][2]);
        $display("%d %d %d", C[1][0], C[1][1], C[1][2]);
        $display("%d %d %d", C[2][0], C[2][1], C[2][2]);

        $finish;
    end
endmodule
