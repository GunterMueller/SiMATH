/*M
.SH NAME
maiinv - matrix of integers, inverse

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maiinv(M)
matrix M;

.SH DESCRIPTION
maiinv() returns the matrix M^(-1).

.PP
.TP 4
.B M
is a matrix of integers.
M must be a square matrix with an invertible determinant.
M*/


/*H
	Version 1       25.05.1988      Klaus Petry
   DATE maiinv        : 890501.9011__
H*/


#include <_matr1.h>

matrix maiinv (M)
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
	int A;
	int AA;
	int B;
	int BB;

	single k;
	single n;

	bind (M);
	init (MT, AA, BB);

/* M wird mittels Gauss-Algorithmus invertiert. Erst wird MT auf untere */
/* Dreiecksgestalt gebracht, dann auf Diagonalgestalt.                  */

	MT = macopy( M );
	Mlauf = M = linv (lcinv (MT));
	n = manrcol (M);
	maam (MT, 1);
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
		MTS = MS = lred( MT );
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
				B = ineg (B);
				while( MZ != _0 ) {
					AA = lfirst (PZM);
					AA = iprod (AA, B);
					PZM = lred (PZM);
					BB = lfirst (MZ);
					BB = iprod (BB, A);
					BB = isum (BB, AA);
					lsfirst (MZ, BB);
					MZ = lred (MZ);
					}
				}
			}
		MT = lred( MT );
		}
	MT = M = linv (M);
	k = n - 1;
	while ( MT != _0 ) {
		MZ = lfirst( MT );
		PZM = lreduct (MZ, k);
		A = lfirst (PZM);
		lsfirst (PZM, 1);
		MZ = PZM = lred (PZM);
		while (MZ != _0) {
			B = lfirst (MZ);
			B = iquot (B, A);
			lsfirst (MZ, B);
			MZ = lred (MZ);
			}
		MS = lred (MT);
		while ( MS != _0 ) {
			MSZ = lreduct( lfirst(MS), k );
			MS = lred( MS );
			B = ineg(lfirst(MSZ));
			if ( B ) {
				lsfirst(MSZ,0);
				MSZ = lred( MSZ );
				MZ = PZM;
				while( MZ != _0 ) {
					AA = lfirst (MZ);
					AA = iprod (AA, B);
					BB = lfirst (MSZ);
					BB = isum (AA, BB);
					lsfirst (MSZ, BB);
					MZ = lred( MZ );
					MSZ = lred( MSZ );
					}
				}
			}
		MT = lred( MT );
		k--;
		}
	M = MT = linv (M);
	while (MT != _0) {
		lsfirst (MT, lreduct (lfirst (MT), n));
		MT = lred (MT);
		}
	return( M );
}
