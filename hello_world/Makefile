#
# Easy as that (!!!)
#
# http://www.ijon.de/comp/tutorials/makefile.html
# https://ghdl.readthedocs.io/en/latest/using/InvokingGHDL.html
# 

GHDL=ghdl
GHDLFLAGS=
GHDLRUNFLAGS=
GHDLPROG=hello_world

all : 
	@$(GHDL) -a $(GHDLFLAGS) $(GHDLPROG).vhd
	@$(GHDL) -c $(GHDLFLAGS) -e $(GHDLPROG)

run : all
	@$(GHDL) -c $(GHDLFLAGS) -r $(GHDLPROG) $(GHDLRUNFLAGS)

clean : 
	@rm work-obj93.cf
