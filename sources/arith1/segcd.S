/*M
.SH NAME
segcd - single-precision extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_arith1.h>

single segcd(a,b,pu,pv)
single a,b;
single *pu,*pv;

.SH DESCRIPTION
segcd() returns the greatest common divisor c of a and b
for a,b >0.
Simultaneously *pu and *pv with c = *pu * a + *pv * b
are calculated. For a = b = 0 then result c equals 0.
M*/

/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2      14.05.1987      Bedingung a >= b faellt weg.
					  P.Serf
	Version  3      13.09.1989      fuer a<b : pu und pv vertauscht
                                          J.Schmitt
   DATE segcd         : 890501.891101
H*/                                                  


# include <_arith1.h>

single segcd ( a,b, pu,pv )               /* safe */
single a,b, *pu,*pv;
{
	single  c, q, u,u1,u2, v,v1,v2, ent;
	ent=0;
	u = v1 = 1;
	v = u1 = 0;
	if ( a < b ) {
		c = a; a = b; b = c; ent=1;
	}
	while ( b ) {
		q = a/b;  c = a%b;
		a=b, b=c;
		u2 = u-q*u1;  u=u1, u1=u2;
		v2 = v-q*v1;  v=v1, v1=v2;
	} 
        if (ent==0) {
		*pu = u;
		*pv = v;
	}
	else {
		*pu = v;
		*pv = u;
	}
	return( a );
}
