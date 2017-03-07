/*M
.SH NAME
maupmipedfcf - matrix of univariate polynomials over modular integer primes, elementary divisor form and cofactors

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix maupmipedfcf(p, M, pA,pB)
int p;
matrix M,*pA,*pB;

.SH DESCRIPTION
maupmipedfcf() returns the elementary divisor form N of the matrix M
and computes the unimodular matrices *pA and *pB for which
it holds that N = (*pA) * M * (*pB).
The matrix N has the form diag(d1, d2, ..., dr, 0, ..., 0)
where d(i+1) is a factor of d(i) for i=1..r-1.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
is a non-zero matrix of polynomials in one variable over Z/pZ.
M*/


/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE maupmipedfcf  : 920331.9305__
H*/


#include <_matr2.h>

static _maupmipegs(int,matrix,matrix,matrix);

matrix maupmipedfcf( p, M, pA, pB )
int p;
matrix M, *pA, *pB;

{
	matrix A, B;
        pol EINS;

	bind( p, M );
	init( A, B, EINS );

        EINS = list2( 0, 1 );

/* Start mit A und B Einheitsmatrix */

	A = maconsdiag( manrrow(M), EINS );
	B = maconsdiag( manrcol(M), EINS );

	M = macopy( M );
	_maupmipegs( p, M, A, B );

	*pA = A;

/* B muss transponiert werden, da die notwendigen Spaltenumformungen    */
/* auf die Zeilen von B angewandt wurden                                */

	*pB = matransp( B );

	return( M );
}


/*c
			_maupmipegs( p, M, A, B )

	"matrix of univariate polynomials over modular integer primes 
	 Euklid- Gauss- step"     (rekursiv)
	static _maupmipegs(p,M,A,B)  int p; matrix M,A,B;
	_maupmipegs(p,M,A,B);
	Auf die Matrix M wird ein Euklid-Gauss-Schritt angewendet,
	so dass M danach die Form (
	( d 0 .. 0 )
	( 0        )
	       C
	( 0        )
	) hat, wobei gilt: d teilt c fuer alle c aus C.
	Ist dies erreicht, so wird _maupmipegs(p, C, lred(A), lred(B)) 
	aufgerufen.
	Siehe auch maupmipegsc, maupmipegsr.
c*/

static _maupmipegs( p, M, A, B )
int p;
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
	pol d1;         /* jeweils M(1,1), zum Testen, ob d1 alle       */
			/* Elemente der Untermatrix teilt.              */
	single fertig=0, RestMatrixIs0=0, d1TeiltAlle;
        int d;

	bind( M, A, B );
	init( MT, d1 );

	if ( M != _0 ) {
	    do {
		do {
		    if ( !fertig ) RestMatrixIs0 = maupmipegsc( p, M, A, B );
		    for ( MS = lred(M), fertig = 1; MS != _0; MS = lred(MS) )
			if ( lfirst( lfirst(MS) ) ) {
			    fertig = 0; break;
			    }
		    if ( !fertig ) RestMatrixIs0 = maupmipegsr( p, M, A, B );
		    for ( Z = lred( lfirst(M) ), fertig = 1; Z != _0; Z = lred(Z) )
			if ( lfirst(Z) ) {
			    fertig = 0; break;
			    }
		    }
		while( !fertig );
		if ( !RestMatrixIs0 ) {
/* teste, ob d1 alle Elemente der Untermatrix teilt                     */
/* falls ja, so wird _upmiegstep mit der Untermatrix aufgerufen         */
/* falls nein, so wird die erste Zeile mit einem Element, das von d1    */
/* nicht geteilt wird, zur ersten Zeile hinzuaddiert, und das Verfahren */
/* beginnt von vorne.                                                   */
		    d1 = lfirst( lfirst(M) );
		    for ( d1TeiltAlle = 1, MS = lred(M), AS = lred(A);
			  MS != _0 && d1TeiltAlle; MS = lred(MS), AS = lred(AS) )
			for ( ZS = lred( lfirst(MS) ); ZS != _0; ZS = lred(ZS) )
			    if ( pmirem( 1, p, lfirst(ZS), d1) ) {
				d1TeiltAlle = 0;
				for ( Z = lred( lfirst(M) ), ZS = lred( lfirst(MS) );
				      Z != _0; ZS = lred(ZS), Z = lred(Z) )
				    lsfirst( Z, lfirst(ZS) );
				for ( Z = lfirst(A), ZS = lfirst(AS); Z != _0;
				      Z = lred(Z), ZS = lred(ZS) )
				    lsfirst( Z, pmisum( 1, p, lfirst(Z), lfirst(ZS) ) );
				fertig = 0;
				break;
				}
		    if ( d1TeiltAlle ) {
/* normiere auf fuehrenden Koeffizienten gleich Eins       */       
                        d = plc( 1, d1 );   
			if ( d && d != 1 ) {
			    pol a;       
			    d1 = pmimiquot( 1, p, d1, d );
			    lsfirst( lfirst(M), d1 );
			    for ( Z = lfirst(A); Z != _0; Z = lred(Z) ) {
				a = pmimiquot( 1, p, lfirst(Z), d );
				lsfirst( Z, a );
				}
			    }            
			if ( lred( lfirst(M) ) != _0 ) {
			    for ( MS = lred(M), MT = _0; MS != _0; MS = lred(MS) )
				MT = lcomp( lred( lfirst(MS) ), MT );
			    MT = linv( MT );
			    _maupmipegs( p, MT, lred(A), lred(B) );
			    }
			}
		    }
		else {
/* normiere auf fueherenden Koeffizienten gleich Eins       */
                    d1 = lfirst( lfirst(M) );  
                    d = plc( 1, d1 );
		    if ( d && d != 1 ) {
			pol a;
			d1 = pmimiquot( 1, p, d1, d );
			lsfirst( lfirst(M), d1 );
			for ( Z = lfirst(A); Z != _0; Z = lred(Z) ) {
			    a = pmimiquot( 1, p, lfirst(Z), d );
			    lsfirst( Z, a );
			    }
			}              
		    }
		}
	    while ( !fertig );
	    }
}
