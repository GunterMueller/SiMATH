/*M
	This is an example for some type conversions in SIMATH.
	First we compute the series

	         _n_        i+1
                 \      (-1)
	a(n) :=   )     ----------
		 /__        i
                 i=1

	using rational arithmetic and then we use the floating point
	arithmetic with a precision of 20 digits to compute a(n) - log(2).
	The input is a small integer (single).
M*/
/*H
	Version 1	22.09.1993	Marc Conrad
H*/
/*cS
	this program uses: fldif, fllog, itor, rdif, rinv, rsum,
	Macros: fldif, getsi, itofl, printf, sodd
cS*/

#include<_simath.h>

main()
{
	single          n;
	floating        f, ln2;

	init(f, ln2);

	printf("Enter an integer: ");
	n = getsi();

	flinit(20);		/* initialization of the precision   */
	ln2 = fllog(itofl(2));	/* calculation of log(2)  	     */
	f = rtofl(a(n));	/* calculation of a(n)    	     */
	/* rtofl converts rational numbers to floating point numbers */

	f = fldif(f, ln2);
	printf("\n a(%d) - log(2) = %.20p \n", n, f);
}

/* calculation of a(n) (subroutine) */

rat             a(n)
single          n;
{
	rat             r, sum;
	single          i;

	init(r, sum);

	sum = itor(0);	/* sum = 0; would be correct too */
	for (i = 1; i <= n; i++)
	{
		r = itor(i);	/* conversion integer - rational */
		r = rinv(r);	/* r := r^-1                     */

		if (sodd(i))
			sum = rsum(sum, r);
		else
			sum = rdif(sum, r);

	}
	return (sum);
}
