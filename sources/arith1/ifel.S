/*M
.SH NAME
ifel - integer factor exponent list

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ifel(LP)
list LP;

.SH DESCRIPTION
ifel() analyses the prime factorization LP
of an integer as an ascendingly sorted list
and returns a descendingly sorted list
L = ( p1, e1, ..., pk, ek ) of the prime factors
and their exponents.

.SH SEE ALSO
sfel
M*/
/*H
	Version 1       28.07.1988      Christine Hollinger
	Version 2       21.11.1991      neu geschrieben.  GL
   DATE ifel          : 890501.911215.9301__
H*/


#include<_arith1.h>

list ifel (LP)
list LP;
 {
 single e;
 list  L;
 int   p,p_alt;

 bind (LP);
 init (L);
 init (p,p_alt);

 if (LP == _0)	return (_0);

 e = 0;

 p_alt = lfirst (LP);

 for (L = _0; LP != _0; LP = lred (LP))
   {
   if (icomp ((p = lfirst (LP)), p_alt))
     {
     L = lcomp2 (p_alt,e,L);
     e = 0;
     }

   e++;
   p_alt = p;
   }

 return (lcomp2 (p,e,L));
 }
