program test_fnpy_nomod

    implicit none
    integer, parameter :: DP = selected_real_kind(15)
    complex, parameter :: I = cmplx(0.0,1.0)

    real     :: a(4)   = (/ 1, 2, 3, 4 /)
    real     :: b(3,2) = reshape([ 1, 2, 3, 4, 5, 6 ], [3, 2])
    real(DP) :: c(2,3) = reshape([1, 2, 3, 4, 5, 6], [2, 3])
    integer  :: n, d(2,5) = reshape([(n, n=1, 10)], [2,5])
    complex  :: e(3,1) = reshape([1+3*I, 2+2*I, 3+I], [3,1])
    complex(DP) :: f(2) = [ 1 + 2*I, 2 + I ]

    write(6,*) "Creating files fa.npy, fb.npy, fc.npy, fd.npy..."
    
    call snpys("fa.npy", 1, shape(a), a)
    call snpys("fb.npy", 2, shape(b), b)
    call dnpys("fc.npy", 2, shape(c), c)
    call inpys("fd.npy", 2, shape(d), d)
    call cnpys("fe.npy", 2, shape(e), e)
    call znpys("ff.npy", 1, shape(f), f)

end program !test_fnpy_nomod
