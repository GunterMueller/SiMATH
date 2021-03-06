/*M
.SH NAME
maupregsr - matrix of univariate polynomials over the rational numbers, Euclid-Gauss step for rows

.SH SYNOPSIS
.nf
#include<_matr2.h>

single maupregsr(M, A, B)
matrix M,A,B;

.SH DESCRIPTION
maupregsr() is identical to maiegsr() except for using matrices
of univariate polynomials over the rational numbers
instead of integers.

.PP
.TP 4
.B M
is an mxn matrix of polynomials in one variable over the rational numbers.
.TP 4
.B A
is an mxm matrix of polynomials in one variable over the rational numbers.
.TP 4
.B B
is an nxn matrix of polynomials in one variable over the rational numbers.

.SH SEE ALSO
maiegsr
M*/

/*H
	Version 1       11.05.1989      U. Schneiders, Th. Weis
	Version 2	26.03.1992	_UPREGSTEP   -> _MAUPREGS
					UPREGSTEPROW -> MAUPREGSR.  PS
   DATE maupregsr     : 890501.920331
H*/


#include <_matr2.h>

single maupregsr( M, A, B )
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
	pol a;          /* Hilfsvariable                                */
	pol b;          /* betragsmaessig kleinstes Element der ersten  */
			/* Spalte                                       */
	single aa,bb;   /* Hilfsvariable, Betrag des aktuell kleinsten  */
	pol c;          /* Hilfsvariable beim Addieren                  */
	pol d;          /*      "                                       */
	pol e;          /*      "                                       */
	single fertig=0, ersteRunde, alle0=1, i=0;
        rat fa,fb;

	bind(M,A,B);
	init(MT,a,b,c,d,e,fa,fb);

	if (lred(M) != _0) {
	    MT = linv(lcinv(M));
	    while (alle0) {
		MS = MT;
		BS = B;
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
			BS = lred(BS);
			}
		    }
		if (alle0) {
/* falls noch Elemente in der Zeile, ruecke MT eins weiter              */
		    if (lred(lfirst(MT)) == _0) break;
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
				bb = pdegree(1,a);
				b = a;
				MSb = MS;
				ASb = AS;
				ersteRunde = 0;
				}
			    else {
			            aa = pdegree(1,a);
                                    fa = plc(1,a);
                                    fb = plc(1,b);
                                    if ( ( bb > aa ) || (bb == aa && rcomp(fb,fa) == 1) ) { /*iabs(a)<bb*/
				    bb = aa;
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
			    c = prneg( 1, prquot( 1,a,b));
			    while ( Z != _0 ) {
				d = prprod(1,lfirst(Z),c);
				e = lfirst(ZM);
				lsfirst(ZM,prsum(1,e,d));
				ZM = lred( ZM );
				Z = lred( Z );
				}
			    while( Y != _0 ) {
				d = prprod(1,lfirst(Y),c);
				e = lfirst(ZA);
				lsfirst(ZA,prsum(1,e,d));
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
