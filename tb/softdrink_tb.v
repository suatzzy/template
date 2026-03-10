/*===============================================================
Copyright (c): Technology Co.,Ltd. ALL rights reserved. 
                                                                        
  Create by:
      Email:
       Date:
   Filename:
Description:
    Version:
Last Change:*/





module  softdrink_tb;
    reg                 clk;
    reg                 rstn;
    reg                 op_start;
    reg                 cancel_flag;
    reg [1:0]           coin_val;

    wire                hold_ind;
    wire                charge_ind;
    wire                drink_ind;
    wire [2:0]          charge_val;

    initial begin
        clk             = 1'b0;
        rstn            = 1'b0;
        op_start        = 1'b1;
        cancel_flag     = 1'b0;
        //coin_val      = 2'b00;
    end

    initial begin
        #10 rstn        = 1'b1;
        #150
        cancel_flag     = 1'b1;
        #50
        cancel_flag     = 1'b0;
        #1000;
        $finish;
    end

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            coin_val <= 2'b00;
        end
        else begin
            coin_val <= {$random}%3;//00 01 10
        end
    end

    always #50  op_start = {$random}%2;//0 1

    always #5   clk = ~clk;

    softdrink u0(
        .clk(clk),
        .rstn(rstn),
        .op_start(op_start),
        .cancel_flag(cancel_flag),
        .hold_ind(hold_ind),
        .charge_val(charge_val),
        .charge_ind(charge_ind),
        .drink_ind(drink_ind),
        .coin_val(coin_val)
    );

    always@(posedge clk)  begin
        if(drink_ind)     begin
            $display(".............");
            $display("A bottle of drink was sold!");
            $display(".............");
        end
    end

endmodule
