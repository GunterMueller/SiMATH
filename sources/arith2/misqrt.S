/*M
.SH NAME
misqrt - modular integer square root

.SH SYNOPSIS
.nf
#include<_arith2.h>

int misqrt (m, a)  
int m, a;
 
.SH DESCRIPTION
.TP 4
.B m,a
are integer numbers.
.PP
misqrt returns a root of the congruence
.IP
x^2 - a = 0 mod m,
.PP
provided that such a root exists. If no such root exists, misqrt returns -1.

.SH NOTES
For m being a prime number, please use the faster function mpsqrt.

.SH SEE ALSO
mpsqrt

M*/
                
/*H
	Version 1       11.04.1991      Michael Pfeifer
	Version 2	03.12.1992	beschleunigt und dann
					von 'arith1 nach 'arith2 
					(wegen misqrtas). altes 
					misqrt jetzt misqrtsrch.  GL
   DATE misqrt        : 910715.930115
H*/

#include<_arith2.h>

int misqrt (m,a)
int         m,a;
 {
 list fel;

 bind (m,a);
 init (fel);

 a = mihom (m,a);
 if (a == 0)		return (0);

 fel = ifact (m);

 if (lfirst (fel) <= 0)	return (misqrtsrch (m,a));

 fel = ifel (fel);
 fel = misqrtas (fel,a);

 return ((fel == _0) ? (-1) : lfirst (fel));
 }
