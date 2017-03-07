/*M
.SH NAME
flsin - floating point sinus

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flsin(a)
floating a;

.SH DESCRIPTION
flsin() returns sin(a).
.PP
.TP 4
.B a
-2^15 < a < 2^15 is an angle in radiant measure.
M*/

/*H
	Version 1	22.02.1992	Marc Conrad
	Version 2 	15.12.1992	Fehler beseitigt.  MC
   DATE flsin         : 920331.930115
H*/


#include<_arith1.h>

floating flsin(x)
	floating x;
{
	floating Pi2, Pi4, xq, xp2, h, arg;
	int m;
	single s, sgn;

	init(Pi2, Pi4, xq, xp2, h, arg);
	bind ( x );

	if (!x)
		return ( 0 );  
	if ( ( sgn = flsign( x ) ) <  0 ) x = flneg( x );
	FL_EPS++;
	Pi2 = flsquot(flPi(), 2);
	Pi4 = flsquot(flPi(), 4);
	xq = flquot(x, Pi2);
	xp2 = flfloor(xq);

	h = itofl(xp2);
	h = flprod(h, Pi2);
	xq = fldif(x, h);

	s = mshom(4, xp2);

	if (s == 0)
		arg = xq;
	else if (s == 1)
		arg = fldif(Pi2, xq);
	else if (s == 2)
		arg = flneg(xq);
	else
		arg = fldif(xq, Pi2);

        FL_EPS--;
	if (flcomp(arg, flneg(Pi4)) < 0) {
		h = flneg(flcos_sp(flsum(arg, Pi2)));
	} else if (flcomp(arg, Pi4) < 0) {
		h = flsin_sp(arg);                      
	} else {
		h = flcos_sp(fldif(Pi2, arg));
	}            
	if ( sgn < 0 ) h = flneg( h );
	return (h);

}


