/*M
.SH NAME
maiedfcf - matrix over integers, elementary divisor form and cofactors

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix maiedfcf(M, pA, pB)
matrix M,*pA,*pB;

.SH DESCRIPTION
maiedfcf() returns the elementary divisor form N of the matrix M
and computes the unimodular matrices *pA and *pB for which
it holds that N = (*pA) * M * (*pB).
The matrix N has the form diag(d1, d2, ..., dr, 0, ..., 0)
where d(i+1) is a factor of d(i) for i=1..r-1.

.PP
.TP 4
.B M
is a non-zero matrix of integers.
M*/
/*H
	Version 1       18.07.1988      Klaus Petry
	Version 2	26.03.1992	_EGSTEP   -> _MAIEGS
					EGSTEPROW -> MAIEGSR
					EGSTEPCOL -> MAIEGSC.  PS
   DATE maiedfcf      : 890501.9011__.920331.9305__
H*/


#include <_matr2.h>

static _maiegs(matrix,matrix,matrix);

matrix maiedfcf(M,pA,pB)
matrix M, *pA, *pB;

{
	matrix A, B;

	bind( M );
	init( A, B );

/* Start mit A und B Einheitsmatrix */

	A = maconsdiag (manrrow (M),1);
	B = maconsdiag (manrcol (M),1);

	M = macopy(M);
	_maiegs(M,A,B);

	*pA = A;

/* B muss transponiert werden, da die notwendigen Spaltenumformungen    */
/* auf die Zeilen von B angewandt wurden                                */

	*pB = matransp(B);

	return(M);
}


/*c
			_maiegs( M, A, B )

	"matrix of integers Euklid- Gauss- step"     (rekursiv)
	static _maiegs(M,A,B)  matrix M,A,B;
	_maiegs(M,A,B);
	Auf die Matrix M wird ein Euklid-Gauss-Schritt angewendet,
	so dass M danach die Form (
	( d 0 .. 0 )
	( 0        )
	       C
	( 0        )
	) hat, wobei gilt: d teilt c fuer alle c aus C.
	Ist dies erreicht, so wird _estep(C, lred(A), lred(B)) aufgerufen.
	Siehe auch maiegsc, maiegsr.
c*/

static _maiegs(M,A,B)
matrix M, A, B;

{
/* Verfahren frei nach E. Lamprecht: Lineare Algebra 1, Lemma 6.7       */

	matrix AS;      /* durchlaeuft A von oben nach unten            */
	matrix MS;      /*      "      M  "   "    "     "              */
	matrix MT;      /* ist die Untermatrix von M nach erfoglreichem */
			/* eg-Schritt, wenn also in erster Zeile und    */
			/* Spalte nur noch 0 ausser d1 vorhanden sind   */
	list Z;         /* jeweils eine Zeile von M bzw A               */
	list ZS;        /* jeweils eine Zeile von MS bzw AS             */
	int d1;         /* jeweils M(1,1), zum Testen, ob d1 alle       */
			/* Elemente der Untermatrix teilt.              */
	single fertig=0, RestMatrixIs0=0, d1TeiltAlle;

	bind (M, A, B);
	init(MT);

	if (M != _0) {
	    do {
		do {
		    if (!fertig) RestMatrixIs0 = maiegsc(M,A,B);
		    for (MS = lred(M),fertig = 1;MS != _0;MS = lred(MS))
			if (lfirst(lfirst(MS))) {
			    fertig = 0; break;
			    }
		    if (!fertig) RestMatrixIs0 = maiegsr(M,A,B);
		    for (Z = lred(lfirst(M)),fertig = 1;Z != _0;Z = lred(Z))
			if (lfirst(Z)) {
			    fertig = 0; break;
			    }
		    }
		while(!fertig);
		if (!RestMatrixIs0) {
/* teste, ob d1 alle Elemente der Untermatrix teilt                     */
/* falls ja, so wird _maiegs mit der Untermatrix aufgerufen             */
/* falls nein, so wird die erste Zeile mit einem Element, das von d1    */
/* nicht geteilt wird, zur ersten Zeile hinzuaddiert, und das Verfahren */
/* beginnt von vorne.                                                   */
		    d1 = lfirst(lfirst(M));
		    for (d1TeiltAlle = 1,MS = lred(M),AS = lred(A);
			  MS != _0 && d1TeiltAlle;MS = lred(MS),AS = lred(AS))
			for (ZS = lred(lfirst(MS));ZS != _0;ZS = lred(ZS))
			    if (irem(lfirst(ZS),d1)) {
				d1TeiltAlle = 0;
				for (Z = lred(lfirst(M)),ZS = lred(lfirst(MS));
				     Z != _0;ZS = lred(ZS),Z = lred(Z))
				    lsfirst(Z,lfirst(ZS));
				for (Z = lfirst(A),ZS = lfirst(AS);Z != _0;
				     Z = lred(Z),ZS = lred(ZS))
				    lsfirst(Z,isum(lfirst(Z),lfirst(ZS)));
				fertig = 0;
				break;
				}
		    if ( d1TeiltAlle ) {
/* normiere auf positive Diagonalelemente       */
			if (isign(d1) == -1) {
			    int a;
			    d1 = ineg( d1 );
			    lsfirst(lfirst(M),d1);
			    for (Z = lfirst(A); Z != _0; Z = lred(Z)) {
				a = ineg( lfirst( Z ) );
				lsfirst( Z, a );
				}
			    }
			if (lred(lfirst(M)) != _0) {
			    for (MS = lred(M),MT = _0;MS != _0;MS = lred(MS))
				MT = lcomp(lred(lfirst(MS)),MT);
			    MT = linv(MT);
			    _maiegs(MT,lred(A),lred(B));
			    }
			}
		    }
		else {
/* normiere auf positive Diagonalelemente       */
		    if (isign(d1 = lfirst(lfirst(M))) == -1) {
			int a;
			d1 = ineg(d1);
			lsfirst(lfirst(M), d1);
			for (Z = lfirst(A); Z != _0; Z = lred(Z)) {
			    a = ineg(lfirst(Z));
			    lsfirst(Z, a);
			    }
			}
		    }
		}
	    while(!fertig);
	    }
}
