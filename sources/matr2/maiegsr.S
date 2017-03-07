/*M
.SH NAME
maiegsr - matrix over integers, Euclid-Gauss step for rows

.SH SYNOPSIS
.nf
#include<_matr2.h>

single maiegsr(M, A, B)
matrix M,A,B;

.SH DESCRIPTION
maiegsr() performs an Euclid-Gauss step for rows
according to E. Lamprecht, Lineare Algebra, Lemma 1.1.
The computation on M,A and B yields new matrices M', A' and B'.
Let a = (a11 a21 ... am1) be the first column of the matrix M.
If there is a non-zero entry in a, then M will be transformed
such that a' = (gcd(a11, .. ,am1), 0, .... 0) and there will
be a recursive call with all matrices reduced by one row.
If all entries of a are zero, then a will be swapped with
the non-zero column with the lowest number and the function
will restart. If all entries of M become zero, the return
value will be 1 and 0 otherwise.

All row operations on M are also performed on the rows of A.
All column operations on M are also performed on the rows of B.

Let A be the m-dimensional unity matrix and
let B be the n-dimensional unity matrix in the first call.
Then it holds that N=A'*M'*(B')T is the elementary divisor form of M
after the computation 

.PP
.TP 4
.B M
is an mxn matrix over integers.
.TP 4
.B A
is an mxm matrix over integers.
.TP 4
.B B
is an nxn matrix over integers.
M*/



/*H
	Version 1       07.07.1988      Klaus Petry
	Version 2	26.03.1992	_EGSTEP   -> _MAIEGS
					EGSTEPROW -> MAIEGSR.  PS
	Version 3	10.12.1993	Fehler beseitigt.  MC
   DATE maiegsr       : 890501.920331.931130
H*/


#include <_matr2.h>

single maiegsr( M, A, B )
matrix M, A, B;

{
	matrix AS;      /* durchlaeuft A von oben nach unten            */
	matrix ASb;     /* der Rest von A, dessen erste Zeile der Zeile */
			/* von M entspricht, die zu tauschen ist, damit */
			/* M(1,1) das kleinste Element der ersten Spalte*/
			/* ist */
	matrix  BS;     /* durchlaeuft B von oben nach unten            */
	matrix  MS;     /* durchlaeuft M von oben nach unten            */
	matrix  MT;     /* zeigt auf eine Spalte von M, um diese mit der*/
			/* ersten Spalte von M zu tauschen, falls dort  */
			/* nur 0                                        */
	matrix  MSb;    /* die erste Zeile von MSb ist mit der ersten   */
			/* von M zu tauschen, damit M(1,1) das kleinste */
			/* Element der ersten Spalte ist                */
	list Y;         /* jeweils eine Zeile von A, AS                 */
	list Z;         /* jeweils eine Zeile von M, MS                 */
	list ZM;        /* zeigt auf die erste Zeile von M beim addieren*/
	list ZA;        /*      "                        A       "      */
	list Zb;        /* Zeile der Matrix M mit kleinstem Element     */
	list Za;        /*      "           A           "               */
	int a;          /* Hilfsvariable                                */
	int b;          /* betragsmaessig kleinstes Element der ersten  */
			/* Spalte                                       */
	int bb;         /* Hilfsvariable, Betrag des aktuell kleinsten  */
	int c;          /* Hilfsvariable beim Addieren                  */
	int d;          /*      "                                       */
	int e;          /*      "                                       */
	single fertig=0, ersteRunde, alle0=1, i=0;

	bind(M,A,B);
	init(MT,bb,c,d);

	if (lred(M) != _0) {
	    MT = linv(lcinv(M));
	    BS = B;
	    while (alle0) {
		MS = MT;
		while(MS != _0) {
		    if (lfirst(lfirst(MS))) {
/* es gibt ein Element != 0 in M        */
			alle0 = 0;
			if (i) {
/* tausche Spalten, falls notwendig     */
			    MS = M;
			    while (MT != _0) {
				Z = lfirst(MT);
				lsfirst(lfirst(MS),lfirst(Z));
				lsfirst(Z,0);
				MS = lred(MS);
				MT = lred(MT);
				}
			    Z = lfirst(BS);
			    lsfirst(BS,lfirst(B));
			    lsfirst(B,Z);
			    }
			break;
			}
		    else {
			MS = lred(MS);
			}
		    }
		if (alle0) {
/* falls noch Elemente in der Zeile, ruecke MT eins weiter              */
		    if (lred(lfirst(MT)) == _0) break;

		    BS = lred(BS);
		    i++;
		    MS = MT;
		    while(MS != _0) {
			lsfirst(MS,lred(lfirst(MS)));
			MS = lred(MS);
			}
		    }
		}
	    if ( !alle0 ) {
/* suche Zeile mit betragsmaessig kleinstem Element != 0 */
		while (!fertig) {
		    MS = M;
		    AS = A;
		    ersteRunde = 1;
		    while (MS != _0) {
			if (a = lfirst(lfirst(MS))) {
			    if (ersteRunde) {
				bb = iabs(a);
				b = a;
				MSb = MS;
				ASb = AS;
				ersteRunde = 0;
				}
			    else {
				if (icomp(bb,iabs(a)) == 1) { /*iabs(a)<bb*/
				    bb = iabs(a);
				    b = a;
				    MSb = MS;
				    ASb = AS;
				    }
				}
			    }
			MS = lred(MS);
			AS = lred(AS);
			}
/* vertausche nun erste Zeile von M mit Zeile MSb, da hier das kleinste  */
/* Element der ersten Spalte != 0 steht, dasselbe mit A und ASb          */
		    Za = lfirst(ASb);
		    if (MSb != M) {
			Z = lfirst (M);
			ZM = lfirst (MSb);
			while (Z != _0) {
			    c = lfirst (Z);
			    lsfirst (Z, lfirst (ZM));
			    lsfirst (ZM, c);
			    Z = lred (Z);
			    ZM = lred (ZM);
			    }
			lsfirst(ASb,lfirst(A));
			lsfirst(A,Za);
			}
		    Zb = lfirst(M);
		    MS = lred(M);
		    AS = lred(A);
/* subtrahiere nun das c=M(i,1)/M(1,1)-fache der ersten Zeile von M von */
/* der i-ten Zeile fuer i=1..manrrow(M). Subtrahiere auch das c-fache   */
/* der ersten Zeile von A von deren i-ten                               */
		    while (MS != _0) {
			ZM = lfirst(MS);
			if (a = lfirst(ZM)) {
			    ZA = lfirst(AS);
			    Y = Za;
			    Z = Zb;
			    c = ineg (iquot (a, b));
			    while ( Z != _0 ) {
				d = iprod(lfirst(Z),c);
				e = lfirst(ZM);
				lsfirst(ZM,isum(e,d));
				ZM = lred( ZM );
				Z = lred( Z );
				}
			    while( Y != _0 ) {
				d = iprod(lfirst(Y),c);
				e = lfirst(ZA);
				lsfirst(ZA,isum(e,d));
				ZA = lred( ZA );
				Y = lred( Y );
				}
			    }
			MS = lred( MS );
			AS = lred( AS );
			}
/* falls erste Spalte ausser M(1,1) nur 0, dann fertig          */
		    for(MS = lred(M),fertig = 1;MS != _0;MS = lred(MS)) {
			if (lfirst(lfirst(MS))) {
			    fertig = 0;
			    break;
			    }
			}
		    }
		}
	    }
	return(alle0);
}
