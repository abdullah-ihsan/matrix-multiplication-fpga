module MatrixMultiplier(
    input [31:0] A [0:2][0:2], // Input matrix A (3x3)
    input [31:0] B [0:2][0:2], // Input matrix B (3x3)
    output reg [31:0] C [0:2][0:2] // Output matrix C (3x3)
);
    integer i, j, k;

    always @(*) begin
        // Initialize the output matrix to zero
        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                C[i][j] = 0;
            end
        end

        // Perform matrix multiplication
        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                for (k = 0; k < 3; k = k + 1) begin
                    C[i][j] = C[i][j] + (A[i][k] * B[k][j]);
                end
            end
        end
    end
endmodule
