#include"npy.h"

int main()
{
    int  ndims = 2;
    int  shape[2];
    double a[3][3] = { { 1, 2, 3 },
                       { 4, 5, 6 },
                       { 7, 8, 9 } };
    float  b[2][3] = { { 0.5, 1.0, 1.5 },
                       { 2.0, 2.5, 3.0 } };
    int    c[3][2] = { { 1, 2 },
                       { 3, 4 },
		       { 5, 6 } };
    float complex d[3] = { 1 + 3*I, 2 + 2*I, 3 + I };
    double complex e[2][3] = { { 1 + 6*I, 2 + 5*I, 3 + 4*I },
                               { 4 + 3*I, 5 + 2*I, 6 + I } };

    printf("Creating files a.npy, b.npy, c.npy, d.npy, e.npy\n");
    shape[0] = 3;
    shape[1] = 3;
    npy_save_double("a.npy", 0, ndims, shape, &a[0][0]);
    shape[0] = 2;
    npy_save_float("b.npy", 0, ndims, shape, &b[0][0]);
    shape[0] = 3;
    shape[1] = 2;
    npy_save_int("c.npy", 0, ndims, shape, &c[0][0]);
    npy_save_float_complex("d.npy", 0, 1, shape, &d[0]);
    shape[0] = 2;
    shape[1] = 3;
    npy_save_double_complex("e.npy", 0, 2, shape, &e[0][0]);
    return 0;
}
