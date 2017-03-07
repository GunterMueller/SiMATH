/*M
.SH NAME
misqrtas - modular integer square root all solutions

.SH SYNOPSIS
.nf
#include<_arith2.h>

list misqrtas (N, r)  
list N; 
int r;
 
.SH DESCRIPTION
.TP 4
.B N
is a list, containing the factorization of an integer number (say n), n > 1, i.e. for N = (p_1 e_1 ... p_k e_k), n is equal to p_1^e_1 * ... * p_k^e_k (see e.g. ifact or ifel).
.TP 4
.B r
is an element in Z/nZ.
.PP
misqrtas returns a list, say X, containing all solutions of the congruence
.IP
x^2 = r mod n.
.PP
X is not sorted.

.SH SEE ALSO
 ifact
 ifel

M*/
                           
/*H
	Version 1	01.10.1991	Georg Lay
   DATE misqrtas      : 920331
H*/



#include <_arith2.h>

list misqrtas (N,u)
list N;
int  u;
 {
 list  l,lh;
 int   p,n,ex,p_ex,uh;

 bind (N,u);
 init (l,lh);
 init (p,n,ex,p_ex,uh);

 for (l = N; l != _0; l = lred2 (l))
   {
   p = lfirst (l);
   uh = mihom (p,u);

   if (p != 2 && uh != 0)
     if (ijacsym (u,p) < 0)	return (_0);
   }

 p  = lfirst  (N);
 ex = lsecond (N);
 n  = iexp (p,ex);
 uh = mihom (n,u);

 l = mppsqrt (p,ex,uh,0,0);
 if (l == _0)			return (_0);

 for (N = lred2 (N); N != _0; N = lred2 (N))
   {
   p  = lfirst  (N);
   ex = lsecond (N);
   p_ex = iexp (p,ex);
   uh = mihom (p_ex,u);

   lh = mppsqrt (p,ex,uh,0,0);
   if (lh == _0)		return (_0);   

   l = milcra (n,p_ex,l,lh);

   n = iprod (n,p_ex);
   }

 return (l);
 }

