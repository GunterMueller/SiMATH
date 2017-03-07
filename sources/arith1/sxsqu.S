/*M
.SH NAME
sxsqu - single XOR square

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sxsqu(a,pc,pd)
single a;
single *pc,*pd;

.SH DESCRIPTION
sxsqu() is is equivalent to sxprod(a,a,pc,pd)
but the computation is performed more efficiently.

.SH SEE ALSO
sxprod
M*/
/*H
	Version  1      05.02.1992      A.Stein
   DATE sxsqu         : 920331
H*/


# include <_arith1.h>

sxsqu( a, pc, pd )
single  a, *pc, *pd;
{
    if ( !a )   *pc = *pd = 0;
    {
	single a0, a1;

	a0 = a % BSMALL, a1 = a >> 15;
	*pd = sxprods(a0,a0);
	*pc = sxprods(a1,a1);
    }
    return(0);
}
