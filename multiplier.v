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
    
    integer i, j, k;
    
    always @ (posedge clk) begin
        if (enable_multiplication) begin
            // Convert inputs to 2D arrays for easier processing
            A1[0][0] = A[7:0];   A1[0][1] = A[15:8];  A1[0][2] = A[23:16];
            A1[1][0] = A[31:24]; A1[1][1] = A[39:32]; A1[1][2] = A[47:40];
            A1[2][0] = A[55:48]; A1[2][1] = A[63:56]; A1[2][2] = A[71:64];
        
            B1[0][0] = B[7:0];   B1[0][1] = B[15:8];  B1[0][2] = B[23:16];
            B1[1][0] = B[31:24]; B1[1][1] = B[39:32]; B1[1][2] = B[47:40];
            B1[2][0] = B[55:48]; B1[2][1] = B[63:56]; B1[2][2] = B[71:64];
        
            // Initialize result matrix to zero
            Res1[0][0] = 16'd0; Res1[0][1] = 16'd0; Res1[0][2] = 16'd0;
            Res1[1][0] = 16'd0; Res1[1][1] = 16'd0; Res1[1][2] = 16'd0;
            Res1[2][0] = 16'd0; Res1[2][1] = 16'd0; Res1[2][2] = 16'd0;
        
            // Matrix multiplication
            for (i = 0; i < 3; i = i + 1) begin
                for (j = 0; j < 3; j = j + 1) begin
                    for (k = 0; k < 3; k = k + 1) begin
                        Res1[i][j] = Res1[i][j] + A1[i][k] * B1[k][j];
                    end
                end
            end
            
            // Assign result to single array
            result = {Res1[2][2], Res1[2][1], Res1[2][0],
                      Res1[1][2], Res1[1][1], Res1[1][0],
                      Res1[0][2], Res1[0][1], Res1[0][0]};
            mult_done = 1'b1;
        end
    end
endmodule