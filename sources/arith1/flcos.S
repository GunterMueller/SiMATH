/*M
.SH NAME
flcos - floating point cosine

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flcos(a)
floating a;

.SH DESCRIPTION
flcos() returns cos (a).
 
.PP
.TP 4
.B a
-2^15 < a < 2^15 is an angle in radiant measure.
M*/

/*H
	Version 1	22.02.1992	Marc Conrad
   DATE flcos         : 920331
H*/


#include<_arith1.h>

floating flcos(x)
	floating x;
{
	floating Pi2;

	init(Pi2);
	bind(x);

	FL_EPS++;
	Pi2 = flsquot(flPi(), 2);
	x = fldif(Pi2, x);
	FL_EPS--;
	return (flsin(x));
}
