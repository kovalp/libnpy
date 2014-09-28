/*
Functions to create native numpy data files (.npy).
*/

#pragma once

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<complex.h>

#ifdef __cplusplus
extern "C" {
#endif

static const char LIBNPY_VERSION[] = "0.5";
static const char MAGIC[] = "\x93NUMPY";
static const int  MAJOR = 1;
static const int  MINOR = 0;
static const int  MAX_HDR_LEN = 256 * 256;
static const int  MAX_INT_LEN = 32;
static const int  PREAMBLE_LEN = 6 + 1 + 1 + 2;

#if __BYTE_ORDER == __LITTLE_ENDIAN
static const char ENDIAN_CHAR = '<';
#else
static const char ENDIAN_CHAR = '>';
#endif

int create_metadata(char preamble[PREAMBLE_LEN], char header[MAX_HDR_LEN],
                    char* descr, int fortran_order, 
		    int ndims, int* shape);

void npy_save(char* fname, char* descr, int fortran_order,
              int ndims, int* shape, size_t sz, void* data);

void npy_save_double(char* fname, int fortran_order, 
                     int ndims, int* shape, double* data);

void npy_save_float(char* fname, int fortran_order,
                    int ndims, int* shape, float* data);

void npy_save_int(char* fname, int fortran_order,
                  int ndims, int* shape, int* data);

void npy_save_float_complex(char* fname, int fortran_order,
                            int ndims, int* shape, 
                            float complex *data);

void npy_save_double_complex(char* fname, int fortran_order,
                            int ndims, int* shape,
                            double complex *data);

#ifdef __cplusplus
}
#endif

