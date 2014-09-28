#include"npy.h"

int main(){
    char preamble[PREAMBLE_LEN], header[MAX_HDR_LEN];
    int shape[3] = { 3, 2, 5 }, l, n1, n2;
    const char fname[] = "mtd";
    char cmd[70];
    FILE *fp;

    l = create_metadata(preamble, header, "<f4", 0, 3, shape);
    fp = fopen(fname, "w");
    n1 = fwrite(preamble, sizeof(char), PREAMBLE_LEN, fp);
    n2 = fwrite(header, sizeof(char), l, fp);
    fclose(fp);
    printf("\nWrote %d bytes to %s\n\n", n1+n2, fname);
    sprintf(cmd, "hexdump -c %s", fname);
    system(cmd);
    printf("\n");
    sprintf(cmd, "hexdump -C %s", fname);
    system(cmd);
    return 0;
}
