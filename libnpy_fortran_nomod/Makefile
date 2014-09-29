include ../arch.inc

vpath %.h       ../include
vpath test%.c   ../test
vpath test%.F90 ../test
vpath %.a %.so  ../lib
vpath npy.c          ../src
vpath fnpy_nomod.F90 ../src
vpath arch.inc  ..
vpath %.py           ../src


libnpy.a: npy.o fnpy_nomod.o
	$(AR) rvcs $@ $^

libnpy.so.$(VERSION): npy.o fnpy_nomod.o
	$(FC) $(FFLAGS) -o $@ -shared -Wl,-soname=libnpy.so.0 $^ 
	$(CP) $@ ../lib

check: check2 check3

check2: check_npy2.py test_npy test_fnpy_nomod
ifdef PYTHON2
	./test_npy
	./test_fnpy_nomod
	$(PYTHON2) ../src/check_npy2.py
	$(PYTHON2) ../src/check_fnpy2.py
else
	@echo "PYTHON2 variable is not defined. No test performed."
endif

check3: check_npy3.py test_npy test_fnpy_nomod
ifdef PYTHON3 
	./test_npy
	./test_fnpy_nomod
	$(PYTHON3) ../src/check_npy3.py
	$(PYTHON3) ../src/check_fnpy3.py
else
	@echo "PYTHON3 variable is not defined. No test performed."
endif

npy.o: npy.c npy.h arch.inc
	$(CC) $(CFLAGS) -c $<

fnpy_nomod.o: fnpy_nomod.F90 arch.inc
	$(FC) $(FFLAGS) -c $<

test_npy: test_npy.o libnpy.a
	$(CC) $(CFLAGS) -o $@ $^

test_fnpy_nomod: test_fnpy_nomod.o libnpy.a
	$(FC) $(FFLAGS) -o $@ $^

test_npy.o: npy.h test_npy.c arch.inc

test_fnpy_nomod.o: test_fnpy_nomod.F90 libnpy.a arch.inc
	$(FC) $(FFLAGS) -c $<

clean:
	$(RM) -f test_npy test_metadata test_fnpy *.a *.npy *.o *.pyc

reallyclean: clean
	$(RM) -f libnpy.* ../include/*.h.gch

install: libnpy.a
	$(MKDIR-P) $(PREFIX)/lib/ $(PREFIX)/include/
	$(INSTALL) libnpy.a $(PREFIX)/lib/
	$(INSTALL) ../include/npy.h $(PREFIX)/include/

