/*M
.SH NAME
ipgen - integer prime generator

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ipgen(u,o)
int u,o;

.SH DESCRIPTION
ipgen() returns the list L = (p1, ... , pr)
of all prime factors u <= p1 < ... < pr <= o.
M*/
/*H
	Version 1       29.05.1991      Ursula Schneiders
	Version 2	01.02.1994	benutze isiprime und iftpt
							Georg J. Lay
	Version 2.1     12.10.1994      Ursula Schneiders (Sonderf. 1,1)
	Version 2.2     17.07.1996      S. Schmitt (Fehler beseitigt)
   DATE ipgen	      : 910715.941201.961201
H*/

#include <_arith1.h>

list ipgen(u,o)
int u, o;
{
	single d[481], i, j;
	int   h, z;
	list  L;
	bind (u, o );
	init (h, z, L );

	/*** single- Grenzen ***/

	if (isatom (o)) {
	        if( u==1 && o==1 ) return( _0 );
	        if (seven (u)  && seven (o))  		o = (o-u)/2;
		else					o = (o-u)/2 + 1;

		return (spgen (u,o));
		}

	/*** Speicherung der Differenzen zweier Zahlen zwischen 13    ***/
	/*** und 2310, die nicht durch 2, 3, 5, 7 und 11 teilbar sind ***/

	j = 0; h = 1;
	for (i = 17; i < 2310; i += 2 ) 
	if ((i%3) && (i%5) && (i%7) && (i%11)) {
		d[j++] = i-h;
		h = i;
		}

	d[j++] = 1;
	d[j]=0;

	/*** Vorrechnung ***/

	z = isquot (u, 2310 );
	z = isprod (z, 2310 );		/** z = k*2310 ist durch 2,3,5,7,11
						teilbar **/
	z = isum(z,1);			/** k*2310+1 koennte Primzahl sein **/
	j = 0;

	/** Die einzigen Zahlen zwischen k*2310 und (k+1)*2310, die Primzahlen
	sein koennen, sind k*2310+x, wobei x eine Zahl 1<=x<2310 ist mit
	2,3,5,7,11 teilen x nicht. Diese erhaelt man alle, indem man
	z=z+1=k*2310+1 setzt und dann immer die obigen Differenzen addiert. 
	Falls o-u>2310, so muss man nachdem alle Differenzen durchgelaufen
	sind, die gleiche Prozedur fuer (k+1)*2310 bis (k+2)*2310 durchfuehren.
	Dazu wird zuerst die Differenz von 2310 und der groessten Zahl <2310,
	die nicht durch 2,3,5,7,11 teilbar ist, addiert. (Das ist die letzte
	Eintragung in d, naemlich 1. Die gesuchte Zahl ist naemlich 2310-1)
	Dann wird wieder 1 addiert und von vorne angefangen. **/

			   

	while (icomp (u,z) == 1) 
	{       z = isum (z, d[j++] );
		if (!d[j]) 
		{	z=isum(z,1);
			j = 0;
		}
	}

	L = _0;
	while (icomp (o,z) >= 0)
	{	h = isiprime (z);
		if (h == 1)	L = lcomp (z,L);
		if (h == -1)	
		{	h = idif (z,1);
			h = ifact (h);
			h = iftpt (z,h,1000);
			if (h == 1)	L = lcomp (z,L);
			if (h == -1) 
			{	h = ifact (z);
				if (llength (h) == 1)	L = lcomp (z,L);
			}
		}
		z = isum (z,d[j++]);
		if (!d[j]) 
		{	z=isum(z,1);
			j = 0;
		}
	}

	L = linv (L);
	return (L);
}
