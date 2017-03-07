/*M
.SH NAME
csexp - complex single exponentiation

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex csexp (v,n)
complex v;
single n;


.SH DESCRIPTION
For n >=0 csexp() returns the n-th power z = v^n of the complex number v.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE csexp         : 930531
H*/

#include <_arith1.h>

complex csexp (q,n)
complex        q;
single 	       n;
 {
 complex q_n;
 list bit;
 bind(q,n); 
 init (q_n);
 init (bit);

 q_n = ccri (itofl (1),0);

 if (n == 0)	return (q_n);
 if (n == 1)	return (q);

 q_n = q;

 for (bit = _0; n>0; n>>=1)	bit = lcomp (iodd (n),bit);
 for (bit = lred (bit); bit != _0; bit = lred (bit))
  {    
  q_n = csqr (q_n);
  if (lfirst (bit) == 1)	q_n = cprod (q_n,q);
  }

 return (q_n);
 }
