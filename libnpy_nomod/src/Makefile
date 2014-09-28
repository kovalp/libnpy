include arch.inc

vpath %.h       ../include
vpath test%.c   ../test
vpath test%.f90 ../test
vpath %.a %.so  ../lib

ifeq ($(strip $(FC)),)
# Fortran compiler is not available
libnpy.a: npy.o
	$(AR) rvcs $@ $<
	$(CP) $@ ../lib

check: check_npy.py test_npy
	./test_npy
	./check_npy.py
else
# A fortran compiler is specified 
libnpy.a: npy.o fnpy_nomod.o
	$(AR) rvcs $@ $^
	$(CP) $@ ../lib

check: check_npy.py test_npy check_fnpy.py test_fnpy
	./test_npy
	./check_npy.py
	./test_fnpy
	./check_fnpy.py

libnpy.so.$(VERSION): npy.o fnpy_nomod.o
	$(FC) $(FFLAGS) -o $@ -shared -Wl,-soname=libnpy.so.0 $^ 
	$(CP) $@ ../lib
endif

test_npy: test_npy.o libnpy.a
	$(CC) $(CFLAGS) -o $@ $^

test_fnpy: test_fnpy.o libnpy.a
	$(FC) $(FFLAGS) -o $@ $^

npy.o: npy.c npy.h arch.inc
	$(CC) $(CFLAGS) -c $<

test_npy.o: npy.h test_npy.c arch.inc

fnpy_nomod.o: fnpy_nomod.F90 arch.inc
	$(FC) $(FFLAGS) -c $<

test_fnpy.o: test_fnpy.f90 libnpy.a arch.inc
	$(FC) $(FFLAGS) -c $<

clean:
	$(RM) -f test_npy test_metadata test_fnpy *.a *.npy *.o *.pyc

reallyclean: clean
	$(RM) -f ../lib/libnpy.* ../include/*.h.gch

install: libfnpy.a
	install ../lib/libnpy.a $(PREFIX)/lib
	install ../include/npy.h $(PREFIX)/include

