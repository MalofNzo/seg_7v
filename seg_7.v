/*

组名：知人知面不知芯

成员名：马远超

创建时间:2018-2-26

模块名：SCAN_SEG

输入：

输出：

模块功能：

*/

`timescale 1 ns / 1 ps

module seg_7(input clk,input rst_n,input [31:0]data_in,output reg [2:0]sel,output reg[7:0]seg);

parameter CNT_1K = 15'd24999;

reg [3:0]data_tmp;
reg [14:0]cnt_1k;
reg flag_1k;

always @(posedge clk or negedge rst_n)
if(!rst_n)
	cnt_1k <= 15'd0;
else if(cnt_1k == CNT_1K)
	cnt_1k <= 15'd0;
	