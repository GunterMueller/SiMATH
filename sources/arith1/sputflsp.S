/*M
.SH NAME
sputflsp - string put floating point special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

char *sputflsp(prec,f,str)
single prec;
floating f;
char *str;
pt
.SH DESCRIPTION
sputflsp() writes the floating point number f
to the memory location at str and returns str.
f is written as "mmm.nnn" using prec >=0
decimal places.

.SH CAUTION
There is no checking whether or not the space at str is sufficient!
M*/

/*H
	Version 1       15.06.1993	Marc Conrad
	Version 2 	26.11.1993	Fehler beseitigt.  MC
   DATE sputflsp      : 931130
H*/

#include<_arith1.h>

char *sputflsp(prec, f, str)
	floating f;
	char *str;
	single prec;
{
	int A;
	floating g;
	char *estr;

	bind(f);
	init(A, g);


	estr = str;

/* Vorzeichen */
	if (flsign(f) < 0) {
		*(estr++) = '-';
		f = flneg(f);
	}
/* Vorkommastellen */
	A = flfloor(f);  
	sputi(A, estr);     

/* Nachkommastellen */ 

	estr = str + strlen(str);
	g = itofl(A);
	f = fldif(f, g);
	A = iexp(10, prec);
	g = itofl(A);
	f = flprod(g, f);

/* Trick um fuehrende Nullen auszudrucken */

	A = isum(A, flround(f));

/* Abschneiden von hinteren Nullen        */
	while (!(isqrem(A, 10, &f, &g), g))
		A = f;
	if (A != 1) {
		sputi(A, estr);
		*estr = '.';
	}
	return (str);
}
