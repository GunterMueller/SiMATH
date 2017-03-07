/*M
	This is a short example for the use of integers (espcially
	input/output) in SIMATH.
	Input: an integer A.
	Output: A, A^2 and A + A^2.
M*/
/*H
	Version 1	22.09.1993	Marc Conrad
H*/
/*cS
	this program uses: iprod, isum
	Macros: printf
cS*/

#include<_simath.h>

main()
{
    int             A, B;

    init(A, B);

    printf("Enter an integer: ");
    A = geti();			/* get the integer A from stdin */
    printf("A = %i\n", A);	/* %i in the format string printf means an
				 * arbitary large SIMATH integer */

    B = iprod(A, A);		/* B := A * A */
    printf("A^2 = %i\n", B);

    A = isum(A, B);		/* A := A + B */
    printf("A^2 + A = %i\n", A);
}
