`timescale 1ns / 1ps

module tb_matrix_mult_parallel;
    parameter MAX_SIZE = 10; // Maximum matrix size

    // Inputs
    reg [31:0] matrix_size;
    reg [31:0] A [0:MAX_SIZE-1][0:MAX_SIZE-1];
    reg [31:0] B [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Outputs
    wire [31:0] C [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Instantiate the module under test
    matrix_mult_parallel #(.MAX_SIZE(MAX_SIZE)) uut (
        .matrix_size(matrix_size),
        .A(A),
        .B(B),
        .C(C)
    );

    integer i, j;

    initial begin
        // Initialize the matrices
        matrix_size = 3;

        // Initialize matrix A
        A[0][0] = 1; A[0][1] = 2; A[0][2] = 3;
        A[1][0] = 4; A[1][1] = 5; A[1][2] = 6;
        A[2][0] = 7; A[2][1] = 8; A[2][2] = 9;

        // Initialize matrix B
        B[0][0] = 9; B[0][1] = 8; B[0][2] = 7;
        B[1][0] = 6; B[1][1] = 5; B[1][2] = 4;
        B[2][0] = 3; B[2][1] = 2; B[2][2] = 1;

        // Wait for computation
        #10;

        // Display the result matrix
        $display("Resulting Matrix C:");
        for (i = 0; i < matrix_size; i = i + 1) begin
            for (j = 0; j < matrix_size; j = j + 1) begin
                $write("%d ", C[i][j]);
            end
            $display("");
        end

        // Verify the output against expected values
        // Expected C for 3x3:
        // C[0][0] = 30, C[0][1] = 24, C[0][2] = 18
        // C[1][0] = 84, C[1][1] = 69, C[1][2] = 54
        // C[2][0] = 138, C[2][1] = 114, C[2][2] = 90
        if (C[0][0] == 30 && C[0][1] == 24 && C[0][2] == 18 &&
            C[1][0] == 84 && C[1][1] == 69 && C[1][2] == 54 &&
            C[2][0] == 138 && C[2][1] == 114 && C[2][2] == 90) begin
            $display("Test Passed!");
        end else begin
            $display("Test Failed!");
        end

        // End simulation
        $finish;
    end
endmodule
