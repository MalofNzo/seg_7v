/*

组名：知人知面不知芯

成员名：马远超

创建时间:2018-2-26

模块名：SCAN_SEG

输入：clk,rst,

输出：DIG,Y

模块功能：

*/

`timescale 1 ns / 1 ps

module scan_seg ( rst ,clk ,DIG ,Y );

input rst ;
wire rst ;
input clk ;
wire clk ;

input [31:0]syscallout
wire [31:0]syscallout
input [9:0]memshow
wire [9:0]menshow
input [5:0]modelch
wire [5:0]modelch


output [7:0] DIG ; // DIG选输出哪一个数码管
wire [7:0] DIG ;
output [7:0] Y ; // Y 选择数码管输出哪一个符号
wire [7:0] Y ;

reg clkout ;
reg [31:0]cnt;  
reg [2:0]scan_cnt ;     

parameter  period= 100000;

assign Y = {1'b1,(~Y_r[6:0])};
assign DIG =~DIG_r;
reg [6:0] Y_r;
reg [7:0] DIG_r ;

always @( posedge clk or negedge rst)      //分频50Hz
    begin 
    if (!rst)
        cnt <= 0 ;
    else  begin  
            cnt<= cnt+1;
        if (cnt    == (period >> 1) - 1)               
                clkout <= #1 1'b1;
        else if (cnt == period - 1)                    
            begin 
                clkout <= #1 1'b0;
                 cnt <= #1 'b0;      
            end
         
        end
    end

always @(posedge clkout or negedge rst)          
    begin 
      if (!rst)
        scan_cnt <= 0 ;
    else  begin
        scan_cnt <= scan_cnt + 1;    
        if(scan_cnt==3'd7)  scan_cnt <= 0;
        end 
    end
    
always @( scan_cnt)         //数码管选择
    begin 
    case ( scan_cnt )    
        3'b000 : DIG_r <= 8'b0000_0001;    
        3'b001 : DIG_r <= 8'b0000_0010;    
        3'b010 : DIG_r <= 8'b0000_0100;    
        3'b011 : DIG_r <= 8'b0000_1000;    
        3'b100 : DIG_r <= 8'b0001_0000;    
        3'b101 : DIG_r <= 8'b0010_0000;    
        3'b110 : DIG_r <= 8'b0100_0000;     
        3'b111 : DIG_r <= 8'b1000_0000;    
        default :DIG_r <= 8'b0000_0000;    
    endcase
    end

/*
always @ ()
    
*/

always @ (scan_cnt ) //译码
    begin 
    case (scan_cnt)
        0: Y_r = 7'b0111111; // 0
        1: Y_r = 7'b0000110; // 1
        2: Y_r = 7'b1011011; // 2
        3: Y_r = 7'b1001111; // 3
        4: Y_r = 7'b1100110; // 4
        5: Y_r = 7'b1101101; // 5
        6: Y_r = 7'b1111101; // 6
        7: Y_r = 7'b0100111; // 7
        8: Y_r = 7'b1111111; // 8
        9: Y_r = 7'b1100111; // 9
        10: Y_r = 7'b1110111; // A
        11: Y_r = 7'b1111100; // b
        12: Y_r = 7'b0111001; // c
        13: Y_r = 7'b1011110; // d
        14: Y_r = 7'b1111001; // E
        15: Y_r = 7'b1110001; // F
        default: Y_r = 7'b0000000;
    endcase
    end    
    
endmodule