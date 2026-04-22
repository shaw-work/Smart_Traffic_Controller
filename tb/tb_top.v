module tb_top;

reg clk;
reg rst;
reg night_mode;
reg ped_btn;
reg emergency;

wire ns_r, ns_y, ns_g;
wire ew_r, ew_y, ew_g;
wire [6:0] seg;
wire [3:0] an;

top dut (
    .clk(clk),
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

    .seg(seg),
    .an(an)
);

// Clock generation
always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    night_mode = 0;
    ped_btn = 0;
    emergency = 0;

    #20 rst = 0;

    // Let normal cycle run
    #300;

    // Pedestrian request
    ped_btn = 1;
    #20;
    ped_btn = 0;

    #300;

    // Emergency mode
    emergency = 1;
    #100;
    emergency = 0;

    #200;

    // Night mode
    night_mode = 1;
    #100;
    night_mode = 0;

    #200;

    $stop;
end

endmodule