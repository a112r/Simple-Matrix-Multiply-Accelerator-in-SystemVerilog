`timescale 1ns / 1ps

module tpu_tb;

  parameter WIDTH = 8;
  parameter SIZE  = 4;

  logic clk, rst;
  logic signed [WIDTH-1:0] A [0:SIZE-1][0:SIZE-1];
  logic signed [WIDTH-1:0] B [0:SIZE-1][0:SIZE-1];
  logic signed [2*WIDTH-1:0] C [0:SIZE-1][0:SIZE-1];

  SystolicArray #(WIDTH, SIZE) dut (
    .clk(clk),
    .rst(rst),
    .A(A),
    .B(B),
    .C(C)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;

    // Simple test case: identity × matrix
    A[0] = '{1, 0, 0, 0};
    A[1] = '{0, 1, 0, 0};
    A[2] = '{0, 0, 1, 0};
    A[3] = '{0, 0, 0, 1};

    B[0] = '{1, 2, 3, 4};
    B[1] = '{5, 6, 7, 8};
    B[2] = '{9, 10, 11, 12};
    B[3] = '{13, 14, 15, 16};

    #10 rst = 0;
    #100;

    $display("Output Matrix C:");
    for (int i = 0; i < SIZE; i++) begin
      for (int j = 0; j < SIZE; j++) begin
        $write("%0d ", C[i][j]);
      end
      $write("\n");
    end

    $stop;
  end

endmodule
