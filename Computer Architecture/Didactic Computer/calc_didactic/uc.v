`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    20:14:45 11/26/2011
// Design Name:
// Module Name:    uc
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module uc(
        clk,
        rst,
        ri,
        ind,
        regs_addr,
        regs_oe,
        regs_we,
        alu_oe,
        alu_carry,
        alu_opcode,
        ram_oe,
        ram_we,
        io_oe,
        io_we,
        cp_oe,
        cp_we,
        ind_sel,
        ind_oe,
        ind_we,
        am_oe,
        am_we,
        aie_oe,
        aie_we,
        t1_oe,
        t1_we,
        t2_oe,
        t2_we,
        ri_oe,
        ri_we,
        disp_state
    );

parameter word_width =          16;
parameter state_width =         16;

`define ADC                     0
`define SBB1                    1
`define SBB2                    2
`define NOT                     3
`define AND                     4
`define OR                      5
`define XOR                     6
`define SHL                     7
`define SHR                     8
`define SAR                     9

`define RA                      0
`define RB                      1
`define RC                      2
`define IS                      3
`define XA                      4
`define XB                      5
`define BA                      6
`define BB                      7

input                           clk;
input                           rst;
input [word_width-1 : 0]        ri;
input [word_width-1 : 0]        ind;
output reg                      alu_oe;
output reg                      alu_carry;
output reg[3 : 0]               alu_opcode;
output reg                      ram_oe;
output reg                      ram_we;
output reg                      io_oe;
output reg                      io_we;
output reg[2 : 0]               regs_addr;
output reg                      regs_oe;
output reg                      regs_we;
output reg                      cp_oe;
output reg                      cp_we;
output reg                      ind_sel;        // controls IND register input (0 = bus, 1 = alu flags)
output reg                      ind_oe;
output reg                      ind_we;
output reg                      am_oe;
output reg                      am_we;
output reg                      aie_oe;
output reg                      aie_we;
output reg                      t1_oe;
output reg                      t1_we;
output reg                      t2_oe;
output reg                      t2_we;
output reg                      ri_oe;          // controls RI register output which generates the offset for Jcond instructions
output reg                      ri_we;
output[state_width-1 : 0]       disp_state;

wire [0:6]                      cop;
wire                            d;
wire [0:1]                      mod;
wire [0:2]                      rg;
wire [0:2]                      rm;


assign cop  = {ri[0], ri[1], ri[2], ri[3], ri[4], ri[5], ri[6]};
assign d    = {ri[7]};
assign mod  = {ri[8], ri[9]};
assign rg   = {ri[10], ri[11], ri[12]};
assign rm   = {ri[13], ri[14], ri[15]};


`define reset                   'h00            // reset state
`define fetch                   'h05            // load instruction to instruction register
`define decode                  'h10  				// decode state
`define addr_sum                'h15            // computes address of the form [By+Xz] with y,z in {A, B}
`define addr_reg                'h20            // computes address of the form [yz] with y in {X, B} and z in {A, B}
`define addr_sum1					  'h25				// like addr_sum but used for mod == 01
`define inc_cp1					  'h30	 		   // increment program counter but stores cp depending on decoded_d	
`define load_deplas				  'h35				// load deplas for MOD == 10
`define load_deplas1				  'h40				// load [Depls]
`define load_deplas_addr		  'h45				// used for loading [[Depls]]
`define add_deplas				  'h50				// adds depls for MOD == 10
`define decrem						  'h55				// decrements XA before computing the effective address
`define load_src_reg            'h60            // load source operand from register
`define load_src_mem            'h65            // load source operand from memory
`define load_dst_reg            'h70   			// load destination operand from register
`define load_imd					  'h75				// load immediate operand
`define increm						  'h80				// increment index register after calculating effective address for MOD == 01
`define indicatori				  'h85				// used for storing what is in memory in ind register for POPF
`define indicatori1				  'h90				// stores indicators in memory for PUSHF
`define load_dst_mem            'h95            // load destination operand from memory
`define load_is					  'h105				// load from memory from IS address for POP instruction
`define exec_1op                'h110           // execute 1 operand instructions
`define exec_2op                'h115           // execute 2 operand instructions
`define MOV							  'h120				// execute MOV
`define exec_p						  'h125				// execute PUSH & POP
`define inc_is						  'h130				// increment stack indicator
`define exec_jmp					  'h140				// execute JMP	
`define exec_jmp11				  'h145				// execute JMP for MOD == 11	
`define dec_is						  'h155				// decrement stack indicator
`define exec_jc					  'h160				// execute JMP & CALL
`define pf							  'h165				// execute PUSHF, POPF & RET
`define store_reg               'h170           // store result to register
`define store_mem               'h175			   // store result to memory	
`define store_reg1				  'h180			   // same as store_reg, but stores what is in T2  	
`define store_mem1				  'h185			   // same as store_mem, but stores what is in T2
`define inc_cp                  'h190     	   // increment program counter
`define JCond						  'h200				// execute JCond
`define deplasare					  'h210				// computes destination for JCond
`define call						  'h220				// states needed for executing CALL
`define ret							  'h230				// states needed for executing RET



reg [state_width-1 : 0] state = `reset, state_next;
reg [state_width-1 : 0] decoded_src, decoded_src_next;      // stores decoded source operand load state
reg [state_width-1 : 0] decoded_dst, decoded_dst_next;      // stores decoded destination operand load state
reg [state_width-1 : 0] decoded_exec, decoded_exec_next;    // stores decoded execute state
reg [state_width-1 : 0] decoded_store, decoded_store_next;  // stores decoded store state
reg decoded_d, decoded_d_next;                              // stores decoded direction bit

