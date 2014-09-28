include arch.inc

CDATA_FILES = a.npy  b.npy  c.npy
FDATA_FILES = fa.npy fb.npy fc.npy fd.npy

vpath %.h       ../include
vpath test%.c   ../test
vpath test%.f90 ../test
vpath %.a %.so  ../lib

libfnpy.a: npy.o fnpy_nomod.o
	$(AR) rvcs $@ $^
	$(CP) $@ ../lib

libnpy.a: npy.o
	$(AR) rvcs $@ $<
	$(CP) $@ ../lib

libnpy.so.$(VERSION): npy.o fnpy_nomod.o
	$(FC) $(FFLAGS) -o $@ -shared -Wl,-soname=libnpy.so.0 $^ 
	$(CP) $@ ../lib

check: check_npy.py $(CDATA_FILES) 
	./$<

check_fortran: check_fnpy.py $(FDATA_FILES)
	./$<

$(CDATA_FILES): test_npy
	./$<

$(FDATA_FILES): test_fnpy
	./$<

test_metadata: test_metadata.o npy.o
	$(CC) $(CFLAGS) -o $@ $^

test_npy: test_npy.o libnpy.a
	$(CC) $(CFLAGS) -o $@ $< $(LIBNPY)

test_fnpy: test_fnpy.o libfnpy.a
	$(FC) $(FFLAGS) -o $@ $^

npy.o: npy.c npy.h arch.inc
	$(CC) $(CFLAGS) -c $<

test_npy.o: npy.h test_npy.c arch.inc
test_metadata.o: npy.h test_metadata.c libnpy.a

fnpy_nomod.o: fnpy_nomod.F90 arch.inc
	$(FC) $(FFLAGS) -c $<

test_fnpy.o: test_fnpy.f90 libfnpy.a arch.inc
	$(FC) $(FFLAGS) -c $<

libname: libname.c arch.inc
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) -f test_npy test_metadata test_fnpy libname *.npy *.o *.pyc

reallyclean: clean
	$(RM) -f ../lib/libnpy.* ../lib/libfnpy.* ../include/*.h.gch

install: libfnpy.a
	install ../lib/libfnpy.a $(PREFIX)/lib
	install ../include/npy.h $(PREFIX)/include
	
