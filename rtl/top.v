module top(
    input clk,
    input rst,
    input night_mode,
    input ped_btn,
    input emergency,

    output ns_r,
    output ns_y,
    output ns_g,

    output ew_r,
    output ew_y,
    output ew_g,

    output [6:0] seg,
    output [3:0] an
);

wire clk_1hz;
wire [3:0] timer;

// Clock Divider
clock_divider #(
    .COUNT_MAX(5)     // fast for simulation
)
u1 (
    .clk(clk),
    .rst(rst),
    .clk_1hz(clk_1hz)
);

// Traffic FSM
traffic_fsm u2 (
    .clk(clk_1hz),
    .rst(rst),
    .night_mode(night_mode),
    .ped_btn(ped_btn),
    .emergency(emergency),

    .ns_r(ns_r),
    .ns_y(ns_y),
    .ns_g(ns_g),

    .ew_r(ew_r),
    .ew_y(ew_y),
    .ew_g(ew_g),

    .timer(timer)
);

// 7-Segment Display
seven_seg u3 (
    .num(timer),
    .seg(seg),
    .an(an)
);

endmodule