/*M
.SH NAME
marfmsp1inv - matrix of rational functions over modular single primes, transcendence degree 1, inverse

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix marfmsp1inv(p, M)
single p;
matrix M;

.SH DESCRIPTION
marfmsp1inv() returns the matrix M^(-1).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
must be a square matrix of rational functions in one variable over Z/pZ
with det(A)!=0 in Z/pZ.
M*/






/*H
	Version 1       05.06.1989      U. Schneiders, Th. Weis
	Version 2	10.09.1992	list2(list2(),list2()) aufgeloest.  PS
   DATE marfmsp1inv   : 890801.9011__.9109__.921130
H*/


#include <_matr3.h>

matrix marfmsp1inv (p,M)
single p;
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

			/* Sind in einem Gauss-Schritt PZMT, bzw PZET   */
			/* die Pivotzeilen, und PZM, bzw PZE die noch   */
			/* zu bearbeitenden Reste, und MZ bzw EZ die    */
			/* aktuellen Zeilen, dann                       */
	rfunc A;        /* A = lfirst(PZMT).    A = M(i,i)              */
	rfunc AA;       /* AA = lfirst(PZM), bzw AA = lfirst(PZE).      */
			/* AA = M(i,j) bzw AA = ET(i,k)                 */
	rfunc B;        /* B = lfirst(MZT).     B = M(l,i)              */
	rfunc BB;       /* BB = lfirst(MZ), bzw BB = lfirst(EZ).        */
			/* BB = M(l,j) bzw BB = ET(l,k)                 */
	rfunc eins;

	single k;
	single n;

	bind (M);
	init (A, B, AA, BB, eins, MT);

/* M wird mittels Gauss-Algorithmus invertiert. Erst wird MT auf untere */
/* Dreiecksgestalt gebracht, dann auf Diagonalgestalt.                  */

	MT = macopy( M );
	Mlauf = M = linv (lcinv (MT));
	n = manrcol (M);
	eins = list2 (0, 1);
	eins = list2 (eins, list2 (0, 1));
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
				B = rfmsp1neg (p, B);
				while( MZ != _0 ) {
					AA = lfirst (PZM);
					AA = rfmsp1prod (p, AA, B);
					PZM = lred (PZM);
					BB = lfirst (MZ);
					BB = rfmsp1prod (p, BB, A);
					BB = rfmsp1sum (p, BB, AA);
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
		PZM = lreduct (MZ, k);
		A = lfirst (PZM);
		lsfirst (PZM, eins);
		MZ = PZM = lred (PZM);
		while (MZ != _0) {
			B = lfirst (MZ);
			B = rfmsp1quot (p, B, A);
			lsfirst (MZ, B);
			MZ = lred (MZ);
			}
		MS = lred (MT);
		while ( MS != _0 ) {
			MSZ = lreduct( lfirst(MS), k );
			MS = lred( MS );
			B = rfmsp1neg (p, lfirst(MSZ));
			if ( B ) {
				lsfirst(MSZ,0);
				MSZ = lred( MSZ );
				MZ = PZM;
				while( MZ != _0 ) {
					AA = lfirst (MZ);
					AA = rfmsp1prod (p, AA, B);
					BB = lfirst (MSZ);
					BB = rfmsp1sum (p, AA, BB);
					lsfirst (MSZ, BB);
					MZ = lred( MZ );
					MSZ = lred( MSZ );
					}
				}
			}
		MT = lred( MT );
		k--;
		}
	MT = M = linv (M);
	while (MT != _0) {
		lsfirst (MT, lreduct (lfirst (MT), n));
		MT = lred (MT);
		}
	return (M);
}


