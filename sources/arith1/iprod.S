/*M
.SH NAME
iprod - integer product

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iprod(A, B)
int A, B;

.SH DESCRIPTION
iprod() returns A * B.
M*/

/*H
	Version 1       23.06.1986      R.Boeffgen
	Version 2       26.09.1990      fast vollstaendig neu (Karatsuba)
					U.Schneiders
	Version 3	30.12.1991	Einbau der Essener Arithmetik.  MC
	Version 4	01.09.1993	Einbau der Heidelberger Arithmetik.  MC
	Version 5 	20.12.1993	Einbau von isquare. Marc Conrad
	Version 6	22.11.1994	Neuer Dokumentationsstandard. MP
   DATE iprod         : 890501.901120.920331.931130.941201
H*/

#include<_arith1.h>
#include<_heidelberg.h>
#ifndef LP64
#include<_Earith.h>
#endif

void IasImuI();

int iprod(A, B)			/* unsafe A,B */
	int A, B;
{
    /***    Sonderfaelle    ***/         
    if (A == 0 || B == 0)
	return (0);
    if ( A == B )
	return( isquare( A ) );
    if (isatom(A))
	return (isprod(B, A));
    if (isatom(B))
	return (isprod(A, B));
    /***    A und B mehrfach-genau    ***/
    {
	single lA, lB;
	single IPROD_GR=32;
/* muss groesser als 5 sein!, dieser Wert wurde experimentell erm. */
/* dieser Wert ist optimal auf SUNs. */

	bind(A, B);

	lA = lblength(A, IPROD_GR + 1);
	lB = lblength(B, lA);

	if (lA < 4) {
	    lB = llength(B);
	    if (lB == 2 && lA == 2)
		A = i22prod(A, B);
	    else
		A = iprod_sp(A, B, lA, lB);
	} else if (lB < 4) {
	    lA = llength(A);
	    A = iprod_sp(A, B, lA, lB);
	} else if ( (lA > IPROD_GR) && ( lB > IPROD_GR) ) {
	    A = iHDfu( IasImuI, 2, A, B );
	} else {
#ifdef LP64
	    lA = llength(A);
	    lB = llength(B);
	    if( lA>20 && lB>20 )   /* Konst. 20 heuristisch erhalten */
		return(iprodk_sp( A, B, lA, lB ));
	    else
		return(iprod_sp( A, B, lA, lB ));
#else
			LONG eb[LAENGE], ea[LAENGE];
			single vza, vzb;

			if ((vza = itoEsb(A, ea, LAENGE - 1)) == 2 ||
			    (vzb = itoEsb(B, eb, (LAENGE - 1) - ea[0])) == 2) {
				A = iHDfu(IasImuI, 2, A, B);
			} else {
				Emult(ea, eb, ea);
				if (vza == vzb)
					A = Etoi(ea);
				else
					A = Etoineg(ea);
			}
#endif
	}
	return (A);
    }
}
