/*M
.SH NAME
spartition - single partition numbers and power series expansion of 1/(Prod (1-q^n))

.SH SYNOPSIS
.nf
#include<_arith1.h>

list spartition(n)
single n;

.SH DESCRIPTION
spartition() returns a list L = (1, 2, 3, 5, 7, ..., p_n)
= (p_1, p_2, ..., p_n) of the first n partition numbers,
i.e. pi_i is the number of essentially different
representations of i as the sum of natural numbers.
.PP
1. The n-th partition number can be obtained by p_n = lelt(spartition(n), n);
.PP
2. Besides (p_0, p_1, p_2, ...) represents the expansion 
of 1/(Prod (1-q^n)) into a power series if p_0 is considered 1.
M*/
/*H
	Version 1	01.11.1993	Georg J. Lay
   DATE	spartition    : 941201
H*/

#include <_arith1.h>

static list partition (int);	

list spartition (n)
single n;
 {
 list  L,l,part,p;
 int   k,p_neu;

 init (L,part);
 init (k,p_neu);

 L = partition (n);

 /* the coefficients of the q-expansion of 	*/
 /* \prod_1^\infty (1-q^n)^{-1}			*/
 /* are just the partition numbers p_i		*/

 part = list1 (1);

 for (k = 1; k<=n; k++)
   {
   p_neu = 0;

   for (p = part, l = L; p != _0; p = lred (p), l = lred (l))
     {
     if (lfirst (l) ==  1) p_neu = isum (p_neu,lfirst(p));
     if (lfirst (l) == -1) p_neu = idif (p_neu,lfirst(p));
     }
   part = lcomp (p_neu,part);
   }
 part = linv (part);
 part = lred (part);		/* discards p_0 = 1				*/

 return (part);
 }

static
list partition (n0)	
int n0;
	/* determine the first n0 coefficients of the				*/
	/* q-expansion of							*/
	/* 1 - \prod_1^\infty	(1-q^n)						*/
	/* all will be in {-1,0,1}						*/
	/* using \prod_{n \in N} (1-q^n) = \sum_{n \in Z} (-1)^n q^{(3n^2+n)/2}	*/
 {
 int e,n; 
 list  lexp,lret;
 init (lexp,lret);

 lexp = _0;
 for (n = 1; ; n++)
   {
   e = (3*n*n-n)/2;
   if (e > n0)	break;
   lexp = lcomp ((n % 2 == 0) ? e : -e, lexp);

   e += n;
   if (e > n0)	break;
   lexp = lcomp ((n % 2 == 0) ? e : -e, lexp);
   }

 lret = _0;
 lexp = linv (lexp);

 for (n = 1; n<=n0; n++)
  if (lexp != _0)
    if (abs (lfirst (lexp)) == n)
      {
      lret = lcomp ((lfirst (lexp) > 0) ? -1 : 1, lret);
      lexp = lred (lexp);
      }
    else   lret = lcomp (0,lret);
  else   lret = lcomp (0,lret);

 lret = linv (lret);

 return (lret);
 }

