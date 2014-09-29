include ../arch.inc

vpath %.h       ../include
vpath %.mod     ../include
vpath test%.c   ../test
vpath %.a %.so  ../lib
vpath %.c       ../src
vpath %.py      ../src
vpath arch.inc  ..

libnpy.a: npy.o arch.inc 
	$(AR) rvcs $@ $<

check: check2 check3

check2: check_npy2.py test_npy
ifdef PYTHON2
	./test_npy
	$(PYTHON2) ../src/check_npy2.py
else
	@echo "PYTHON2 variable is not defined. No test performed."
endif

check3: check_npy3.py test_npy
ifdef PYTHON3 
	./test_npy
	$(PYTHON3) ../src/check_npy3.py
else
	@echo "PYTHON3 variable is not defined. No test performed."
endif

npy.o: npy.c npy.h arch.inc
	$(CC) $(CFLAGS) -c $<

test_metadata: test_metadata.o npy.o
	$(CC) $(CFLAGS) -o $@ $^

test_npy: test_npy.o libnpy.a
	$(CC) $(CFLAGS) -o $@ $^

test_npy.o: npy.h test_npy.c arch.inc
test_metadata.o: npy.h test_metadata.c libnpy.a

libname: libname.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) -f test_npy libnpy.a test_metadata libname *.npy *.o *.pyc

reallyclean: clean
	$(RM) -f ../include/*.h.gch

install: libnpy.a
	$(MKDIR-P) $(PREFIX)/lib $(PREFIX)/include	
	$(INSTALL) libnpy.a $(PREFIX)/lib/
	$(INSTALL) ../include/npy.h $(PREFIX)/include/
