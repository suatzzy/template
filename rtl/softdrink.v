/*===============================================================
Copyright (c): Technology Co.,Ltd. ALL rights reserved. 
                                                                        
  Create by:
      Email:
       Date:
   Filename:
Description:
    Version:
Last Change:*/



module  softdrink(
    input               clk,
    input               rstn,           //low active
    input               op_start,       //start option,high active
    input               cancel_flag,    //high active
    input       [1:0]   coin_val,       //the value of the coin,2'b01=0.5,2'b10=1

    output              hold_ind,       //index,high active
    output              charge_ind,     //high active
    output              drink_ind,      //high active
    output      [2:0]   charge_val      //3'b000=0,3'b001=0.5,3'b010=1,3'b011=1.5,3'b100=2,3'b101=2.5,3'b110=3
);
    reg                 hold;
    reg                 charge_in;
    reg                 drink_in;
    reg     [2:0]       charge_va;

    assign  hold_ind    =   hold;
    assign  charge_ind  =   charge_in;
    assign  drink_ind   =   drink_in;
    assign  charge_val  =   charge_va;

    reg [2:0]   cur_state,nxt_state;

    parameter   [2:0]   IDLE = 3'd0;//0
    parameter   [2:0]   S1   = 3'd1;//0.5
    parameter   [2:0]   S2   = 3'd2;//1
    parameter   [2:0]   S3   = 3'd3;//1.5
    parameter   [2:0]   S4   = 3'd4;//2
    parameter   [2:0]   S5   = 3'd5;//2.5
    parameter   [2:0]   S6   = 3'd6;//3

    //state transfer
    always @(posedge clk or negedge rstn) begin
        if(!rstn)
            cur_state <= IDLE;
        else
            cur_state <= nxt_state;
    end

    //state switch
    always @(*)
        case(cur_state)
            IDLE:if(op_start) begin//0
                    if(coin_val == 2'b01)
                        nxt_state = S1;//0.5
                    else if(coin_val == 2'b10)
                        nxt_state = S2;//1
                    else
                        nxt_state = IDLE;
                end
                else//0
                    nxt_state = IDLE;

            S1:if(cancel_flag)//0.5
                    nxt_state = IDLE;
                else if(coin_val == 2'b01)
                    nxt_state = S2;//1
                else if(coin_val == 2'b10)
                    nxt_state = S3;//1.5
                else
                    nxt_state = S1;

            S2:if(cancel_flag)//1
                    nxt_state = IDLE;
                else if(coin_val == 2'b01)
                    nxt_state = S3;//1.5
                else if(coin_val == 2'b10)
                    nxt_state = S4;//2
                else
                    nxt_state = S2;

            S3:if(cancel_flag)//1.5
                    nxt_state = IDLE;
                else if(coin_val == 2'b01)
                    nxt_state = S4;//2
                else if(coin_val == 2'b10)
                    nxt_state = S5;//2.5
                else
                    nxt_state = S3;//1.5

            S4:if(cancel_flag)//2
                    nxt_state = IDLE;
                else if(coin_val == 2'b01)
                    nxt_state = S5;//2.5
                else if(coin_val == 2'b10)
                    nxt_state = S6;//3
                else
                    nxt_state = S4;

            S5:nxt_state = IDLE;
            S6:nxt_state = IDLE;

            default:nxt_state = IDLE;
        endcase

    //output
    always@(cur_state) begin
        if(cur_state == IDLE)
            hold = 1'b0;
        else
            hold = 1'b1;//occupied
    end

    always@(cur_state) begin
        if((cur_state == S5) || (cur_state == S6 ))
            drink_in = 1'b1;//give customers a drink
        else
            drink_in = 1'b0;
    end

    always@(cur_state or cancel_flag) begin
        if(cur_state == IDLE)
            charge_in = 1'b0;
        else if(cur_state == S6)
            charge_in = 1'b1;//0.5
        else if(cur_state == S5) begin
            charge_in = 1'b0;
        end
        else if(cancel_flag)//S1 S2 S3 S4
            charge_in = 1'b1;
        else
            charge_in = 1'b0;
    end

    always@(cur_state or cancel_flag) begin
        if(cur_state == IDLE)//0
            charge_va = 3'b000;//0
        else if(cur_state == S5) begin//2.5
            charge_va = 3'b000;//0
        end
        else if(cur_state == S6) begin//3
            charge_va = 3'b001;//0.5
        end
        else if(cancel_flag) begin//S1 S2 S3 S4
            case(cur_state)
                S1: charge_va = 3'b001;//0.5
                S2: charge_va = 3'b010;//1
                S3: charge_va = 3'b011;//1.5
                S4: charge_va = 3'b100;//2
                default : charge_va = 3'b000;
            endcase
        end
        else
            charge_va = 3'b000;
    end

endmodule
