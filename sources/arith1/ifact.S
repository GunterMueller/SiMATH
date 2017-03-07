/*M
.SH NAME
ifact - integer factorization

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ifact([-brk,] [-imp,] [-elc,] [-rho,] N)
int N;
single brk,imp,elc,rho;

.SH DESCRIPTION
ifact() returns the factorization of N as a list
L = ( [err], q1,..., qr ) with 0 < q1 <=...<= qr, N = q1 *...* qr.
If x = lfirst(k) is greater than 0, then q1,...,qr are prime factors;
this is always true for brk = 0.
If x = lfirst(l) is less or equal to 0, then an error has occurred.
In this case x equals err where for
.TP 4
err = -1:
the search with rhopds and elcpds/elcfds did not succeed.
.TP 4
err = -3:
rhopds or elcpds found a factor that could not be factorised.
.TP 5
err = -4:
the primality test could not determine whether
or not qi is prime for some i, i.e. isprime(qi)
returned -1 (see the documentation of isprime()).
.PP
The break points are marked in the source code.
The parameters brk, imp, elc, and rho are optional.
In general the function call "L = ifact( N );" is sufficient.
For very specific applications optional parameters may be supplied
.PP
.TP 4
.B brk
If brk = 1 the program will terminate if necessary (see below).
If brk = 0 the program will run until all prime factors have
been found (i.e. maybe infinitely). The default value is brk = 0.
.TP 4
.B imp 
> 997, is the upper bound of prime factors p with 0 < p < imp to be tested.
The default value is imp = 5000. Independent of the value of imp, sometimes
greater prime factors may be found as well (e.g. if N < 2^60).
.TP 4
.B elc
> 0, is the maximum number of elliptic curves to be tested
(see the documentation of elcpds and elcfds).
For N < 2^320 the number of tested curves is always a multiple of 32.
For instance elc = 40 will result in 32 curves being tested.
The default values are elc = 2^25, if brk = 0 and elc = 200, falls brk = 1.
If elc is set, then imp MUST BE set as well.
.TP 4
.B rho
> 0, is the maximum number of iterations in Pollard's rho-method (see the documentation of rhopds).
The default value is rho = 2500.
If rho is set, elc and imp MUST BE set as well.
.TP 4
.B N
> 0, is the number to be factorised.

.SH NOTE
Ever since version 3.6 explicitly setting the parameters imp, elc
and rho is not longer useful because ifact() now is internally optimised.
Of course, older programs using these parameters will still work properly.

.SH SEE ALSO
ifactpp, isiprime, isipprime, ifactcfe.
M*/
/*H
	Version 1       19.03.1987      Pascale Serf
	Version 2       22.05.1987      Beschleunigung fuer
					  2^30 <= N < 2^40
					  B.Weis (P.Serf)
	Version 3       28.07.1987      schnellerer Alg. fuer
					  2^30 <= N < 2^60
					  B.Weis (P.Serf)
	Version 4       29.09.1987      icomp(N,list3(0,0,1)) < 0
					durch
					ilog2( N ) <= 60
					ersetzt.
						MAR.
	Version 5       05.09.1990      komplett neu geschrieben.
					Marc Conrad.
	Version 6       20.10.1990      varargs eingebaut wegen SUN4.
					Marc Conrad.       
	Version 7 	02.07.1992	Beschleunigung durch elcfds, 
					Aenderung der Voreinstellungen.  
					Marc Conrad.
	Version 8	01.02.1994	Beschleunigung durch isiprime,
					Abbruch (err = -2) entfaellt.
					srand() entfernt und
					rand() % 1000 durch irand (1000)
					ersetzt, um Randomisierung ueber
					irand() kontrollieren zu koennen.
					if else if else if else if ...
					Ketten durch switch aufgeloest.
						Georg J. Lay
					MX-Version entfernt. MP
   DATE ifact         : 890501.901120.921130.941201
H*/

# include <_arith1.h>
# include <varargs.h>


