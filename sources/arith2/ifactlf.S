/*M
.SH NAME
ifactlf - integer factorization large factor

.SH SYNOPSIS
.nf
#include<_arith2.h>

list ifactlf(n, G, p, quot)  
int n, G; 
single p, quot;

.SH DESCRIPTION
.TP 4
.B n
is a positive integer number.
.TP 4
.B G
is a positive integer number, G <= n.
.TP 4
.B p
is a positive integer number, p < 100
(For the usage of the parameters G and p s. irds).
.TP 4
.B quot
is a positive single (default quot = 1).
.PP
ifactlf returns a list, say L, containing all prime factors (with multiplicity) of n, or being the empty list.
.PP
ifactlf should be used when n has one large factor or only small factors.
If n has a large factor, say q, and is n/q < quot, then ifactlf returns L = ().
 
.SH SEE ALSO
irds

M*/
                                            
/*H
	Version 1	16.01.1993	Georg Lay
   DATE ifactlf       : 930531
H*/

#include <_arith2.h>

list ifactlf (n,max_fakt,prozent,quot)
int           n,max_fakt,prozent,quot;
 {
 list  L,L1,h,n0;
 init (L,L1,h,n0);

 L = ispd (n,&n0);				/* sammelt Faktoren < 1000	*/

 if (n0 != 1)
   {
   L1 = irds (n0,max_fakt,prozent);		/* sucht kleine Faktoren mit	*/
   L = lconc (L,L1);				/* Pollards rho			*/
   libsort (L);
   L = linv (L);

   n0 = lfirst(L);				/* verbleibender Rest		*/
   if (iquot (n,n0) < quot)			return (_0);
   L = lred (L);

   if (L == _0)					return (_0);
   if (isiprime(n0) != 1)			return (_0);	/* Rest prim ?	*/

   for (L1 = _0; L != _0; L = lred (L))
     {
     h = ifact (lfirst (L));			/* kleine Faktoren auseinander-	*/
     L1 = lconc (L1,h);				/* nehmen			*/
     }

   L = lcomp (n0,L1);
   }

 return (L);
 }


