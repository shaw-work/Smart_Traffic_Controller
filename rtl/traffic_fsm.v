module traffic_fsm(
    input clk,
    input rst,
    input night_mode,
    input ped_btn,
    input emergency,

    output reg ns_r, ns_y, ns_g,
    output reg ew_r, ew_y, ew_g,

    output reg [3:0] timer
);

// State encoding
reg [2:0] state;

parameter NS_GREEN   = 3'd0,
          NS_YELLOW  = 3'd1,
          EW_GREEN   = 3'd2,
          EW_YELLOW  = 3'd3,
          PEDESTRIAN = 3'd4,
          NIGHT      = 3'd5,
          EMERGENCY  = 3'd6;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        state <= NS_GREEN;
        timer <= 10;
    end
    else
    begin
        // Highest priority modes
        if (night_mode)
        begin
            state <= NIGHT;
        end
        else if (emergency)
        begin
            state <= EMERGENCY;
        end
        else
        begin
            if (timer > 0)
                timer <= timer - 1;
            else
            begin
                case(state)

                NS_GREEN:
                begin
                    state <= NS_YELLOW;
                    timer <= 3;
                end

                NS_YELLOW:
                begin
                    state <= EW_GREEN;
                    timer <= 10;
                end

                EW_GREEN:
                begin
                    state <= EW_YELLOW;
                    timer <= 3;
                end

                EW_YELLOW:
                begin
                    if (ped_btn)
                    begin
                        state <= PEDESTRIAN;
                        timer <= 5;
                    end
                    else
                    begin
                        state <= NS_GREEN;
                        timer <= 10;
                    end
                end

                PEDESTRIAN:
                begin
                    state <= NS_GREEN;
                    timer <= 10;
                end

                default:
                begin
                    state <= NS_GREEN;
                    timer <= 10;
                end

                endcase
            end
        end
    end
end

always @(*)
begin
    // default all OFF
    ns_r=0; ns_y=0; ns_g=0;
    ew_r=0; ew_y=0; ew_g=0;

    case(state)

    NS_GREEN:
    begin
        ns_g=1; ew_r=1;
    end

    NS_YELLOW:
    begin
        ns_y=1; ew_r=1;
    end

    EW_GREEN:
    begin
        ew_g=1; ns_r=1;
    end

    EW_YELLOW:
    begin
        ew_y=1; ns_r=1;
    end

    PEDESTRIAN:
    begin
        ns_r=1; ew_r=1;
    end

    NIGHT:
    begin
        ns_y=clk;
        ew_y=clk;
    end

    EMERGENCY:
    begin
        ns_g=1;
        ew_r=1;
    end

    default:
    begin
        ns_r=1;
        ew_r=1;
    end

    endcase
end

endmodule