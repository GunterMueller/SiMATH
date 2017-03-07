/*M
.SH NAME
miord - modular integer, multiplicative order

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miord(n,a,f_n,f_phi)
int n,a;
list *p_n,*f_phi;

.SH DESCRIPTION
miord() returns the order ord_a of a in the multiplicative
group (Z/nZ)* for n >0. The value ord_a = 0 indicates that
a is not member of (Z/nZ)*, i.e. gcd(a,n) >1. If the
factorization of the value n is known, it may by given
as the additional argument *f_n. If it is not known, *f_n
is the empty list. The same holds for the factorization
of the value of the Euler function phi(n) and *f_phi.
The factorizations must be represented using the ifact() format.
User defined (i.e. non empty) arguments *f_n and *f_phi
will not be tested for correctness.
M*/
/*H
	Version 1       13.1.1994		Georg J. Lay
   DATE miord         : 941201
H*/

# include <_arith1.h>

int miord (n,a,f_n,f_phi)
int n,a;
list *f_n,*f_phi;
 {
 int A,i,phi,ord_a;
 list L;

 bind (n,a);
 init (A,phi,ord_a,L);

 a = mihom (n,a);
 if (a == 0)		return (0);
 if (igcd (a,n) != 1)	return (0);

 if (*f_phi == _0)			/* bestimmt die Faktorisierung von phi(n)	*/
   {
   if (*f_n == _0) *f_n = ifact (n);	/* "    "        "         "   n		*/

   for (L = *f_n; L != _0; )
      {
      A = lfirst(L);
      i = 0;
      while ( L != _0 && A == lfirst (L) ) 	L = lred(L), i++;

      for ( ; i>1 ;i--)	*f_phi = lcomp (A,*f_phi);

      A = idif (A,1);
      A = ifact (A);
      *f_phi = lconc (*f_phi,A);
      }
   libsort (*f_phi);
   }
 
 for (phi = 1, L = *f_phi; L != _0; L = lred (L))
   phi = iprod (phi,lfirst (L));	/* rekonstruiert phi(n)				*/

 ord_a = 1;				/* die Ordnung von a in (Z/nZ)^*		*/
 for (L = ifel (*f_phi); L != _0; L = lred2 (L))
   {
   A = iexp (lfirst (L),lsecond (L));
   A = iquot (phi,A);			/* teilt phi durch jeweilige Primpotenz		*/

   for (i = 1; i <= lsecond (L); i++)
     {
     if (miexp (n,a,A) == 1)	break;
     A = iprod (A,lfirst (L));
     ord_a = iprod (ord_a,lfirst (L));
     }
   }

 return (ord_a);
 }
