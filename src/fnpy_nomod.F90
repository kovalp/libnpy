!
!
!
function len_trim_fnpy(str) result(l)
  implicit none
  character(len=*), intent(in) :: str
  integer :: l
  !! internal
  integer :: p, ll
  l = len(str)
  ll=l
  do p=ll,1,-1; if(str(p:p)==' ') l = l - 1; enddo
end function  len_trim_fnpy

!
!
!
subroutine make_c_string(str, c_str)
  use iso_c_binding, only : C_CHAR, C_NULL_CHAR
  implicit none
  character(*), intent(in) :: str
  character(*,kind=C_CHAR), intent(inout) :: c_str
  !! internal
  integer :: lt, lmx, len_trim_fnpy
  lmx = len(c_str)
  lt = min(len_trim_fnpy(str), lmx-1)
  c_str(1:lt) = str(1:lt)
  c_str(lt+1:lt+1) = C_NULL_CHAR
end subroutine ! make_c_string

!
!
!
subroutine save_single(fname, ndims, sh, a)
  use iso_c_binding, only : C_FLOAT, C_INT
  implicit none
  interface
    subroutine c_npy_save_float(fname, fortran_order, & 
      ndims, sh, data)  bind(c, name="npy_save_float")
      use iso_c_binding, only : C_CHAR, C_INT, C_FLOAT
      implicit none
      character(kind=C_CHAR), intent(in)        :: fname(*)
      integer(kind=C_INT), intent(in), value :: fortran_order
      integer(kind=C_INT), intent(in), value :: ndims
      integer(kind=C_INT),    intent(in)        :: sh(*)
      real(kind=C_FLOAT),     intent(in)        :: data(*)

    end subroutine c_npy_save_float
  end interface
      
  character(len=*), intent(in) :: fname
  integer(kind=C_INT),   intent(in) :: ndims, sh(*)
  real(C_FLOAT),    intent(in) :: a(*)
  ! internal
  character(2000) :: buf
  call make_c_string(fname, buf)
  call c_npy_save_float(buf, 1_C_INT, ndims, sh, a) 
  !write(6,*) 'save_single: exit.'

end subroutine !save_single

!
!
!
subroutine save_double(fname, nd, shape, a)
  use iso_c_binding, only : C_INT, C_DOUBLE, C_NULL_CHAR
  implicit none
  character(len=*), intent(in) :: fname
  integer(C_INT),   intent(in) :: nd, shape(*)
  real(C_DOUBLE),   intent(in) :: a(*)
  interface
    subroutine c_npy_save_double(fname, fortran_order, &
      ndims, shape, data)   bind(c, name="npy_save_double")
      use iso_c_binding, only :  C_CHAR, C_INT, C_DOUBLE
      implicit none
      character(kind=C_CHAR), intent(in)     :: fname(*) 
      integer(kind=C_INT), intent(in), value :: fortran_order, ndims
      integer(kind=C_INT),    intent(in)     :: shape(*)
      real(kind=C_DOUBLE),    intent(in)     :: data(*)
    end subroutine c_npy_save_double
  end interface
  ! internal
  character(2000) :: buf
  call make_c_string(fname, buf)

  call c_npy_save_double(buf, 1_C_INT, nd, shape, a)

end subroutine save_double

!
!
!
subroutine save_integer(fname, nd, shape, a)
  use iso_c_binding, only : C_INT, C_NULL_CHAR

  implicit none
  character(len=*), intent(in) :: fname
  integer(C_INT),   intent(in) :: nd, shape(*)
  integer(C_INT),   intent(in) :: a(*)
  interface
    subroutine c_npy_save_int(fname, fortran_order, &
      ndims, shape, data)   bind(c, name="npy_save_int")
      use iso_c_binding, only : C_CHAR, C_INT
      implicit none
      character(kind=C_CHAR), intent(in)     :: fname(*) 
      integer(kind=C_INT), intent(in), value :: fortran_order, ndims
      integer(kind=C_INT),    intent(in)     :: shape(*)
      integer(kind=C_INT),    intent(in)     :: data(*)
    end subroutine c_npy_save_int
  end interface
  ! internal
  character(2000) :: buf
  call make_c_string(fname, buf)

  call c_npy_save_int(buf, 1_C_INT, nd, shape, a) 
end subroutine save_integer


!
!
!
subroutine save_complex_single(fname, nd, shape, a)
  use iso_c_binding, only : C_INT, C_FLOAT, C_NULL_CHAR

  implicit none
  character(len=*), intent(in) :: fname
  integer(C_INT),   intent(in) :: nd, shape(*)
  complex(C_FLOAT), intent(in) :: a(*)
  interface
    subroutine c_npy_save_float_complex(fname, fortran_order, &
      ndims, shape, data)   bind(c, name="npy_save_float_complex")
      use iso_c_binding, only : C_CHAR, C_INT, C_FLOAT_COMPLEX
      implicit none
      character(kind=C_CHAR), intent(in)     :: fname(*)
      integer(kind=C_INT), intent(in), value :: fortran_order, ndims
      integer(kind=C_INT),    intent(in)     :: shape(*)
      complex(kind=C_FLOAT_COMPLEX), intent(in) :: data(*)
    end subroutine c_npy_save_float_complex
  end interface
  ! internal
  character(2000) :: buf
  call make_c_string(fname, buf)

  call c_npy_save_float_complex(buf, 1_C_INT, nd, shape, a) 

end subroutine !save_complex_single


!
!
!
subroutine save_complex_double(fname, nd, shape, a)
  use iso_c_binding, only : C_INT, C_DOUBLE, C_NULL_CHAR

  implicit none
  character(len=*),  intent(in) :: fname
  integer(C_INT),    intent(in) :: nd, shape(*)
  complex(C_DOUBLE), intent(in) :: a(*)
  interface
    subroutine c_npy_save_double_complex(fname, fortran_order, &
      ndims, shape, data)   bind(c, name="npy_save_double_complex")
      use iso_c_binding, only : C_CHAR, C_INT, C_DOUBLE_COMPLEX
      implicit none
      character(kind=C_CHAR),  intent(in)     :: fname(*)
      integer(kind=C_INT),  intent(in), value :: fortran_order,ndims
      integer(kind=C_INT),     intent(in)     :: shape(*)
      complex(kind=C_DOUBLE_COMPLEX), intent(in) :: data(*)
    end subroutine c_npy_save_double_complex
  end interface
  ! internal
  character(2000) :: buf
  call make_c_string(fname, buf)

  call c_npy_save_double_complex(buf, 1_C_INT, nd, shape, a) 

end subroutine !save_complex_double

