/*M
.SH NAME
mppsqrt - modular prime power square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

list mppsqrt(p,n,r,xk,k)
int p,r,xk;
single n,k;

.SH DESCRIPTION
mppsqrt() tries to solve the equation
.TP 8
.PP
x*x = r mod p^n
.PP
where
0 <= k < n < BASIS,
p is prime,
r is in  Z/(p^n)Z and
xk is in Z(/p^k)Z and returns the
list of all solutions in Z(/p^n)Z.
To speed up the computation any known
solution xk with xk*xk = r mod p^k may
be given, othwise use k=0.
M*/
/*H
	Version 1	01.10.1991	Georg Lay
	Version 2	16.01.1993	Module sind static	GL
   DATE mppsqrt       : 920331.9211__.930531
H*/


#include <_arith1.h>

static list m2psqrt (int,int);
static list mppsqrtncd (int,int,int,int,int);

list mppsqrt (p,n,u,x0,k)
int p,n,u,x0,k;
 {
 single r;
 int    x,x1,x2,xh,rest,uneu;
 list   l;

 bind (x0);
 init (x,x1,x2,xh,rest,uneu);
 init (l);

 if (p == 2)			return (m2psqrt (n,u));

 if (igcd (p,u) == 1)		return (mppsqrtncd (p,n,u,x0,k));

 else
   {
   if (u == 0)
     {
     x0 = iexp (p,r = (1+n)/2);

     x = iexp (p,n-r);
     x = idif (x,1);

     l = _0;
     for (x = iprod (x,x0); x>=0; x = idif (x,x0))
       l = lcomp (x,l);
     
     return (l);
     }

   else						/* u != 0			*/
     {
     r = 0;
     while (iqrem (u,p,&uneu,&rest),!rest)	/* u = p^r * u' mit (p,u') = 1	*/
        r++,u = uneu;

     if (iodd (r) == 1)		return (_0);

     if (k > n-r)
       {
       x1 = iexp (p,k = n-r);
       x0 = mihom (x1,x0);
       }

     l = mppsqrtncd (p,n-r,u,x0,k);
     if (l == _0)		return (_0);

     x0 = iexp (p,r/2);
     x1 = iprod (x0,lfirst  (l));
     x2 = iprod (x0,lsecond (l));

     x  = idif (x0,1);
     x0 = iexp (p,n-r/2);
     xh = iprod (x,x0);
     x1 = isum (x1,xh);
     x2 = isum (x2,xh);

     for (l = _0; x1 >= 0; x1 = idif (x1,x0),x2 = idif (x2,x0))
       l = lcomp2 (x1,x2,l);

     return (l);
     } 
   }
 }


static
list m2psqrt (n,u)				/* Spezialfall p = 2		*/
int n,u;
 {
 single k;
 list la,ln;
 int   p_k,p_k1,x,x2,uk;

 init (la,ln);
 init (p_k,p_k1,x,x2,uk);

 p_k1 = 2;

 ln = list1 (iodd (u));

 for (k = 2; k <= n; k++)			/* Ergebnis aufbauen, anfangen	*/
   {						/* bei 2^1			*/
   p_k = iprod (2,p_k1);

   uk = mihom (p_k,u);

   la = ln;
   for (ln = _0; la != _0; la = lred (la))
     {
     x = lfirst (la);

     x2 = miprod (p_k,x,x);

     if (icomp (x2,uk) == 0)
       {
       x2 = isum (x,p_k1);
       ln = lcomp2 (x,x2,ln);
       }
     }
   if (ln == _0)		return (ln);

   p_k1 = p_k;
   }

 return (ln);
 }
 

static
list mppsqrtncd (p,n,u,x,k)			/* gcd (u,p) = 1		*/
int p,n,u,x,k;
 {
 int   a,c,p_k,y;

 bind (x);
 init (a,c,p_k,y);
 
 if (k == 0)
   {
   x = mihom   (p,u);
   x = mipsqrt (p,x);
   if (x < 0) return (_0);

   k = 1;
   }

 p_k = iexp (p,k);

 a = isum  (x,x);
 a = mihom (p,a);
 a = miinv (p,a);				/* a = 1/(2x) mod p		*/

 for (; k<n; k++)				/* Loesung rekursiv aufbauen	*/
   {
   c = iprod (x,x);
   c = idif  (u,c);
   c = iquot (c,p_k);				/* c = (u - x^2) / p^k		*/
   c = iprod (c,a);
   c = mihom (p,c);
   c = iprod (c,p_k);

   x = isum (x,c);

   p_k = iprod (p,p_k);
   }

 y = mineg (p_k,x);

 return (list2 (x,y));
 }
