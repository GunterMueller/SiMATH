/*M
.SH NAME
ipprimeconstr - integer pseudo prime construction

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ipprimeconstr(bits,f,pL,n)
single bits,(*f)(), n;
list *pL;

.SH DESCRIPTION
ipprimeconstr() returns a pseudo prime number p > 2^bits 
and computes the ascendingly sorted list *pL of
prime factors of p-1 such that for
.nf
n = 2: p-1 has two prime factors around sqrt(p)
n = 1: p-1 has one prime factor around p
n = 0: p-1 has only prime factors < M and p < M*2^bits
       with M = min{1000, (max(f)+1)-th prime number}
.PP
.TP 4
.B bits
>= 0 is the number of bits to use at least.
.TP 4
.B f
is a function without arguments that returns a positive
single value. It is useful to choose a (pseudo) random
function such as f() = rand().
M*/
/*H
	Version 1	10.03.1997	S. Schmitt
   DATE ipprimeconstr  : 970315
H*/

#include <_arith1.h>

static int irpprimesf (int , int(), list*);

int ipprimeconstr (p,f,pL,way)
int 	          p,(*f)(),way;
list		     *pL;
 {
	single k, s=0;
 	int   j,u,v,i,l,ll,L,LL;
 	bind (*pL);
 	init (j,u,v,i,l,ll,L,LL);

 if (way == 0)	return (irpprimesf (p,f,pL));

 do
 {	if (way == 2)
    	{	u = irpprimesf (p/2+1,f,&DUM);
    		v = irpprimesf (p/2+1,f,&DUM);
    		l  = iprod (u,v);
    		ll = list2 (u,v);
    	}

  	if (way == 1)
    	{	l = irpprimesf (p,f,&DUM);
    		ll = list1 (l);
    	}

  	for (j = 2; j<200; j += 2)
    	{	L  = iprod  (j,l);
    		LL = lcopy (ll);
    		LL = lcconc (LL,ifact(j));

    		i = isum (L,1);
		k=10;
		while(k-- && (s = isipprime(i, f() % 1000 + 2)));
    		if (s == 1)
      		{	libsort (LL);
      			*pL = LL;
      			return (i);
      		}
    	}
 }
 while (llength(_0) == 0);
 }




/*c
			irpprimesf ( bits, f, pL )

	"integer random pseudo prime, p-1 has small factors"
	Quellbibliothek: srclib.arith1
	Include-Datei:   _arith1.h
	int irandprimesf (bits,f,pL)  single bits, (*f)(), list *pL;
	p = irandprimesf (bits,f,pL);
	bits ist >= 0.
	f ist eine parameterlose Funktion mit Werten in N.
	Sinnvoll ist die Wahl einer (Pseudo-) Zufallsfunktion fuer f,
	etwa f = rand.
	Es gilt:
	- p ist Pseudo-Primzahl
	- p > 2^bits
	- p < M * 2^bits
	- p-1 hat nur Primfaktoren <= M
	- *pL ist aufsteigend geordnete Liste der Primfaktoren von p-1.
	Dabei ist M = Min{ 1000, (Max(f)+1)-te Primzahl }.
c*/
/*H
	Version 1	10.03.1997	S. Schmitt
   DATE irandprimesf  : 930115
H*/


static
int irpprimesf (p,f,pL)
int  p,(*f)();
list *pL;
{	single k,s=0;
 	int   i,l;
 	bind (p,*pL);
 	init (i,l);

 	p = iexp (2,p);

	while(!s)
  	{	*pL = list1 (l = 2);
  		while (icomp (l,p) < 0)  
    		{	*pL = lcomp (i = LIST_SP[f() % 168],*pL);
    			l = iprod (l,i); 
    		}
  		libsort (*pL);
  		i = isum (l,1);
		k=10;
		while(k-- && (s = isipprime(i, f() % 1000 + 2)));
	}
 
 	return (i);
 }