list ifact (va_alist)
va_dcl
 {
 va_list pQ;
 list F, G;		/* F: Liste der gefundenen
			 * Primfaktoren, G: Hilfsliste */
 int M, P, Q, W, A;	/* Q,W: Hilfsvariablen    */

/* A: alle Primfaktoren < A sind schon getestet */
 single s, c, brk, imp, rho, elc;	/* c : Zufallsvariable     */

 init (F, G, M, P, Q, W, A);

/* ------------   Vorbesetzung   -----------*/

 F = _0;
 brk = 0;
 imp = 5000;
 rho = 2500;
 elc = (1 << 25);

/* ------------ Einlesen der optionalen Parameter -----------*/

 va_start (pQ);
 Q = va_arg (pQ, int);
 if (Q <= 0 && Q > -BASIS) {
	if (Q > -10) {
		brk = -Q;
		Q = va_arg (pQ, int);
		if (brk)
			elc = 200;
		}
	if (Q <= 0 && Q > -BASIS) {
		imp = -Q;
		Q = va_arg (pQ, int);
		if (Q <= 0 && Q > -BASIS) {
			elc = -Q;
			Q = va_arg (pQ, int);
			if (Q <= 0 && Q > -BASIS) {
				rho = -Q;
				Q = va_arg (pQ, int);
				}
			}
		}
	}
 va_end (pQ);

/* Q  = zu faktorisierende Zahl                   */

/* ---------------    Q < 2^30       --------------------------------- */

 if (issingle (Q))	return sfact (Q);

/* ---------------    Q  < 2^60      --------------------------------- */

 if (ilog2 (Q) <= 60) {
	F = dpipds (1, Q);
	return (linv (F));
	}

/* ---------------   Suche nach ganz kleinen Primfaktoren    --------- */

 F = ispd (Q, &M);
 A = 1000;

/* Suche nach restlichen Primfaktoren ( M ist jetzt zu faktorisieren ) */

 while (M != 1) {

	if (ilog2 (M) <= 60) {
		F = lconc (F, dpipds (A, M));
		libsort (F);
		return (F);
		}

	switch (isiprime (M)) {

	case ISAPRIME:
		F = lcomp (M, F);
		M = 1;
		G = _0;
		break;

	case UNKNOWN:		
		if (brk) {
			F = lcomp (M, F);
			libsort (F);
			return (lcomp (-4, F));		/* err = -4 :  */ 
			}

		impds (M, A, W, &P, &M);
		if (P == 1) {
			G = _0;
			F = lcomp (M, F);
			M = 1;
			}
		else	{
			G = list1 (P);
			A = P;
			}
		break;

	case NOTPRIME:
		if (A < imp) {				/* Suche durch Probedivision	*/
			P = imspds (M, A, imp);
			if (P == 1)
				A = imp;
			else	{
				M = isquot (M, P);
				A = P;
				G = list1 (P);
				F = lcomp (P, F);
				}
			}
		else	P = 1;

		if (P == 1) {				/* Suche mit rhopds und elcpds	*/
			c = 1 + irand (1000);
			do	{
				single elcmax = 500000, i = 32;
				P = rhopds (M, c, rho);
				while ( (P == 1) && (i <= elc)) {
					i += 32;
					P = elcfds (M, c, elcmax);
					c += irand (1000);
					elcmax += elcmax;
					}
				if (P == 0)	P = elcpds (M, c, elc);
				}
			while (oequal (P, M));

			if (isqrt (P) > A)
				G = ifact (-brk, -imp, -elc, -rho, P);
			else	G = (P == 1) ? _0 : list1 (P);

			if (brk) {			/* Abbruch bei brk = 1 und	*/
							/* Fehlversuch			*/
				if (P == 1) {
					F = lcomp (M, F);
					libsort (F);
					return (lcomp (-1, F));		/* err = -1	*/ 
					}
				if (lfirst (G) < 0) {
					iqrem (M, P, &Q, &W);
					G = lred (G);
					F = lconc (G, F);
					F = lcomp (Q, F);
					libsort (F);
					return (lcomp (-3, F));		/* err = -3	*/ 
					}
				}	
			}	/* if ( P == 1)...  */
		break;
		} 	/* end of switch */

	/*- Herausdividieren der gefundenen Primfaktoren -*/

	for (; G != _0; G = lred (G)) {
		P = lfirst (G);
		iqrem (M, P, &Q, &W);
		while (W == 0) {
			M = Q;
			F = lcomp (P, F);
			iqrem (M, P, &Q, &W);
			}
		}
	}			/* end of 'while ( M != 1 )'	*/

 libsort (F);
 return  (F);
 }
