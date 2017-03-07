/*M
.SH NAME
mamiinv - matrix of modular integers, inverse

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamiinv(m, M)
int m;
matrix M;

.SH DESCRIPTION
mamiinv() returns the matrix M^(-1).

.PP
.TP 4
.B M
is a matrix over Z/mZ.
M must be a square matrix with an invertible determinant.
M*/


/*H
	Version 1       31.01.1992      Bernd Mayr 
   DATE mamiinv       : 920331
H*/


#include <_matr1.h>

matrix mamiinv (mi,M)
int mi;
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
	int A;       /* A = lfirst(PZMT).    A = M(i,i)              */
	int AA;      /* AA = lfirst(PZM), bzw AA = lfirst(PZE).      */
			/* AA = M(i,j) bzw AA = ET(i,k)                 */
	int B;       /* B = lfirst(MZT).     B = M(l,i)              */
	int BB;      /* BB = lfirst(MZ), bzw BB = lfirst(EZ).        */
			/* BB = M(l,j) bzw BB = ET(l,k)                 */
	single eins;

	int k;
	int n;

	bind (M,mi);
	init (MT,A,AA,B,BB,k,n);

/* M wird mittels Gauss-Algorithmus invertiert. Erst wird MT auf untere */
/* Dreiecksgestalt gebracht, dann auf Diagonalgestalt.                  */

	MT = macopy( M );
	Mlauf = M = linv (lcinv (MT));
	n = manrcol (M);
	eins = 1;
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
				B = mineg (mi, B);
				while( MZ != _0 ) {
					AA = lfirst (PZM);
					AA = miprod (mi, AA, B);
					PZM = lred (PZM);
					BB = lfirst (MZ);
					BB = miprod (mi, BB, A);
					BB = misum (mi, BB, AA);
					lsfirst (MZ, BB);
					MZ = lred (MZ);
					}
				}
			}
		MT = lred (MT);
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
			B = miquot (mi, B, A);
			lsfirst (MZ, B);
			MZ = lred (MZ);
			}
		MS = MT;
		while ( MS != _0 ) {
			MSZ = lreduct( lfirst(MS), k );
			MS = lred( MS );
			B = mineg (mi, lfirst(MSZ));
			if ( B ) {
				lsfirst(MSZ,0);
				MSZ = lred( MSZ );
				MZ = PZM;
				while( MZ != _0 ) {
					AA = lfirst (MZ);
					AA = miprod (mi, AA, B);
					BB = lfirst (MSZ);
					BB = misum (mi, AA, BB);
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
