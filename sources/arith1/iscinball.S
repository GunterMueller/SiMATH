/*M
.SH NAME
iscinball - is complex number in ball ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single iscinball(z,m,r)
complex z,m;
floating r;

.SH DESCRIPTION
iscinball() returns s = sign (r - |z - m|), i.e. for
.nf
s = +1: the complex number z lies in  
s =  0: the complex number z lies on the boundary of  
s = -1: the complex number z does not lie in  
the ball around m with radius r.
M*/
/*H
        Version 1       16.01.1993      Georg Lay
	Version 2	13.10.1993	CISINBALL -> ISCINBALL.  PS
   DATE iscinball     : 930531.931130
H*/

#include <_arith1.h>

complex iscinball (z,r,eps)
complex z,r;
floating eps;
 {
 floating zr,zi;
 bind    (z,eps);
 init    (zr,zi);

 z  = cdif (z,r);
 zr = creal (z);
 zi = cimag (z);
 
 zr = flprod (zr,zr);
 zi = flprod (zi,zi);
 zr = flsum (zr,zi);

 eps = flprod (eps,eps);

 return (flcomp (eps,zr));
 }

