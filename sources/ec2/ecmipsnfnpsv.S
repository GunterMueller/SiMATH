/*M
.SH NAME
ecmipsnfnpsv - elliptic curve over modular integer primes short normal form number of points special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecmipsnfnpsv (p, a4, a6)  
int p, a4, a6;
  
.SH DESCRIPTION
.TP 4
.B p
is an integer number, g.c.d.(p,6) = 1, p should be a prime.
.TP 4
.B a4, a6
are the coefficients of an elliptic curve, say E, in short Weierstrass normal form over Z/pZ. a4 or a6 had to be zero.
.PP
ecmipsnfnpsv returns the number of rational points on E.
If ecmipsnfnpsv realises that p is not a prime number, it returns -1, if it does not realise that p is not a prime number, the result will be in all probability wrong.

.SH NOTES
The condition a4 or a6 = 0 means: The curve E is non singular and has j-invariant 0 or 1728.

M*/
                                         
/*H
	Version 1	01.05.1992	Georg Lay
   DATE ecmipsnfnpsv  : 921130
H*/

#include <_ec2.h>
 
int ecmipsnfnpsv (p,a4,a6)
int p,a4,a6;
 {
 int   E;

 bind (p,a4,a6);
 init (E);

 E = -1;
 if (a4 == 0) E = psi_3 (p,a6);
 if (a6 == 0) E = phi_2 (p,a4);

 if (E != -1)
   {
   E = isum (E,p);
   E = isum (E,1);
   }

 return (E);
 }



int psi_3 (p,a)
int p,a;
 {
 single a_p;
 int   c,x,y,ex,x0,w,p1;

 bind (a);
 init (c,x,y,ex,x0,w,p1);

 if (mshom (3,p) == 2)					return (0);

 ex = iquot (p1 = isum (p,-1),3);		/* ex = (p-1)/3			*/

 do						/* sucht kubischen Nichtrest	*/
    w = miexp (p,c = irand (p),ex);		/* c mod p			*/
 while (w == 1);

 x0 = misum (p,w,w);
 x0 = misum (p,1,x0);

 x = miprod (p,x0,x0);
 x = idif (x,p);
 if (x != -3)						return (-1);

 c = cornaccia (p,3,x0,&x,&y);			/* loest x^2 + 3*y^2 = p	*/

 if (c) 						return (-1);

 if (mshom (3,x) != 1)
   x = ineg (x);

 a_p = ipjacsym (a,p);

 c = miexp (p,a,ex);

 if (c == 1)
   {
   w = isum (x,x);

   if (a_p ==  1)					return (ineg (w));
   if (a_p == -1)					return (      w );
   							return (-1);
   }
 else
   {
   w = miprod (p,c,y);
   w = misum  (p,w,w);				/* w = 2y* a^(p-1)/3		*/

   x0 = mihom (p,x);
   x0 = midif (p,x0,y);
 
   if (icomp (w,x0) != 0)
     y = ineg (y);

   w = iprod (-3,y);
   w = isum  (x,w );

   if (a_p ==  1)					return (      w );
   if (a_p == -1)					return (ineg (w));
   }							return (-1);   
 }

int phi_2 (p,a)
int p,a;
 {
 int   c,x,y,p1,ex,x0,po;

 bind (a);
 init (c,x,y,p1,ex,x0,po);

 if (mshom (4,p) == 3)					return (0);

 p1 = idif  (p,1);
 ex = iquot (p1,4);				/* ex = (p-1)/4			*/
 po = miexp (p,a,ex);
 
 switch (mshom (24,p))				/* Bestimme quadratischen	*/
   {						/* Nichtrest c mod p		*/
   case  5:{ c = 2; break; }
   case 13:{ c = 2; break; }
   case 21:{ c = 2; break; }

   case 17:{ c = 3; break; }
   case  1:{ c = mipfnsquare (p);
	     if (c == -1)				return (-1);
	     break;
	   }
   default:						return (-1);
   }
 
 x0 = miexp (p,c,ex);				/* x0^2 = -1 mod p		*/

 x = miprod (p,x0,x0);
 x = idif   (x,p);
 if (x != -1)						return (-1);

 c = cornaccia (p,1,x0,&x,&y);			/* loest x^2 + 1*y^2 = p	*/
 if (c) 						return (-1);

 if (iodd (x) == 0)				/* man braucht jedoch eine	*/
   {						/* Loesung von			*/
   c = x; x = y; y = c;				/* x^2 + 4*y^2 = p		*/
   }

 y = iquot (y,2);				/* nun gilt x^2 + 4*y^2 = p	*/

 if (mshom (4,x) != 1)				/* Es muss sein : x % 4 = 1	*/
   x = ineg (x);

 if (po == 1)					/* po = a^ (p-1)/4 mod p	*/
   return (iprod (-2,x));

 if (icomp (po,p1) == 0)
   return (iprod (2,x));

 po = miprod (p,po,y);
 po = misum  (p,po,po);				/* po = 2y*a^(p-1)/4		*/

 x = mihom (p,x);
 if (icomp (po,x) == 0) return (iprod (4,y));
 
 po = mineg (p,po);

 if (icomp (po,x) == 0) return (iprod (-4,y));
							return (-1);
 }
