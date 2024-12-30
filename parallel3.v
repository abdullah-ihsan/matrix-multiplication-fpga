module Calculator(
    input clk,
    input enable_multiplication,  // Control for enabling multiplication
    input [71:0] A, // Single array for matrix A
    input [71:0] B, // Single array for matrix B
    output reg [143:0] result, // Single array for result
    output reg mult_done
);

    reg [7:0] A1 [0:2][0:2];
    reg [7:0] B1 [0:2][0:2];
    reg [15:0] Res1 [0:2][0:2];

    wire [15:0] partial_products [0:8];

    // Assign input matrices to 2D arrays for processing
    always @(*) begin
        A1[0][0] = A[7:0];   A1[0][1] = A[15:8];  A1[0][2] = A[23:16];
        A1[1][0] = A[31:24]; A1[1][1] = A[39:32]; A1[1][2] = A[47:40];
        A1[2][0] = A[55:48]; A1[2][1] = A[63:56]; A1[2][2] = A[71:64];

        B1[0][0] = B[7:0];   B1[0][1] = B[15:8];  B1[0][2] = B[23:16];
        B1[1][0] = B[31:24]; B1[1][1] = B[39:32]; B1[1][2] = B[47:40];
        B1[2][0] = B[55:48]; B1[2][1] = B[63:56]; B1[2][2] = B[71:64];
    end

    // Parallel computation of matrix multiplication
    assign partial_products[0] = A1[0][0] * B1[0][0] + A1[0][1] * B1[1][0] + A1[0][2] * B1[2][0];
    assign partial_products[1] = A1[0][0] * B1[0][1] + A1[0][1] * B1[1][1] + A1[0][2] * B1[2][1];
    assign partial_products[2] = A1[0][0] * B1[0][2] + A1[0][1] * B1[1][2] + A1[0][2] * B1[2][2];

    assign partial_products[3] = A1[1][0] * B1[0][0] + A1[1][1] * B1[1][0] + A1[1][2] * B1[2][0];
    assign partial_products[4] = A1[1][0] * B1[0][1] + A1[1][1] * B1[1][1] + A1[1][2] * B1[2][1];
    assign partial_products[5] = A1[1][0] * B1[0][2] + A1[1][1] * B1[1][2] + A1[1][2] * B1[2][2];

    assign partial_products[6] = A1[2][0] * B1[0][0] + A1[2][1] * B1[1][0] + A1[2][2] * B1[2][0];
    assign partial_products[7] = A1[2][0] * B1[0][1] + A1[2][1] * B1[1][1] + A1[2][2] * B1[2][1];
    assign partial_products[8] = A1[2][0] * B1[0][2] + A1[2][1] * B1[1][2] + A1[2][2] * B1[2][2];

    // Capture results on clock edge
    always @(posedge clk) begin
        if (enable_multiplication) begin
            Res1[0][0] <= partial_products[0]; Res1[0][1] <= partial_products[1]; Res1[0][2] <= partial_products[2];
            Res1[1][0] <= partial_products[3]; Res1[1][1] <= partial_products[4]; Res1[1][2] <= partial_products[5];
            Res1[2][0] <= partial_products[6]; Res1[2][1] <= partial_products[7]; Res1[2][2] <= partial_products[8];

            // Assign result to single array
            result <= {Res1[2][2], Res1[2][1], Res1[2][0],
                       Res1[1][2], Res1[1][1], Res1[1][0],
                       Res1[0][2], Res1[0][1], Res1[0][0]};
            mult_done <= 1'b1;
        end else begin
            mult_done <= 1'b0;
        end
    end
endmodule
