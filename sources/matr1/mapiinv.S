/*M
.SH NAME
mapiinv - matrix of polynomials over integers, inverse

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapiinv(r, M)
single r;
matrix M;

.SH DESCRIPTION
mapiinv() returns the matrix M^(-1).

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over integers.
M must be a square matrix with an invertible determinant.
M*/


/*H
	Version 1       25.05.1988      Klaus Petry
	Version 2       09.11.1988      Klaus Petry
   DATE mapiinv       : 890501.9011__
H*/


#include <_matr1.h>

matrix mapiinv (r,M)
single r;
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
	rat A;          /* A = lfirst(PZMT).    A = M(i,i)              */
	rat AA;         /* AA = lfirst(PZM), bzw AA = lfirst(PZE).      */
			/* AA = M(i,j) bzw AA = ET(i,k)                 */
	rat B;          /* B = lfirst(MZT).     B = M(l,i)              */
	rat BB;         /* BB = lfirst(MZ), bzw BB = lfirst(EZ).        */
			/* BB = M(l,j) bzw BB = ET(l,k)                 */
	rat eins;

	single k;
	single n;

	bind (M);
	init (A, B, AA, BB, eins, MT);

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
				B = pineg (r, B);
				while( MZ != _0 ) {
					AA = lfirst (PZM);
					AA = piprod (r, AA, B);
					PZM = lred (PZM);
					BB = lfirst (MZ);
					BB = piprod (r, BB, A);
					BB = pisum (r, BB, AA);
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
			B = piquot (r, B, A);
			lsfirst (MZ, B);
			MZ = lred (MZ);
			}
		MS = MT;
		while ( MS != _0 ) {
			MSZ = lreduct( lfirst(MS), k );
			MS = lred( MS );
			B = pineg (r, lfirst(MSZ));
			if ( B ) {
				lsfirst(MSZ,0);
				MSZ = lred( MSZ );
				MZ = PZM;
				while( MZ != _0 ) {
					AA = lfirst (MZ);
					AA = piprod (r, AA, B);
					BB = lfirst (MSZ);
					BB = pisum (r, AA, BB);
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
