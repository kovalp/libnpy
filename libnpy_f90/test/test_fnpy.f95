program test_fnpy

    use fnpy
    implicit none

    integer, parameter :: DP = selected_real_kind(15)
    complex, parameter :: I = cmplx(0.0,1.0)

    real     :: a(4)   = [ 1, 2, 3, 4 ]
    real     :: b(3,2) = reshape([ 1, 2, 3, 4, 5, 6 ], [3, 2])
    real(DP) :: c(2,3) = reshape([1, 2, 3, 4, 5, 6], [2, 3])
    integer  :: n, d(2,5) = reshape([(n, n=1, 10)], [2,5])
    complex  :: e(3,1) = reshape([1+3*I, 2+2*I, 3+I], [3,1])
    complex(DP) :: f(2) = [ 1 + 2*I, 2 + I ]

    print *, "Creating files fa.npy, fb.npy, fc.npy, fd.npy"
    call save_single ("fa.npy", shape(a), a)
    call save_single ("fb.npy", shape(b), b)
    call save_double ("fc.npy", shape(c), c)
    call save_integer("fd.npy", shape(d), d)
    call save_complex_single("fe.npy", shape(e), e)
    call save_complex_double("ff.npy", shape(f), f)

end program test_fnpy
