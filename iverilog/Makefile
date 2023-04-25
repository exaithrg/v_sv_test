TOPNAME = testv
IVERILOG = iverilog
IVERILOG_FLAGS += -g2005-sv

# Note: if need include dir or define names:
# +incdir+path
# +define+name=value

all:
	# find . -type f -regex ".*\.\(v\|sv\)" > ivfiles.f
	$(IVERILOG) $(IVERILOG_FLAGS) -o $(TOPNAME).out -f ivfiles.f -s $(TOPNAME)

# .PHONY: files
# files:
#     find ./ -name "*.[v|sv]" > ivfiles.f

sim: all
	vvp -n $(TOPNAME).out -l err.log >> run.log
	# ./$(TOPNAME)

wave: sim
	gtkwave ./dump.vcd &
	
clean:
	rm -rf $(TOPNAME).out
	rm dump.vcd
	# rm run.log
	
wv: wave

cl: clean

.PHONY: sim wave wv clean cl

