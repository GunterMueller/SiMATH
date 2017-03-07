/*M
.SH NAME
ipprniqf - integer prime power representation as a norm in an imaginary quadratic field

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ipprniqf(p,n,D)
int p;
single D;

.SH DESCRIPTION
ipprniqf() tries to represent p^n as the norm of an element
pi from the integrity ring O(K), i.e. p^n = Norm_K (pi) 
and returns a list Pi = (pi1,pi2,...) of the solutions found.
An element pi from O(K) has the form pi = (A, B) = A + B*w
with w = sqrt(-d) /2, if 4|D and w = (1+sqrt(-d))/2 otherwise.
The solutions pi are primitive, i.e. are not factors of gcd(A, B).
.PP
.TP 4
.B p
>=2, must be prime.
.TP 4
.B D
<0 is the discriminate of the imaginary quadratic field K = Q(sqrt(-d)).
.TP 4
.B d
>0 is square-free.
M*/
/*H
	Version 1	16.1.1993	Georg Lay
   DATE iprniqf       : 941201
H*/

#include <_arith1.h>

static int norm (int, list, list);
static list pimul1 (single, list);
static int cornaccia_sp (int,int,int,int*,int*,int);
static single disctofdisc (single);

list ipprniqf (p,n,D)
int	       p,n,D;
 {
 int   dm,pi,p4,p2,A,B,l,L,p_n,erg;
 init (dm,pi,p4,p2,A,B,l,L,p_n);

 D = -D;				/* D > 0		*/

 p_n = iexp (p,n);
 p2 = isum (p_n,p_n);
 p4 = isum (p2,p2);

 if (icomp (p4,D) <= 0)				return (_0);

 if (p == 2)
   {
   if (D % 8 != 7)				return (_0);

   dm = mihom (p4,-D);
   dm = mppsqrt (p,n+2,dm,0,0);
   if (dm == _0)			return (_0);

   libsort (dm);

   erg = cornaccia_sp (p4,D,lfirst (dm),&A,&B,p4);
   if (erg != 0)
     erg = cornaccia_sp (p4,D,lsecond (dm),&A,&B,p4);
   if (erg != 0)			return (_0);

   A = idif  (A,B);
   A = iquot (A,2);
   }
 else						/* p != 2		*/
   {
   switch (D % 8)
     {
     case 7:

       dm = mihom (p_n,-D);

       dm = mppsqrt (p,n,dm,0,0);
       if (dm == _0)			return (_0);

       dm = cornaccia_sp (p_n,D,lfirst (dm),&A,&B,p_n);
       if (dm != 0)				return (_0);
    printf ("A = %i B = %i\n",A,B);
       A = idif (A,B);
       B = isum (B,B);
       break;

     case 0:
     case 4:

       dm = mineg   (p,D/4);
       dm = mipsqrt (p,dm);

       dm = cornaccia_sp (p,D/4,dm,&A,&B,p);
       if (dm != 0)				return (_0);
       break;

     case 3:

       dm = mihom (p_n,-D);
       dm = mppsqrt (p,n,dm,0,0);
       if (dm == _0)			return (_0);

       dm = lfirst (dm);

       A = (1+3*mshom (4,p_n)*mshom (4,dm)) % 4;
       A =  iprod (A,p_n);
       dm = isum (dm,A);

       p2 = isum (p_n,p_n);
       p4 = isum (p2,p2);
       dm = cornaccia_sp (p4,D,dm,&A,&B,p2);
       if (dm != 0)				return (_0);
       A = idif (A,B);
       A = iquot (A,2);
       break;

     default:				return (_0);
     }
   }

 pi = list2 (A,B);

 L = list1 (pi);

 switch (D) 
   {
 case 3:
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
/*** Norm von pi + k								*/
/********************************************************************************/

static
int norm (D,pi,k)
int D;
list pi,k;
 {
 int   N,X,Y;
 init (N,X,Y);

 X = lfirst  (pi);
 X = isum (X,k);
 Y = lsecond (pi);

 if (D % 4 == 0)
   {
   X = iprod (X,X);
   Y = iprod (Y,Y);
   Y = iprod (D,Y);
   }
 else
   {
   N = isum (X,Y);
   X = iprod (X,N);
   Y = iprod (Y,Y);
   Y = iprod (1+D,Y);
   }

 Y = iquot (Y,4);
 
 return (isum (X,Y));
 }


/********************************************************************************/
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

/* printf ("%i = X^2 + %i* Y^2 ?\n",m,q);*/

 q1 = iquot (m,2);

 if (icomp (q1,x0) >= 0) x0 = mineg (m,x0);	/* m/2 < x0 < m			*/

 x3   = x0;
 x2   = mm;
 x1_2 = iprod (x0,x0);

 for ( ; ; )
   {
   x1 = x2;
   x2 = x3;

   if (x2 == 0)
     x3 = x1;
   else
     iqrem (x1,x2,&q1,&x3);

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


static
single disctofdisc (d)                          /* Macht aus d eine            \ */
single              d;                          /* Fundamentaldiskriminante D  \ */
 {
 single D;
 list  L;
 init (L);

 D = 1;
 if (d != 1)
   {
   L = ifact (d);

   for (L = ifel (L); L != _0; L = lred2 (L))
     D *= iexp (lfirst (L),lsecond(L) % 2);
   }

 return ((D % 4 == 3) ? D : 4*D);
 }