// FSM - sequential part
always @(posedge clk) begin
    state <= `reset;

    if(!rst) begin
        state <= state_next;

        if(state == `decode) begin
            decoded_src <= decoded_src_next;
            decoded_dst <= decoded_dst_next;
            decoded_exec <= decoded_exec_next;
            decoded_store <= decoded_store_next;
            decoded_d <= decoded_d_next;
        end
    end
end

// FSM - combinational part
always @(*) begin
    state_next = `reset;
    decoded_src_next = `reset;
    decoded_dst_next = `reset;
    decoded_exec_next = `reset;
    decoded_store_next = `reset;
    decoded_d_next = 0;
    alu_oe = 0;
    alu_carry = 0;
    alu_opcode = 0;
    ram_oe = 0;
    ram_we = 0;
    io_oe = 0;
    io_we = 0;
    regs_addr = 0;
    regs_oe = 0;
    regs_we = 0;
    cp_oe = 0;
    cp_we = 0;
    ind_sel = 0;
    ind_oe = 0;
    ind_we = 0;
    am_oe = 0;
    am_we = 0;
    aie_oe = 0;
    aie_we = 0;
    t1_oe = 0;
    t1_we = 0;
    t2_oe = 0;
    t2_we = 0;
    ri_oe = 0;
    ri_we = 0;

    case(state)
        `reset: begin
            state_next = `fetch;
        end

        `fetch: begin
            cp_oe = 1;
            am_we = 1;

            state_next = `fetch + 1;
        end

        `fetch + 'd1: begin
            am_oe = 1;

            state_next = `fetch + 2;
        end

        `fetch + 'd2: begin
            ram_oe = 1;
            ri_we = 1;

            state_next = `decode;
        end

        `decode: begin
            // decode location of operands and operation
            if(cop[0:2] == 4'b000) begin  
						if(cop[3] == 1) begin		// one operand instructions
							decoded_d_next      = 0;
							decoded_dst_next    = mod == 2'b11 ? `load_dst_reg : `load_dst_mem;
							decoded_src_next    = decoded_dst_next;
							decoded_exec_next   = `exec_1op;
							decoded_store_next  = mod == 2'b11 ? `store_reg : `store_mem;
						end
						else if (cop[3] == 0) begin	//control transfer instructions
									if(cop[4] == 0 && cop[5] == 0) begin			//MOV
										decoded_d_next      = d;
										decoded_dst_next    = (mod == 2'b11) || (d == 1) ? `load_dst_reg : `load_dst_mem;
										decoded_src_next    = (mod == 2'b11) || (d == 0) ? `load_src_reg : `load_src_mem;
										decoded_exec_next   =  `MOV;					
										decoded_store_next  = ((mod == 2'b11) || (d == 1) ? `store_reg : `store_mem);
									end
									if(cop[4] == 0 && cop[5] == 1) begin				//PUSH & POP
										decoded_d_next      = 0;
										decoded_dst_next    = mod == 2'b11 ? `load_dst_reg : `load_dst_mem;
										decoded_src_next    = !cop[6] ? decoded_dst_next: `load_is ;
										decoded_exec_next   = `exec_p;
										decoded_store_next  = !cop[6] ? `store_mem : (mod == 2'b11 ? `store_reg1 : `store_mem1);
									end
									if(cop[4] == 1 && cop[5] == 0) begin			//JMP & CALL
										decoded_d_next      = 0;
										decoded_src_next 	  = `exec_jc;
									end
									
						end
				end
            else if(cop[0:2] == 3'b010) begin       // two operand instructions
                decoded_d_next      = d;
                decoded_dst_next    = (mod == 2'b11) || (d == 1) ? `load_dst_reg : `load_dst_mem;
                decoded_src_next    = (mod == 2'b11) || (d == 0) ? `load_src_reg : `load_src_mem;
                decoded_exec_next   = `exec_2op;
                decoded_store_next  = !cop[3] ? `inc_cp : ((mod == 2'b11) || (d == 1) ? `store_reg : `store_mem);
					end
					else if (cop[0:2] == 3'b001) begin  //Mov immediate
								decoded_d_next      = 0;
								decoded_dst_next    = mod == 2'b11 ? `load_dst_reg : `load_dst_mem;
								decoded_src_next    = `load_imd;
								decoded_exec_next   = `MOV;					
								decoded_store_next  = mod == 2'b11 ? `store_reg : `store_mem;
					end
					else if (cop[0:2] == 3'b011) begin	//Add immediate
								decoded_d_next      = 0;
								decoded_dst_next    = mod == 2'b11 ? `load_dst_reg : `load_dst_mem;
								decoded_src_next    = `load_imd;
								decoded_exec_next   = `exec_2op;					
								decoded_store_next  = !cop[3] ? `inc_cp : (mod == 2'b11 ? `store_reg : `store_mem);
							end
					else if (cop[0:2] == 3'b100) begin 	//PUSHF, POPF, RET
								decoded_d_next = 0;
								decoded_src_next = `pf;
							end
				

				if(cop[0:3] == 4'b1001) begin
					state_next = `JCond;					// JCOND - no effective address needed
				end
				else begin
					case(mod)									//next state depends on MOD
						2'b00: begin
							state_next = rm[0] ? `addr_reg : `addr_sum;
						end
						2'b11: begin
							state_next = decoded_src_next;
						end
						2'b10: begin			
							state_next = rm[0] ? `addr_reg : `addr_sum;
						end
						2'b01: begin
							if(rm[0] == 0) begin
								state_next = `addr_sum1;
							end
							else if  (rm[0] == 1 && rm[1] == 0) begin
								state_next = `decrem;
							end
								  else begin 
											state_next = `load_deplas1;
										end
						end
					endcase
				end
			end
		  
			
			`exec_jc: begin	//execute JMP & CALL
				case(cop[4:6])
					3'b100: begin
						cp_oe = 1;
						t2_we = 1;
						
						state_next = `call;
					end
					3'b101: begin
						state_next = mod == 2'b11 ? `exec_jmp11 : `exec_jmp;
					end
				endcase
			end
			
			`call: begin  //call and all the states with the same name used to execute CALL instruction
				t2_oe = 1;
				alu_opcode = `ADC;
				alu_carry = 1;
				alu_oe = 1;
				cp_we = 1;
				
				state_next = `call + 1;
			end
			
			`call + 'd1: begin
				regs_addr = `IS;
				regs_oe = 1;
				t2_we = 1;
				
				state_next = `call + 2;
			end
			
			`call + 'd2: begin
				t2_oe = 1;
				alu_carry = 1;
				alu_opcode = `SBB2;
				alu_oe = 1;
				regs_addr = `IS;
				regs_we = 1;
				
				state_next = `call + 3;
			end
			
			`call + 'd3: begin
				regs_addr =  `IS;
				regs_oe = 1;
				am_we = 1;
				
				state_next = `call + 4;
			end
			
			`call + 'd4: begin
				cp_oe = 1;
				am_oe = 1;
				ram_we = 1;
				
				state_next = `call + 5;
			end
			
			`call + 'd5: begin
				state_next = (mod == 2'b11 ? `exec_jmp11 : `exec_jmp);
			end
			

		  `pf: begin 			//execute PUSHF, POPF & RET
				case(cop[4:6])
					3'b010: begin
						regs_addr = `IS;		//PUSHF
						regs_oe = 1;
						t2_we = 1;
						
						state_next = `dec_is;
					end
					3'b011: begin				//POPF
						regs_addr = `IS;
						regs_oe = 1;
						am_we = 1;
						
						state_next = `indicatori;
					end
					3'b100: begin				//RET
						regs_addr = `IS;
						regs_oe = 1;
						am_we = 1;
						
						state_next = `ret;
					end
				endcase
			end
			
			`ret: begin				//ret and all the states with the same name used to execute RET instruction
				am_oe = 1;
				
				state_next = `ret + 1;
			end
			
			`ret + 'd1: begin
				ram_oe = 1;
				cp_we = 1;
				
				state_next = `inc_is;
			end
			

			`indicatori: begin				//stores what is in memory in ind register for POPF
				am_oe = 1;
				
				state_next = `indicatori + 1;
			end
			
			`indicatori + 'd1: begin
				ram_oe = 1;
				ind_we = 1;
				ind_sel = 0;
				
				state_next = `inc_is;
			end
			
			`indicatori1: begin 				//stores indicators in memory for PUSHF
				ind_oe = 1;
				am_oe = 1;
				ram_we = 1;
				
				state_next = `store_mem + 1;
			end
		  
		         
        `addr_sum: begin
            regs_addr = rm[1] ? `BB : `BA;
            regs_oe = 1;
            t1_we = 1;
				
				state_next = `addr_sum + 1;
        end

        `addr_sum + 'd1: begin
            regs_addr = rm[2] ? `XB : `XA;
            regs_oe = 1;
            t2_we = 1;
				
				state_next = `addr_sum + 2;
        end

        `addr_sum + 'd2: begin
            t1_oe = 1;
            t2_oe = 1;
            alu_carry = 0;
            alu_opcode = `ADC;
            alu_oe = 1;
            if (decoded_d)
                t2_we = 1;
            else
                t1_we = 1;
				if (mod == 2'b10)
					state_next = `inc_cp1; 
				else
					state_next = decoded_src;
        end
		  
		  `addr_sum1: begin         //different addr_sum for MOD == 01
				case(rm[0:2])
					3'b000:begin
						regs_addr = `BA;
					end
					3'b001:begin
						regs_addr = `BA;
					end
					3'b010:begin
						regs_addr = `BB;
					end
					3'b011:begin
						regs_addr = `BB;
					end
					3'b100:begin
						regs_addr = `BA;
					end
					3'b101:begin
						regs_addr = `BB;
					end
				endcase
				regs_oe = 1;
				t1_we = 1;
				
				state_next = `addr_sum1 + 1;
		  end
		  
		  `addr_sum1 + 'd1: begin
				case(rm[0:2])
					3'b000:begin
						regs_addr = `XA;
					end
					3'b001:begin
						regs_addr = `XA;
					end
					3'b010:begin
						regs_addr = `XA;
					end
					3'b011:begin
						regs_addr = `XB;
					end
					3'b100:begin
						regs_addr = `XA;
					end
					3'b101:begin
						regs_addr = `XA;
					end
				endcase
				regs_oe = 1;
				t2_we = 1;
				
				state_next = `addr_sum1 + 2;
		  end
		  
		  `addr_sum1 + 'd2: begin
				t1_oe = 1;
				t2_oe = 1;
				alu_carry = 0;
				alu_opcode = `ADC;
				alu_oe = 1;
				t1_we = 1;
				if (rm[0])
					state_next = `increm + 'd1;
				else
					state_next = `increm;
		  end
		  
		  `increm: begin				//increment index register after calculating effective address for MOD == 01
				t2_oe = 1;
				alu_carry = 1;
				alu_opcode = `ADC;
				alu_oe = 1;
				regs_addr = rm[2] ? `XB : `XA;
				regs_we = 1;
				
				state_next = `increm + 1;
		  end
		  
		  `increm + 'd1: begin
				t1_oe = 1;
				alu_carry = 0;
				alu_opcode = `ADC;
				alu_oe = 1;
				if (decoded_d)
					t2_we = 1;
				else
					t1_we = 1;
					
				state_next = decoded_src;
		  end
        
		  
		  `load_deplas1: begin					//load_deplas1 and all the states with the same name used to load displacement from memory; [Depls] MOD == 01
				cp_oe = 1;
				t1_we = 1;
				
				state_next = `load_deplas1 + 1;
		  end
		  
		  `load_deplas1 + 'd1: begin
				t1_oe = 1;
				alu_carry = 1;
				alu_opcode = `ADC;
				alu_oe = 1;
				cp_we = 1;
				
				state_next = `load_deplas1 + 2;
		  end
		  
		  `load_deplas1 + 'd2: begin
				cp_oe = 1;
				am_we = 1;
				state_next = `load_deplas1 + 3;
		  end
		  
		  `load_deplas1 + 'd3: begin
				am_oe = 1;
				
				state_next = `load_deplas1 + 4;
		  end
		  
		  `load_deplas1 + 'd4: begin
				ram_oe = 1;
				if(decoded_d)
					t2_we = 1;
				else
					t1_we = 1;
				if (rm[0:2] == 3'b110)
					state_next = decoded_src;
				else
					state_next = `load_deplas_addr;
			end
			
			
			`load_deplas_addr: begin	//load_deplas_addr and all the states with the same name used to load; [[Depls]] MOD == 01
				if(decoded_d)
					t2_oe = 1;
				else
					t1_oe = 1;
				alu_opcode = `OR;
				alu_oe = 1;
				am_we = 1;
				
				state_next = `load_deplas_addr + 1;
			end
			
			`load_deplas_addr + 'd1: begin
				am_oe = 1;
				
				state_next = `load_deplas_addr  + 2;
			end
			
			`load_deplas_addr + 'd2: begin
				ram_oe = 1;
				if(decoded_d)
					t2_we = 1;
				else
					t1_we = 1;
					
				state_next = decoded_src;
			end
		  
		  `decrem: begin				//decrement XA register before calculation effective address for MOD == 01
				regs_addr = `XA;
				regs_oe = 1;
				t1_we = 1;
				
				state_next = `decrem + 1;
		  end
		  
		  `decrem + 'd1: begin
				t1_oe = 1;
				alu_carry = 1;
				alu_opcode = `SBB1;
				alu_oe = 1;
				regs_addr = `XA;
				regs_we = 1;
				
				state_next = `addr_sum1;
		  end
	
		`addr_reg: begin
            regs_addr = rm;
            regs_oe = 1;
            if(decoded_d)
                t2_we = 1;
            else
                t1_we = 1;
				if (mod == 2'b10)
					state_next = `inc_cp1;
				else
					state_next = decoded_src;
        end
			
		  
		  `inc_cp1: begin //different state for increment program counter; stores cp address depending on decoded_d
				cp_oe = 1;
				if(decoded_d)
					t1_we = 1;
				else
					t2_we = 1;
				state_next = `inc_cp1 + 1;
		  end
		  
		  `inc_cp1 + 'd1: begin
				if(decoded_d)
					t1_oe = 1;
				else
					t2_oe = 1;
				alu_carry = 1;
				alu_opcode = `ADC;
				alu_oe = 1;
				cp_we = 1;
				
				state_next = `load_deplas;
		  end
		  
		  
		  `load_deplas:  begin 			//load_deplas and all the states with the same name used to load displacement for MOD == 10
				cp_oe = 1;
				am_we = 1;
				
				state_next = `load_deplas + 1;
		  end
		  
		  `load_deplas + 'd1: begin
				am_oe = 1;
				
				state_next = `load_deplas + 2;
		  end
		  
		  `load_deplas + 'd2: begin
				ram_oe = 1;
				if(decoded_d)
					t1_we = 1;
				else
					t2_we = 1;
					
				state_next = `add_deplas;
		  end
		  
		  
		  `add_deplas: begin		//used to add displacement for MOD == 10
				t1_oe = 1;
				t2_oe = 1;
				alu_carry = 0;
				alu_opcode = `ADC;
				alu_oe = 1;
				if (decoded_d)
					t2_we = 1;
				else
					t1_we = 1;
					
				state_next  = decoded_src;
			end
		  
		  
		  
		  `load_src_reg: begin
            regs_addr = decoded_d ? rm : rg;
            regs_oe = 1;
            t2_we = 1;

            state_next = decoded_dst;
        end
        
        `load_src_mem: begin
            t1_oe = 0;
            t2_oe = 1;
            alu_opcode = `OR;
            alu_oe = 1;
            am_we = 1;

            state_next = `load_src_mem + 1;
        end

        `load_src_mem + 'd1: begin
            am_oe = 1;

            state_next = `load_src_mem + 2;
        end

        `load_src_mem + 'd2: begin
            ram_oe = 1;
            t2_we = 1;

            state_next = decoded_dst;
        end

        `load_dst_reg: begin
            regs_addr = decoded_d ? rg : rm;
            regs_oe = 1;
            t1_we = 1;

            state_next = decoded_exec;
        end
        
        `load_dst_mem: begin
            t1_oe = 1;
            t2_oe = 0;
            alu_opcode = `OR;
            alu_oe = 1;
            am_we = 1;

            state_next = `load_dst_mem + 1;
        end

        `load_dst_mem + 'd1: begin
            am_oe = 1;

            state_next = `load_dst_mem + 2;
        end

        `load_dst_mem + 'd2: begin
            ram_oe = 1;
            t1_we = 1;

            state_next = decoded_exec;
        end
		  
		  
		  `load_is: begin 		//load_is and all the states with the same name used to load what is in memory at the address existing in IS register
				regs_addr = `IS;
				regs_oe = 1;
				t2_we = 1;
				
				state_next = `load_is + 1;
		  end

			`load_is + 'd1: begin
				t2_oe = 1;
            t1_oe = 0;
            alu_opcode = `OR;
            alu_oe = 1;
            am_we = 1;
				
				state_next = `load_is + 2;
		  end
		  
		  `load_is + 'd2: begin
				am_oe = 1;
				
				state_next = `load_is + 3;
		  end
		  
		  `load_is + 'd3: begin
				ram_oe = 1;
				t2_we = 1;
				
				state_next = decoded_exec;
			end
		 
	
        `exec_1op: begin
            t1_oe = 1;
            case(cop[4:6])
                3'b000: begin                               // INC
                    alu_carry = 1;
                    alu_opcode = `ADC;
                end
                3'b001: begin                               // DEC
                    alu_carry = 1;
                    alu_opcode = `SBB1;
                end
                3'b010: begin                               // NEG
                    alu_carry = 0;
                    alu_opcode = `SBB2;
                end
                3'b011: begin                               // NOT
                    alu_opcode = `NOT;
                end
                3'b100: alu_opcode = `SHL;                  // SHL/SAL
                3'b101: alu_opcode = `SHR;                  // SHR
                3'b110: alu_opcode = `SAR;                  // SAR
            endcase
            alu_oe = 1;
            t1_we = 1;
            ind_sel = 1;
            ind_we = 1;

            state_next = decoded_store;
        end
        
        `exec_2op: begin
            t1_oe = 1;
            t2_oe = 1;
            case(cop[4:6])
                3'b000: begin                               // ADD
                    alu_carry = 0;
                    alu_opcode = `ADC;
                end
                3'b001: begin                               // ADC
                    alu_carry = ind[0];
                    alu_opcode = `ADC;
                end
                3'b010: begin                               // SUB/CMP
                    alu_carry = 0;
                    alu_opcode = `SBB1;
                end
                3'b011: begin                               // SBB
                    alu_carry = ind[0];
                    alu_opcode = `SBB1;
                end
                3'b100: alu_opcode = `AND;                  // AND/TEST
                3'b101: alu_opcode = `OR;                   // OR
                3'b110: alu_opcode = `XOR;                  // XOR
            endcase
            alu_oe = 1;
            t1_we = 1;
            ind_sel = 1;
            ind_we = 1;

            state_next = decoded_store;
        end
		  
		  `load_imd: begin 		//load_imd and all the states with the same name used to load an immediate operator
				cp_oe = 1;
				t2_we = 1;
				
				state_next = `load_imd + 1;
		  end
		  
		  `load_imd + 'd1: begin
				t2_oe = 1;
				alu_carry = 1;
				alu_opcode = `ADC;
				alu_oe = 1;
				cp_we = 1;
				
				state_next = `load_imd + 2;
		  end
		  
		  `load_imd + 'd2: begin
				cp_oe = 1;
				am_we = 1;
				
				state_next = `load_imd + 3;
		  end
		  
		  `load_imd + 'd3: begin
				am_oe = 1;
				
				state_next = `load_imd + 4;
		  end
		  
		  `load_imd + 'd4: begin
				ram_oe = 1;
				t2_we = 1;
				
				state_next = decoded_dst;
		  end
		  
		  `MOV : begin					//execute MOV instruction
				t2_oe = 1;
				t1_oe = 0;
				alu_opcode = `OR;
				alu_oe = 1;
				t1_we = 1;
				
				state_next = decoded_store;
		  end
				  
		 `exec_p : begin				//execute PUSH and POP instructions
				case(cop[4:6]) 
					3'b010: begin
						regs_addr = `IS;
						regs_oe = 1;
						t2_we = 1;
						
						state_next = `dec_is;
					end
					3'b011: begin
						t1_oe = 1;
						t2_oe = 0;
						alu_opcode = `OR;
						alu_oe = 1;
						am_we = 1;
						
						state_next = `inc_is;
					end
				endcase
		  end
		  
		   `inc_is: begin						//increment stack indicator
				regs_addr = `IS;
				regs_oe = 1;
				t1_we = 1;
				
				state_next = `inc_is + 1;
			end
		  
		  `inc_is + 'd1: begin
				t1_oe = 1;
				t2_oe = 0;
				alu_carry = 1;
				alu_opcode = `ADC;
				alu_oe = 1;
				regs_addr = `IS;
				regs_we = 1;
				case(cop[0:6])
					7'b1000011: begin
						state_next = `inc_cp;
					end
					7'b1000100: begin
						state_next = `fetch;
					end
					default: begin
					state_next = decoded_store;
					end
				endcase
		  end
		  
		  `exec_jmp: begin		//execute JMP
				t1_oe = 1;
            cp_we = 1;
            alu_oe = 1;
            alu_carry = 0;
            alu_opcode = `ADC;
				
				state_next = `fetch;
		  end
		  
		  `exec_jmp11: begin       //execute JMP for MOD == 11
				regs_addr = rm;
				regs_oe = 1;
				t1_we = 1;
				
				state_next = `exec_jmp;
		  end
		 		  
		  `dec_is: begin			//decrement stack indicator
				t2_oe = 1;
				t1_oe = 0;
				alu_carry = 1;
				alu_opcode = `SBB2;
				alu_oe = 1;
				regs_addr = `IS;
				regs_we = 1;
				
				state_next = `dec_is + 1;
		  end
		  
		  `dec_is + 'd1: begin
				regs_addr = `IS;
				regs_oe = 1;
				am_we = 1;
				if (cop[0:6] == 7'b1000010 )
					state_next = `indicatori1;
				else
					state_next = decoded_store;
		  end
		  
		  `JCond: begin		//execute JCond instructions
				case(ri[7:4])
		  
					4'b0000: begin				//JBE	
							if ((ind[0] == 0 && ind[2] == 1) || (ind[0] == 1 && ind[2] == 0) || (ind[0] == 1 && ind[2] == 1)) 
								state_next = `deplasare;
							else 
								state_next = `inc_cp;
					end
				
					4'b1000: begin			//JB/JC
						if(ind[0] == 1)
							state_next = `deplasare;
						else 
							state_next = `inc_cp;
					end
			
					4'b0100: begin				//JLE
						if((ind[3] == 0 && ind[1] == 0 && ind[2] == 1) || (ind[3] == 0 && ind[1] == 1 && ind[2] == 0) || (ind[3] == 0 && ind[1] == 1 && ind[2] == 1) || (ind[3] == 1 && ind[1] == 0 && ind[2] == 0) || (ind[3] == 1 && ind[1] == 0 && ind[2] == 1) || (ind[3] == 1 && ind[1] == 1 && ind[2] == 1))
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b1100:begin			//JL
						if((ind[3] == 1 && ind[1] == 0) || (ind[3] == 0 && ind[1] == 1))
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b0010: begin			//JE/JZ
						if(ind[2] == 1)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b1010: begin		//JO
						if(ind[1] == 1)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b0110: begin 	//JS
						if(ind[3] == 1)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b1110: begin //JPE
						if(ind[4] == 1)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b0001: begin 	//JA	
						if(ind[0] == 0 && ind[2] == 0)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b1001: begin 	//JAE/JNC
						if(ind[0] == 0)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b0101:begin	//JG
						if ((ind[3] == 0 && ind[1] == 0 && ind[2] == 0) || (ind[3] == 1 && ind[1] == 1 && ind[2] == 0))
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b1101: begin  //JGE
						if((ind[3] == 0 && ind[1] == 0) || (ind[3] == 1 && ind[1] == 1))
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b0011: begin		//JNE/JNZ
						if(ind[2] == 0)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b1011: begin		//JNO
						if(ind[1] == 0)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b0111: begin		//JNS
						if(ind[3] == 0)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
			
					4'b1111: begin		//JPO
						if(ind[4] == 0)
							state_next = `deplasare;
						else
							state_next = `inc_cp;
					end
				endcase
			end
		  
		  `deplasare: begin  //deplasare and all the states with the same name used for calculating destination address for Jcond instructions
				cp_oe = 1;
				t1_we = 1;
				
				state_next = `deplasare + 1;
		  end
		  
		  `deplasare + 'd1: begin
				ri_oe = 1;
				t2_we = 1;
				
				state_next = `deplasare + 2;
		  end
		  
		  `deplasare + 'd2: begin
				t1_oe = 1;
				t2_oe = 1;
				cp_we = 1;
				alu_carry = 0;
				alu_opcode = `ADC;
				alu_oe = 1;
				
				state_next = `fetch;
		  end
		  
		 
		  
        `store_reg: begin
            t1_oe = 1;
            t2_oe = 0;
            alu_opcode = `OR;
            alu_oe = 1;
            regs_addr = decoded_d ? rg : rm;
            regs_we = 1;

            state_next = `inc_cp;
        end
        
        `store_mem: begin
            t1_oe = 1;
            t2_oe = 0;
            alu_opcode = `OR;
            alu_oe = 1;
            am_oe = 1;
            ram_we = 1;

            state_next = `store_mem + 1;
        end

        `store_mem + 'd1: begin
            state_next = `inc_cp;
        end
		  
		  
		   `store_reg1: begin			//used to store in register what is in T2
            t2_oe = 1;
            t1_oe = 0;
            alu_opcode = `OR;
            alu_oe = 1;
            regs_addr = decoded_d ? rg : rm;
            regs_we = 1;

            state_next = `inc_cp;
        end
        
        `store_mem1: begin				//used to store in memory what is in T2
            t2_oe = 1;
            t1_oe = 0;
            alu_opcode = `OR;
            alu_oe = 1;
            am_oe = 1;
            ram_we = 1;

            state_next = `store_mem1 + 1;
        end

        `store_mem1 + 'd1: begin
            state_next = `inc_cp;
        end

        `inc_cp: begin
            cp_oe = 1;
            t1_we = 1;

            state_next = `inc_cp + 1;
        end

        `inc_cp + 'd1: begin
            t1_oe = 1;
            cp_we = 1;
            alu_oe = 1;
            alu_carry = 1;
            alu_opcode = `ADC;
				
            state_next = `fetch;
        end

        default: ;
    endcase
end

assign disp_state = state;

endmodule
