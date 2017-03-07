/*M
.SH NAME
sxprod - single XOR product

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sxprod(a,b,pc,pd)
single a,b;
single *pc,*pd;

.SH DESCRIPTION
sxprod() is identical to sprod() except for the fact that
it internally uses the XOR operator '^' instead of the
addition operator '+' when adding two 32 bit data words.

.SH SEE ALSO
sprod
M*/
/*H
	Version  1      06.01.1992      A.Stein
   DATE sxprod        : 920331
H*/

# include <_arith1.h>

sxprod ( a, b, pc, pd )
single  a, b, *pc, *pd;
{
    if ( !a || !b )   *pc = *pd = 0;
    {
	single a0, a1, b0, b1, c0, c1, c2;

	a0 = a % BSMALL,  a1 = a >> 15;
	b0 = b % BSMALL,  b1 = b >> 15;
	c0 = sxprods(a0,b0);
	c2 = sxprods(a1,b1);
	c1 = sxprods(a0^a1,b0^b1);
	c1 = c0 ^ c1 ^ c2;
	a0 = c1 % BSMALL ,  a1 = c1 >> 15;
	*pc = a1 ^ c2 ,  *pd = ( a0 << 15 ) ^ c0;
    }
    return(0);
}
