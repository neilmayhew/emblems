HC      = ghc
HCFLAGS = -O2

PROGS = emblems list-emblems

all: $(PROGS)

clean:
	$(RM) $(PROGS) *.o *.hi

emblems::
	$(HC) $(HCFLAGS) -o $@ --make Main.hs

list-emblems::
	$(HC) $(HCFLAGS) -o $@ --make List.hs
