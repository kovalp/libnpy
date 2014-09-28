! Copyright 2009 William McLean.

module fnpy
    !
    ! Provides routines for creating numpy .npy data files.
    !
    use iso_c_binding
    implicit none
    private

    public :: save_single, save_double, save_integer, &
              save_complex_single, save_complex_double

    interface
        subroutine c_npy_save_float(fname, fortran_order, &
                                    ndims, shape, data)   &
                                    bind(c, name="npy_save_float")
            import C_CHAR, C_INT, C_FLOAT
            character(kind=C_CHAR), intent(in)        :: fname(*)
            integer(kind=C_INT),    intent(in), value :: fortran_order, ndims
            integer(kind=C_INT),    intent(in)        :: shape(*)
            real(kind=C_FLOAT),     intent(in)        :: data(*)
        end subroutine c_npy_save_float
    end interface

    interface
        subroutine c_npy_save_double(fname, fortran_order, &
                                     ndims, shape, data)   &
                                     bind(c, name="npy_save_double")
            import C_CHAR, C_INT, C_DOUBLE
            character(kind=C_CHAR), intent(in)        :: fname(*) 
            integer(kind=C_INT),    intent(in), value :: fortran_order, ndims
            integer(kind=C_INT),    intent(in)        :: shape(*)
            real(kind=C_DOUBLE),    intent(in)        :: data(*)
        end subroutine c_npy_save_double
    end interface

    interface
        subroutine c_npy_save_int(fname, fortran_order, &
                                     ndims, shape, data)   &
                                     bind(c, name="npy_save_int")
            import C_CHAR, C_INT
            character(kind=C_CHAR), intent(in)        :: fname(*) 
            integer(kind=C_INT),    intent(in), value :: fortran_order, ndims
            integer(kind=C_INT),    intent(in)        :: shape(*)
            integer(kind=C_INT),    intent(in)        :: data(*)
        end subroutine c_npy_save_int
    end interface

    interface
        subroutine c_npy_save_float_complex(fname, fortran_order, &
                                            ndims, shape, data)   &
                                    bind(c, name="npy_save_float_complex")
            import C_CHAR, C_INT, C_FLOAT_COMPLEX
            character(kind=C_CHAR), intent(in)        :: fname(*)
            integer(kind=C_INT),    intent(in), value :: fortran_order, ndims
            integer(kind=C_INT),    intent(in)        :: shape(*)
            complex(kind=C_FLOAT_COMPLEX), intent(in) :: data(*)
        end subroutine c_npy_save_float_complex
    end interface

    interface
        subroutine c_npy_save_double_complex(fname, fortran_order, &
                                             ndims, shape, data)   &
                                    bind(c, name="npy_save_double_complex")
            import C_CHAR, C_INT, C_DOUBLE_COMPLEX
            character(kind=C_CHAR),  intent(in)        :: fname(*)
            integer(kind=C_INT),     intent(in), value :: fortran_order, ndims
            integer(kind=C_INT),     intent(in)        :: shape(*)
            complex(kind=C_DOUBLE_COMPLEX), intent(in) :: data(*)
        end subroutine c_npy_save_double_complex
    end interface

contains

    subroutine save_single(fname, shape, a)
        character(len=*), intent(in) :: fname
        integer(C_INT),   intent(in) :: shape(:)
        real(C_FLOAT),    intent(in) :: a(*)

        call c_npy_save_float(trim(fname)//C_NULL_CHAR, 1_C_INT,  &
                              size(shape), shape, a) 

    end subroutine save_single

    subroutine save_double(fname, shape, a)
        character(len=*), intent(in) :: fname
        integer(C_INT),   intent(in) :: shape(:)
        real(C_DOUBLE),   intent(in) :: a(*)

        call c_npy_save_double(trim(fname)//C_NULL_CHAR, 1_C_INT,  &
                               size(shape), shape, a) 

    end subroutine save_double

    subroutine save_integer(fname, shape, a)
        character(len=*), intent(in) :: fname
        integer(C_INT),   intent(in) :: shape(:)
        integer(C_INT),   intent(in) :: a(*)

        call c_npy_save_int(trim(fname)//C_NULL_CHAR, 1_C_INT,  &
                            size(shape), shape, a) 

    end subroutine save_integer

    subroutine save_complex_single(fname, shape, a)
        character(len=*), intent(in) :: fname
        integer(C_INT),   intent(in) :: shape(:)
        complex(C_FLOAT), intent(in) :: a(*)

        call c_npy_save_float_complex(trim(fname)//C_NULL_CHAR, 1_C_INT,  &
                                      size(shape), shape, a) 

    end subroutine save_complex_single

    subroutine save_complex_double(fname, shape, a)
        character(len=*),  intent(in) :: fname
        integer(C_INT),    intent(in) :: shape(:)
        complex(C_DOUBLE), intent(in) :: a(*)

        call c_npy_save_double_complex(trim(fname)//C_NULL_CHAR, 1_C_INT,  &
                                       size(shape), shape, a) 

    end subroutine save_complex_double

end module fnpy
