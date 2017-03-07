/*M
.SH NAME
mapmiinv - matrix of polynomials over modular integers, inverse

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmiinv(r, m, M)
single r;
int m;
matrix M;

.SH DESCRIPTION
mapmiinv() returns the matrix M^(-1).

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over Z/mZ.
M must be a square matrix with an invertible determinant.
M*/


/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE mapmiinv      : 920331
H*/


#include <_matr1.h>

matrix mapmiinv (r,m,M)
single r;
int  m;
matrix M;

{
	list MZ;        /* eine Zeile von MT                            */
	list MSZ;       /* eine Zeile von MS                            */
	list PZM;       /* durchlaeuft Pivotzeile von MS                */
	list PZMT;      /* aktuelle Pivotzeile von MS                   */
	list Hz;        /* Hilfszeile zum Vertauschen                   */

	matrix MS;      /* durchlaeuft MT; falls MT=(Z1,..,Zn), dann    */
			/* ist fuer i=1..n MS=(Zi,..,Zn)                */
	matrix MT;      /* bildet immer die nach einem Gauss-Schritt    */
			/* erhaltene Untermatrix                        */
	matrix MTS;     /* durchlaeuft MT zum Aufbau der neuen Untermat.*/
	matrix Mlauf;   /* durchlaeuft M, um beim Tauschen der Pivot-   */
			/* zeilen mit dem Index k auf die richtige Zeile*/
			/* zuzugreifen.                                 */
	matrix N;       /* N = M^-1, falls M invertierbar,              */

			/* Sind in einem Gauss-Schritt PZMT, bzw PZET   */
			/* die Pivotzeilen, und PZM, bzw PZE die noch   */
			/* zu bearbeitenden Reste, und MZ bzw EZ die    */
			/* aktuellen Zeilen, dann                       */
	pol A;
	pol AA;
	pol B;
	pol BB;

	pol eins;

	int k;
	int n;

	bind (M,m);
	init (k,n,A, B, AA, BB, eins, MT);

/* M wird mittels Gauss-Algorithmus invertiert. Erst wird MT auf untere */
/* Dreiecksgestalt gebracht, dann auf Diagonalgestalt.                  */

	MT = macopy( M );
	Mlauf = M = linv (lcinv (MT));
	n = manrcol (M);
	eins = pvinsert (0, 1, r);
	maam (MT, eins);
	while (lred (MT) != _0) {
/* Suche Pivot-Zeile */
		MS = MT;
		k = 0;
		while (MS != _0 && lfirst(lfirst( MS )) == 0) {
			MS = lred(MS);
			k++;
			}
/* Setze aktuelle Zeilen und tausche */
		MZ = lfirst( MS );
		if ( MS != MT ) {
			Hz = lfirst( MT );
			lsfirst( MT, MZ );
			lsfirst( MS, Hz );
/* Tausch auch in M */
			Hz = lfirst (Mlauf);
			MS = lreduct (Mlauf, k);
			lsfirst (Mlauf, lfirst(MS));
			lsfirst (MS, Hz);
			}
		A = lfirst(MZ);
		PZMT = lred(MZ);
		MTS = MT = MS = lred( MT );
		Mlauf = lred (Mlauf);
/* MS durchlaeuft MT unterhalb von MZ MT */
		while( MS != _0 ) {
			PZM = PZMT;
			MZ = lfirst( MS );
			MS = lred( MS );
			B = lfirst( MZ );
			lsfirst (MZ, 0);
			MZ = lred( MZ );
			lsfirst (MTS, MZ);
			MTS = lred (MTS);
			if ( B ) {
				B = pmineg (r, m, B);
				while( MZ != _0 ) {
					AA = lfirst (PZM);
					AA = pmiprod (r, m, AA, B);
					PZM = lred (PZM);
					BB = lfirst (MZ);
					BB = pmiprod (r, m, BB, A);
					BB = pmisum (r, m, BB, AA);
					lsfirst (MZ, BB);
					MZ = lred (MZ);
					}
				}
			}
		}
	MT = M = linv (M);
	k = n - 1;
	while ( MT != _0 ) {
		MZ = lfirst( MT );
		MT = lred( MT );
		PZM = lreduct (MZ, k);
		A = lfirst (PZM);
		lsfirst (PZM, eins);
		MZ = PZM = lred (PZM);
		while (MZ != _0) {
			B = lfirst (MZ);
			B = pmiquot (r, m, B, A);
			lsfirst (MZ, B);
			MZ = lred (MZ);
			}
		MS = MT;
		while ( MS != _0 ) {
			MSZ = lreduct( lfirst(MS), k );
			MS = lred( MS );
			B = pmineg (r, m, lfirst(MSZ));
			if ( B ) {
				lsfirst(MSZ,0);
				MSZ = lred( MSZ );
				MZ = PZM;
				while( MZ != _0 ) {
					AA = lfirst (MZ);
					AA = pmiprod (r, m, AA, B);
					BB = lfirst (MSZ);
					BB = pmisum (r, m, AA, BB);
					lsfirst (MSZ, BB);
					MZ = lred( MZ );
					MSZ = lred( MSZ );
					}
				}
			}
		k--;
		}
	N = MT = M = linv (M);
	while (MT != _0) {
		lsfirst (MT, lreduct (lfirst (MT), n));
		MT = lred (MT);
		}
	return( N );
}
