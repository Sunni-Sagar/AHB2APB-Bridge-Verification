#SIMULATOR = VCS
SIMULATOR = Questa

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

RTL= ../rtl/* +define+WRAPPING_INCR
work= work #library name
SVTB1= ../env/top.sv
INC = +incdir+../env +incdir+../test +incdir+../ahb_top +incdir+../apb_top 
SVTB2 = ../test/bridge_test_pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit cov6;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit cov7;run -all; exit"
help:
	@echo ===========================================================================================================
	@echo "! USAGE   	--  make target										!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.       				!"
	@echo "! sv_cmp    	=>  Create library and compile the code.                   				!"
	@echo "! run_sinlge_seq	=>  clean, compile & run the simulation for signle_seq_test in batch mode.		!"
	@echo "! run_incr       =>  clean, compile & run the simulation for incr_test in batch mode.       		!"	
	@echo "! run_wrap4       =>  clean, compile & run the simulation for incr_wrap4 in batch mode.       		!"
	@echo "! run_wrap8       =>  clean, compile & run the simulation for incr_wrap8 in batch mode.                  !"	
	@echo "! run_wrap16       =>  clean, compile & run the simulation for incr_wrap16 in batch mode.                !"
	@echo "! view_wave1       =>  view wave form of single seq					                !"
	@echo "! view_wave2       =>  view wave form of incr                                                            !"
	@echo "! view_wave3       =>  view wave form of wrap4       	                                                !"
	@echo "! view_wave4       =>  view wave form of wrap8                                                           !"
	@echo "! view_wave5       =>  view wave form of wrap16                                                          !"
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.	    				!"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.		!"
	@echo "! cov        =>  To open merged coverage report in html format.						!"
	@echo ===========================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_single_seq : run_single_seq_$(SIMULATOR)
run_incr : run_incr_$(SIMULATOR)
run_wrap4 : run_wrap4_$(SIMULATOR)
run_wrap8 : run_wrap8_$(SIMULATOR)
run_wrap16 : run_wrap16_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
view_wave5 : view_wave5_$(SIMULATOR)
cov        : cov_$(SIMULATOR)
regress    : regress_$(SIMULATOR)
report     : report_$(SIMULATOR)
# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) 	
	
run_single_seq_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=single_vseq
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html cov1	

run_incr_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=incr_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html cov2

run_wrap4_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=wrap4_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html cov3


run_wrap8_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=wrap8_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html cov4

run_wrap16_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=wrap16_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html cov5
run_wrap16_cov_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave_file6.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=wrap16_cov_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html cov6

run_wrap16_cov1_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave_file7.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=wrap16_cov1_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html cov7

report_Questa:
	vcover merge cov cov1 cov2 cov3 cov4 cov5 cov6 cov7
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html cov

regress_Questa: clean_Questa run_single_seq_Questa run_incr_Questa run_wrap4_Questa run_wrap8_Questa run_wrap16_Questa run_wrap16_cov_Questa run_wrap16_cov1_Questa report_Questa cov_Quest

cov_Questa:
	firefox covhtmlreport/index.html&

view_wave1_Questa:
	vsim -view wave_file1.wlf

view_wave2_Questa:
	vsim -view wave_file2.wlf

view_wave3_Questa:
	vsim -view wave_file3.wlf

view_wave4_Questa:
	vsim -view wave_file4.wlf

view_wave5_Questa:
	vsim -view wave_file5.wlf


clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* cov* sim* *.wlf modelsim.ini work csrc  ucli.key  vc_hdrs.h  verdi_config_file  vsim_stacktrace.vstf
	clear
# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1) 
	      
run_single_seq_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=single_vseq

run_incr_VCS:     clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=incr_test

run_wrap4_VCS:     clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=wrap4_test

run_wrap8_VCS:     clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=wrap8_test

run_wrap16_VCS:     clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=wrap16_test

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h *.fsdb verdi*
	clear
# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#

