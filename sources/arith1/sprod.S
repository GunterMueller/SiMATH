/*M
.SH NAME
sprod - single-precision product

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sprod(a,b,pc,pd)
single a,b,*pc,*pd;

.SH DESCRIPTION
sprod() calculates the singles *pc, *pd where
*pc is the integer part of (a*b)/BASIS and it
holds that  (*pc) * (*pd) >= 0 and (*pc) * BASIS + (*pd) = a * b.
The returnd value is always 0.
M*/
/*H
	Version  1      05.08.1986      R. Boeffgen
	Version  2      08.05.1989      mods.  CH/US
	Version  3      15.11.1991      nach Karatsuba.  MC
   DATE sprod         : 890501.890601.911215
H*/


#include <_arith1.h>

single sprod ( a, b, pc, pd )           /* safe */
single  a, b, *pc, *pd;
{
    if ( a==0 || b==0 )   *pc = *pd = 0;
    else
    {
	single a0,a1, b0,b1, c,c0,c1,c2, d;
	char s=0;
	
	if ( a < 0 )  a = -a, s = 1;
	if ( b < 0 )  b = -b, s = !s;

	a0 = a & HALF_MASK,  a1 = a >> HALF_WIDTH;
	b0 = b & HALF_MASK,  b1 = b >> HALF_WIDTH;
	c0 = a0 * b0;
	c2 = a1 * b1;
	c1 = (a0 + a1) * ( b0 + b1 ) - ( c0 + c2 );
	a0 = c1 & HALF_MASK,  a1 = c1 >> HALF_WIDTH;
	c = c2 + a1;
	d = (a0 << HALF_WIDTH) + c0;
	if ( d >= BASIS )  c++, d -= BASIS;
	if ( s ) *pc =  -c,  *pd = - d;
	else *pc = c,  *pd = d;
    }
    return(0);
}
