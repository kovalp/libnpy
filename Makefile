include arch.inc

LIBRARIES = \
libnpy_c_only_bindings \
libnpy_fortran_mod \
libnpy_fortran_nomod

.SUFFIXES: .o .F90 .f90 .c .py
.PHONY: $(LIBRARIES) clean install
.NOTPARALLEL: $(EXECUTABLES)

all: $(LIBRARIES)

libnpy_c_only_bindings:
	make -C $@
	@echo "$@ is finished."

libnpy_fortran_mod:
	make -C $@
	@echo "$@ is finished."

libnpy_fortran_nomod:
	make -C $@
	@echo "$@ is finished."

check: $(LIBRARIES)
	make -C libnpy_c_only_bindings check
	make -C libnpy_fortran_mod check
	make -C libnpy_fortran_nomod check

clean:
	make -C libnpy_c_only_bindings clean
	make -C libnpy_fortran_mod clean
	make -C libnpy_fortran_nomod clean

install:
ifeq ($(INSTALL_FLAVOR), c_only_bindings)
	make -C libnpy_c_only_bindings install
else ifeq ($(INSTALL_FLAVOR), fortran_mod)
	make -C libnpy_fortran_mod install
else ifeq ($(INSTALL_FLAVOR), fortran_nomod)
	make -C libnpy_fortran_nomod install
else
	@echo "Unknown INSTALL_FLAVOR $(INSTALL_FLAVOR)"
endif
