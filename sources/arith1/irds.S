/*M
.SH NAME
irds - integer random divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

list irds(n,G,p)
int n;
single G,p;

.SH DESCRIPTION
irds() returns a list N = ( n1 , n2 , ... , nk ) with n = n1 * n2 *...* nk.
The factors ni of n are found using Pollard's rho-method.
In general, the ni are neither prime nor ordered.
The probability of finding a factor around G is p percent.
irds() is useful for finding small factors of n
since for the runtime T the following holds:
.PP
    T ~ log (n) , T^2 ~ G, T^2 ~ -log (1-p/100)
.PP
.TP 4
.B n
>0 is the number to be factorised.
.TP 4
.B G
with 0 < G <= n is the factor limit. It is useful to keep G << sqrt(n)
.TP 4
.B p
with 0 < p < 100 is the percentage limit.
M*/
/*H
	Version 1	26.08.1991	Georg Lay
	Version 2	09.05.1993	irdsrec als static	GL
   DATE irds          : 920331.930531
H*/

#include <_arith1.h>

static list irdsrec (int,int,int);

list irds (n,g,p)
int n;
int g,p;
 {
 single steps;

 steps  = (single) sqrt ((double) g) * sqrt (-32.0 * log (1.0 - ((double) p)/100.0));

 return (irdsrec (n,g,steps));
 }

static
list irdsrec (n,g,st)
int n,g,st;
 {
 int  d,t;
 list l,h;

 bind (n,g,st);
 init (d,t,l,h);

 if (icomp (n,g) < 0)             return (list1 (n));

 d = rhopds (n,random() & 255,st);

 if (d == 1 || icomp (d,n) == 0)  return (list1 (n));
 else
   {
   t = iquot (n,d);

   return (lcconc (l = irdsrec (d,g,st),h = irdsrec (t,g,st)));
   }
 }
