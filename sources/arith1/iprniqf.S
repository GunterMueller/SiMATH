/*M
.SH NAME
iprniqf - integer prime representation as a norm in an imaginary quadratic field

.SH SYNOPSIS
.nf
#include<_arith1.h>

list iprniqf(p,D)
int p,D;

.SH DESCRIPTION
iprniqf() tries to represent p^n as the norm of an element
pi from the integrity ring O(K), i.e. p^n = Norm_K (pi) 
and returns a list Pi = (pi1,pi2,...) of the solutions found
(except for conjugate complex solutions).
An element pi from O(K) has the form pi = (A, B) = A + B*w
with w = sqrt(-d) /2, if D = 0 mod 4
and  w = (1+sqrt(-d))/2, if D = 1 mod 4.
If p is not prime, then the special return code 0 will appear.

.PP
.TP 4
.B p
>=2, should be prime.
.TP 4
.B D
<0 is the discriminate of the imaginary quadratic field K = Q(sqrt(-d)).
M*/

/*H
	Version 1	16.01.1993	Georg Lay
	Version 2	01.06.1993	Fehler in der Dokumentation.  GL
	Version	3	29.10.1993	D nicht mehr single sondern int.  GL
   DATE iprniqf       : 930531.9305__.931130
H*/

#include <_arith1.h>

static list pimul1 (single, list);
static int cornaccia_sp (int,int,int,int*,int*,int);

list iprniqf (p,D)
int	      p,D;
 {
 int   dm,pi,p4,p2,A,B,l,L,D4;

 bind (p,D);
 init (dm,pi,p4,p2,A,B,l,L,D4);

 D = ineg (D);

 switch (mshom (8,D))
 {
 case 7:

   dm = ineg  (D);
   dm = mihom (p,dm);
   dm = mipsqrt(p,dm);
   if (dm == -2)			return (0);

   dm = cornaccia_sp (p,D,dm,&A,&B,p);
   A = idif (A,B);
   B = isum (B,B);
   break;

 case 0:
 case 4:

   dm = isquot (D,-4);
   dm = mihom   (p,dm);
   dm = mipsqrt (p,dm);
   if (dm == -2)			return (0);

   D4 = isquot (D,4);
   dm = cornaccia_sp (p,D4,dm,&A,&B,p);
   break;

 case 3:

   dm = ineg (D);
   dm = mihom  (p,dm);
   dm = mipsqrt (p,dm);
   if (dm == -2)			return (0);

   A = (1+3*mshom (4,p)*mshom (4,dm)) % 4;
   A =  iprod (A,p);
   dm = isum (dm,A);

   p2 = isum (p,p);
   p4 = isum (p2,p2);
   dm = cornaccia_sp (p4,D,dm,&A,&B,p2);
   A = idif (A,B);
   A = iquot (A,2);
   break;

 default:				return (_0);
 }

 if (dm != 0)				return (_0);

 pi = list2 (A,B);

 L = list1 (pi);

 switch (D) 					/* Anzahl der Loesungen ist	*/
   {						/* abhaengig von Anzahl der	*/
 case 3:					/* Einheiten in O_K		*/
   pi = pimul1 (3,pi);	L = lcomp (pi,L);
   pi = pimul1 (3,pi);	L = lcomp (pi,L);
   break;       
 case 4:
   pi = pimul1 (4,pi);	L = lcomp (pi,L);
   break;
   }

 for (l = L; l != _0; l = lred (l))
   {
   pi = pimul1 (2,lfirst (l));
   L  = lcomp (pi,L);
   }       
 return (L);
 }

/********************************************************************************/
/* Multipliziert pi mit primitiver r. Einheitswurzel				*/
/********************************************************************************/

static
list pimul1 (r,pi)
single r;
list pi;
 {
 int   A,B;
 init (A,B);

 A = lfirst (pi);
 B = lsecond(pi);

 switch (r)
 {
 case 2:
   A = ineg (A);
   B = ineg (B);
   pi = list2 (A,B);
   break;

 case 3:
   B = isum (A,B);
   B = ineg (B);
   pi = list2 (B,A);
   break;

 case 4:
   B = ineg (B);
   pi = list2 (B,A);
   break;
 }
 
 return (pi);
 }


/********************************************************************************/
/*** Vergleiche cornaccia (m,q,x0,pX,pY)					*/
/********************************************************************************/

static
int cornaccia_sp (m,q,x0, pX, pY,mm)
int	          m,q,x0,*pX,*pY,mm;
 {
 int   q1,x1,x2,x3,x0_2,x1_2;
 init (q1,x1,x2,x3,x0_2,x1_2);

 q1 = iquot (m,2);

 if (icomp (q1,x0) >= 0) x0 = mineg (m,x0);	/* m/2 < x0 < m			*/

 x3   = x0;
 x2   = mm;
 x1_2 = iprod (x0,x0);

 for ( ; ; )
   {
   x1 = x2;
   x2 = x3;

   if (x2 == 0)	x3 = x1;
   else		iqrem (x1,x2,&q1,&x3);

   x1_2 = iprod (x1,x1);

   if (icomp (x1_2,m) < 0)	break;
   }

 *pX = x1;
 
 x2 = idif  (m,x1_2);
 x2 = iquot (x2,q);
 *pY = isqrt (x2);

 x2 = iprod (*pY,*pY);
 x2 = iprod (q,x2);
 x2 = isum (x1_2,x2);				/* x2 = X^2 + q*Y^2		*/

 return (icomp (x2,m));
 }
