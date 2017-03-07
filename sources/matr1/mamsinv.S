/*M
.SH NAME
mamsinv - matrix of modular singles, inverse

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamsinv(m, M)
single m;
matrix M;

.SH DESCRIPTION
mamsinv() returns the matrix M^(-1).

.PP
.TP 4
.B M
is a matrix over Z/mZ.
M must be a square matrix with an invertible determinant.
M*/



/*H
	Version 1       25.05.1988      Klaus Petry
	Version 2       10.11.1988      Klaus Petry
   DATE mamsinv       : 890501.9011__.9203__
H*/


#include <_matr1.h>

matrix mamsinv (m,M)
single m;
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
	single A;       /* A = lfirst(PZMT).    A = M(i,i)              */
	single AA;      /* AA = lfirst(PZM), bzw AA = lfirst(PZE).      */
			/* AA = M(i,j) bzw AA = ET(i,k)                 */
	single B;       /* B = lfirst(MZT).     B = M(l,i)              */
	single BB;      /* BB = lfirst(MZ), bzw BB = lfirst(EZ).        */
			/* BB = M(l,j) bzw BB = ET(l,k)                 */
	single eins;

	single k;
	single n;

	bind (M);
	init (MT);

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
				B = msneg (m, B);
				while( MZ != _0 ) {
					AA = lfirst (PZM);
					AA = msprod (m, AA, B);
					PZM = lred (PZM);
					BB = lfirst (MZ);
					BB = msprod (m, BB, A);
					BB = mssum (m, BB, AA);
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
			B = msquot (m, B, A);
			lsfirst (MZ, B);
			MZ = lred (MZ);
			}
		MS = MT;
		while ( MS != _0 ) {
			MSZ = lreduct( lfirst(MS), k );
			MS = lred( MS );
			B = msneg (m, lfirst(MSZ));
			if ( B ) {
				lsfirst(MSZ,0);
				MSZ = lred( MSZ );
				MZ = PZM;
				while( MZ != _0 ) {
					AA = lfirst (MZ);
					AA = msprod (m, AA, B);
					BB = lfirst (MSZ);
					BB = mssum (m, AA, BB);
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
