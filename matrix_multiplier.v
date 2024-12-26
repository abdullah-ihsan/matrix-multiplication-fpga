module matrix_multiplier (
    input  wire clk,                   // System clock
    input  wire rst,                   // Reset signal
    input  wire start,                 // Start multiplication
    input  wire [3:0] matrix_size,     // Size of the matrix
    input  wire [31:0] a_data,         // Matrix A element
    input  wire [31:0] b_data,         // Matrix B element
    output reg [31:0] result,          // Result of multiplication
    output reg done                    // High when multiplication is complete
);
    // Internal signals
    reg [3:0] row, col, k;
    reg [31:0] sum;
    reg [2:0] state;

    // State Encoding
    parameter IDLE = 3'b000;
    parameter MULTIPLY = 3'b001;
    parameter DONE = 3'b010;

    // State Transition Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            row <= 0;
            col <= 0;
            k <= 0;
            sum <= 0;
            result <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        state <= MULTIPLY;
                        row <= 0;
                        col <= 0;
                        k <= 0;
                        sum <= 0;
                        done <= 0;
                    end
                end
                MULTIPLY: begin
                    sum <= sum + a_data * b_data;
                    if (k == matrix_size - 1) begin
                        result <= sum;
                        sum <= 0;
                        if (col == matrix_size - 1) begin
                            if (row == matrix_size - 1) begin
                                state <= DONE;
                            end else begin
                                row <= row + 1;
                                col <= 0;
                            end
                        end else begin
                            col <= col + 1;
                        end
                        k <= 0;
                    end else begin
                        k <= k + 1;
                    end
                end
                DONE: begin
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule