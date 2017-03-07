/*M
.SH NAME
iprimeconstr - integer prime construction

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iprimeconstr(bits,f,pL,n)
single bits,(*f)(), n;
list *pL;

.SH DESCRIPTION
iprimeconstr() returns a prime number p > 2^bits 
and computes the ascendingly sorted list *lP of
prime factors of p-1 such that for
.nf
n = 2: p-1 has two prime factors around sqrt(p)
n = 1: p-1 has one prime factor arourd p
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
	Version 1	16.01.1993	Georg Lay
	Version 2	10.05.1993	Zahlreiche Verbesserungen.  GL
	Version 3	18.10.1993	while(0==0) -> while(llength(_0)==0). PS
   DATE iprimeconstr  : 930115.930531.931130
H*/

#include <_arith1.h>

static
int irandprimesf (int,int(),list*);

int iprimeconstr (p,f,pL,way)
int 	          p,(*f)(),way;
list		     *pL;
 {
 int   j,u,v,i,l,ll,L,LL;
 bind (*pL);
 init (j,u,v,i,l,ll,L,LL);

 if (way == 0)	return (irandprimesf (p,f,pL));

 do
  {
  if (way == 2)
    {
    u = irandprimesf (p/2+1,f,&DUM);
    v = irandprimesf (p/2+1,f,&DUM);
    l  = iprod (u,v);
    ll = list2 (u,v);
    }

  if (way == 1)
    {
    l = irandprimesf (p,f,&DUM);
    ll = list1 (l);
    }

  for (j = 2; j<200; j += 2)
    {
    L  = iprod  (j,l);
    LL = lcopy (ll);
    LL = lcconc (LL,ifact(j));

    i = isum (L,1);
    if (iftpt (i,LL,1000) == 1)
      {
      libsort (LL);
      *pL = LL;
      return (i);
      }
    }
  }
 while (llength(_0) == 0);
 }




/*c
			irandprimesf ( bits, f, pL )

	"integer random prime, p-1 has small factors"
	Quellbibliothek: srclib.arith1
	Include-Datei:   _arith1.h
	int irandprimesf (bits,f,pL)  single bits, (*f)(), list *pL;
	p = irandprimesf (bits,f,pL);
	bits ist >= 0.
	f ist eine parameterlose Funktion mit Werten in N.
	Sinnvoll ist die Wahl einer (Pseudo-) Zufallsfunktion fuer f,
	etwa f = rand.
	Es gilt:
	- p ist Primzahl
	- p > 2^bits
	- p < M * 2^bits
	- p-1 hat nur Primfaktoren <= M
	- *pL ist aufsteigend geordnete Liste der Primfaktoren von p-1.
	Dabei ist M = Min{ 1000, (Max(f)+1)-te Primzahl }.
c*/
/*H
	Version 1	02.12.1992	Georg Lay
   DATE irandprimesf  : 930115
H*/


static
int irandprimesf (p,f,pL)
int 	          p,(*f)();
list		     *pL;
 {
 int   i,l,erg;
 bind (p,*pL);
 init (i,l);

 p = iexp (2,p);

 do
  {
  *pL = list1 (l = 2);

  while (icomp (l,p) < 0)  
    {
    *pL = lcomp (i = LIST_SP[((unsigned long)(f())) % 168],*pL);
    l = iprod (l,i); 
    }

  libsort (*pL);
  i = isum (l,1);

  }

 while (iftpt (i,*pL,1000) != 1);
 
 return (i);
 }

