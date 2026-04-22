module clock_divider #
(
    parameter COUNT_MAX = 50000000   // use 50M for 1Hz from 100MHz clk
)
(
    input clk,
    input rst,
    output reg clk_1hz
);

reg [31:0] count;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        count   <= 0;
        clk_1hz <= 0;
    end
    else
    begin
        if (count == COUNT_MAX - 1)
        begin
            count   <= 0;
            clk_1hz <= ~clk_1hz;
        end
        else
        begin
            count <= count + 1;
        end
    end
end

endmodule