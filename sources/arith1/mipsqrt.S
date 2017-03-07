/*M
.SH NAME
mipsqrt - modular integer prime square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

int mipsqrt(p,r)
int p,r;

.SH DESCRIPTION
mipsqrt() tries to solve the quadratic equation
.TP 8
.PP
    w*w = r mod p.
.PP
and returns either a solution w or -1 if there
is no solution in Z/pZ. Here p >1 should be prime.
If this is not the case, two results may occur:
.PP
1. This is recognised and mipsqrt() returns -2
   (which is mot probable case), or
.PP
2. this is not recognised and mipsqrt() behaves
   as described above.
M*/
/*H
	Version 1	16.09.1991	Georg Lay
	Version 2	16.01.1993	Module sind static	GL
   DATE mipsqrt       : 920331.930531
H*/

#include <_arith1.h>

static int lucas (int,int,int,int);

list mipsqrt (p,r)
int           p,r;
 {
 single p_mod_4;
 int   ex,w1,w2,i,j,P,n;

 bind (p,r);
 init (ex,w1,w2,i,j,P,n);

 if (r == 0) 			return (0);

 if (p == 2) 			return (r);

 if (iodd (p) == 0) 		return (-2);

 w1 = ipjacsym (r,p);
 if (w1 == -2)	 		return (-2);
 if (w1 == -1)    		return (-1);	/* r ist kein Quadrat mod p	*/

 p_mod_4 = mshom (4,p);

 if (p_mod_4 == 3)
   {
   ex = isum  (p,1);
   ex = iquot (ex,4);
   w1 = miexp (p,r,ex);
   }

 if (p_mod_4 == 1)
   {
   do
     {
     P = irand (p);

     i = miprod (p,P,P);
     j = miprod (p,4,r);
     i = midif  (p,i,j);

     i = ipjacsym (i,p);
     if (i == -2) 		return (-2);
     }
   while (i != -1);				/* (P^2 - 4*r | p ) muss -1 sein*/

   n = idif  (p,1);
   n = iquot (n,4);

   w1 = lucas (p,n,r,P);
   }
 if (w1 == -2) 			return (-2);

 w2 = miprod (p,w1,w1);
 if (icomp (r,w2) != 0)		return (-2);

 return (w1);
 }


static
int lucas (p,n,r,P)
int        p,n,r,P;
 {
 single *bit,i;

 int   w1,w2,ir,W1,A,B;
 init (w1,w2,ir,W1,A,B);
 bind (n);

 w1 = miprod (p,P,P);
 ir = miinv  (p,r);
 if (ir == 0) return (-2);

 w1 = miprod (p,w1,ir);
 w1 = midif  (p,w1,2);				/* w1 = P^2 / r - 2		*/

 w2 = miprod (p,w1,w1);
 w2 = midif  (p,w2,2);				/* w2 = w1^2 - 2		*/

 bit = (single*) calloc (1 + ilog2 (n),sizeof (single));
 if (bit == NULL) exit(1);

 for (i = 0; n != 0; i++)
   {
   *(bit++) = iodd (n);
   n = iquot (n,2);
   }

 W1 = w1;

 for (--bit; i>1; i--)
   {
   A = w1;
   B = w2;

   if (*(--bit) == 0)
     {
     w1 = miprod (p,A,A);
     w1 = midif  (p,w1,2);			/* w1 = A*A - 2			*/

     w2 = miprod (p,A,B);
     w2 = midif  (p,w2,W1);			/* w2 = A*B - W1		*/
     }
   else
     {
     w1 = miprod (p,A,B);
     w1 = midif  (p,w1,W1);			/* w1 = A*B - W1		*/

     w2 = miprod (p,B,B);
     w2 = midif  (p,w2,2);			/* w2 = B*B - 2			*/
     }
   }
						/* Nun ist w1 = w_n		*/
						/* und     w2 = w_n+1		*/
 A = misum  (p,P,P);
 A = miinv  (p,A);      if (A == 0) return (-2);
 B = miprod (p,A,r);
 A = misum  (p,w1,w2);
 A = miprod (p,A,B);				/* A = r*(w1+w2)/(2*P)		*/
						/* denn es ist r = +- r^(n+1)	*/
 return (A);
 }
