`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.08.2016 10:58:42
// Design Name: 
// Module Name: myModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module myModule_tb();
	wire out;
	wire out2;
	reg clock;
	reg clock1;

	always begin;
#1	clock = !clock;
#0.5 clock1 = !clock1;
end

initial begin
//initialise clock
clock = 0;
clock1 = 1;

//End Simulation
#20
$finish;
    end

	myModule andGate(clock,clock1, out);
	myModule2 notGate(out, out2);

endmodule

module myModule(A, B, C);
	input wire A, B;
	output wire C;
	assign C = A&B; 
endmodule

module myModule2(C, D);
    input wire C;
    output wire D;
    assign D = !C;
endmodule


