/* Copyright 2009 William McLean.  */

#include "npy.h"
#include <stdint.h>

#ifdef __APPLE__
#include <libkern/OSByteOrder.h>
#else
#include <endian.h>
#endif

#ifdef __APPLE__
#ifndef htole16
#define htole16(x)  OSSwapHostToLittleInt16((x))
#endif
#endif


int create_metadata(char preamble[PREAMBLE_LEN], char header[MAX_HDR_LEN],
                    char * descr, int fortran_order,                     
		    int ndims, int* shape)
{
    unsigned char byte;
    uint16_t      hdrlen;
    int n, m, l, topad;
    /* 
    See numpy/lib/format.py for details of the .npy file format.
    */ 
    strcpy(header, "{'descr': '");
    strcat(header, descr);
    strcat(header, "', 'fortran_order': ");
    if ( fortran_order )
        strcat(header, "True, ");
    else
        strcat(header, "False, ");
    strcat(header, "'shape': (");
    for ( m=0; m<ndims; m++ ) {
        l = strlen(header);
	if ( shape[m] < 0 ) {
	    printf("shape[%d] = %d is negative!\n", m, shape[m]);
	    abort();
        }
	if ( l + MAX_INT_LEN + 4 >= MAX_HDR_LEN ) {
	    printf("header too long\n");
	    abort();
        }
	sprintf(header+l, "%d,", shape[m]);
    }
    l = strlen(header);
    if ( ndims > 1 ) header[l-1] = '\0'; // remove comma
    strcat(header, "), }");

    l = strlen(header);
    topad = 16 - ( PREAMBLE_LEN + l + 1 ) % 16;
    if ( l + topad + 1 > MAX_HDR_LEN ) {
        printf("header too long\n");
	abort();
    }
    for ( m=0; m<topad; m++ ) header[l+m] = ' ';
    l += topad;
    header[l] = '\n';
    header[++l] = '\0';

    strcpy(preamble, MAGIC);
    n = strlen(preamble);
    byte = MAJOR;
    preamble[n++] = byte;
    byte = MINOR;
    preamble[n++] = byte;
    hdrlen = htole16(l);
    memcpy((void*) preamble+n, (void*) &hdrlen, 2);
    return l;
}

void npy_save(char* fname, char * descr, int fortran_order, 
              int ndims, int* shape, size_t sz, void* data)
{
    char preamble[PREAMBLE_LEN], header[MAX_HDR_LEN];
    FILE *fp;
    int l, m, n1, n2, n3, mtd_len;

    l = create_metadata(preamble, header, descr, fortran_order, ndims, shape);
    mtd_len = PREAMBLE_LEN + l;
    if ( mtd_len % 16 != 0 ) {
        printf("formatting error: metadata length %d not divisible by 16\n", 
	       mtd_len);
        abort();
    }
    fp = fopen(fname, "w");
    n1 = fwrite(preamble, sizeof(char), PREAMBLE_LEN, fp);
    n2 = fwrite(header,   sizeof(char), l, fp);
    l = 1;
    for ( m=0; m<ndims; m++ ) l *= shape[m];
    n3 = fwrite(data, sz, l, fp);
    fclose(fp);
}

void npy_save_double(char* fname, int fortran_order,
                     int ndims, int* shape, double* data)
{
    char descr[5];
    descr[0] = ENDIAN_CHAR;
    descr[1] = 'f';
    sprintf(descr+2, "%d", (int) sizeof(double));
    npy_save(fname, descr, fortran_order, ndims, shape, sizeof(double), data);
}

void npy_save_float(char* fname, int fortran_order, 
                    int ndims, int* shape, float* data)
{
    char descr[5];
    descr[0] = ENDIAN_CHAR;
    descr[1] = 'f';
    sprintf(descr+2, "%d", (int) sizeof(float));
    npy_save(fname, descr, fortran_order, ndims, shape, sizeof(float), data);
}

void npy_save_int(char* fname, int fortran_order, 
                  int ndims, int* shape, int* data)
{
    char descr[5];
    descr[0] = ENDIAN_CHAR;
    descr[1] = 'i';
    sprintf(descr+2, "%d", (int) sizeof(int));
    npy_save(fname, descr, fortran_order, ndims, shape, sizeof(int), data);
}

void npy_save_float_complex(char* fname, int fortran_order, 
                            int ndims, int* shape, 
                            float complex *data)
{
    char descr[5];
    size_t sz;

    descr[0] = ENDIAN_CHAR;
    descr[1] = 'c';
    sz = sizeof(float complex);
    sprintf(descr+2, "%d", (int) sz);
    npy_save(fname, descr, fortran_order, ndims, shape, sz, data);
}

void npy_save_double_complex(char* fname, int fortran_order, 
                            int ndims, int* shape, 
                            double complex *data)
{
    char descr[5];
    size_t sz;

    descr[0] = ENDIAN_CHAR;
    descr[1] = 'c';
    sz = sizeof(double complex);
    sprintf(descr+2, "%d", (int) sz);
    npy_save(fname, descr, fortran_order, ndims, shape, sz, data);
}
