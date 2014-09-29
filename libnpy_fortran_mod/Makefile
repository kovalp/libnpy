include ../arch.inc

vpath %.h       ../include
vpath %.mod     ../include
vpath test%.c   ../test
vpath test%.F90 ../test
vpath %.a %.so  ../lib
vpath npy.c     ../src
vpath fnpy.F90  ../src
vpath %.py      ../src
vpath arch.inc  ..

libnpy.a: npy.o fnpy.o 
	$(AR) rvcs $@ $^

libnpy.so.0.5: npy.o fnpy.o
	$(FC) -o $@ -shared -Wl,-soname=libnpy.so.0 $^

check: check2 check3

check2: check_npy2.py test_npy test_fnpy_mod
ifdef PYTHON2
	./test_npy
	./test_fnpy_mod
	$(PYTHON2) ../src/check_npy2.py
	$(PYTHON2) ../src/check_fnpy2.py
else
	@echo "PYTHON2 variable is not defined. No test performed."
endif

check3: check_npy3.py test_npy test_fnpy_mod
ifdef PYTHON3 
	./test_npy
	./test_fnpy_mod
	$(PYTHON3) ../src/check_npy3.py
	$(PYTHON3) ../src/check_fnpy3.py
else
	@echo "PYTHON3 variable is not defined. No test performed."
endif

npy.o: npy.c npy.h arch.inc
	$(CC) $(CFLAGS) -c $<

fnpy.o fnpy.mod: fnpy.F90 arch.inc
	$(FC) $(FFLAGS) -c $<
	$(CP) fnpy.mod ../include

test_metadata: test_metadata.o npy.o
	$(CC) $(CFLAGS) -o $@ $^

test_npy: test_npy.o libnpy.a
	$(CC) $(CFLAGS) -o $@ $^

test_fnpy_mod: test_fnpy_mod.o libnpy.a
	$(FC) $(FFLAGS) -o $@ $^

test_npy.o: npy.h test_npy.c

test_metadata.o: npy.h test_metadata.c libnpy.a

test_fnpy_mod.o: test_fnpy_mod.F90 fnpy.mod libnpy.a
	$(FC) $(FFLAGS) -c $<

libname: libname.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) -f test_npy test_metadata test_fnpy libnpy.a libname *.mod *.npy *.o *.pyc

reallyclean: clean
	$(RM) -f ../include/fnpy.mod ../include/*.h.gch

install: libnpy.a
	$(MKDIR-P) $(PREFIX)/lib/ $(PREFIX)/include/	
	$(INSTALL) libnpy.a $(PREFIX)/lib/
	$(INSTALL) ../include/npy.h $(PREFIX)/include/
	$(INSTALL) ../influde/fnpy.mod $(PREFIX)/include/
