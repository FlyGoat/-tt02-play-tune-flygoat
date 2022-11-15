/* 
This file provides the mapping from the Wokwi modules to Verilog HDL

It's only needed for Wokwi designs

*/
`define default_netname none

module buffer_cell (
    input wire in,
    output wire out
    );
    assign out = in;
endmodule

module and_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a & b;
endmodule

module or_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a | b;
endmodule

module xor_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a ^ b;
endmodule

module nand_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = !(a&b);
endmodule

module not_cell (
    input wire in,
    output wire out
    );

    assign out = !in;
endmodule

module mux_cell (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
    );

    assign out = sel ? b : a;
endmodule

module dff_cell (
    input wire clk,
    input wire d,
    output reg q,
    output wire notq
    );

    assign notq = !q;
    always @(posedge clk)
        q <= d;

endmodule

module dffsr_cell (
    input wire clk,
    input wire d,
    input wire s,
    input wire r,
    output reg q,
    output wire notq
    );

    assign notq = !q;

    always @(posedge clk or posedge s or posedge r) begin
        if (r)
            q <= '0;
        else if (s)
            q <= '1;
        else
            q <= d;
    end
endmodule

module mux4_cell          ( input  a,                 // input called a  
                            input  b,                 // input called b  
                            input  c,                 // input called c  
                            input  d,                 // input called d  
                            input [1:0] sel,          // input sel used to select between a,b,c,d  
                            output out);              // output based on input sel  
    
    assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);  
    
endmodule
