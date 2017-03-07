/*M
.SH NAME
ppftransf - polynomial over p-adic field transformation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppftransf(r1, p, P1, V1, r2, P2, V2, Vn, pV3)
single r1, p, r2; 
pol P1, P2;  
list V1, V2, Vn, *pV3; 
 
.SH DESCRIPTION
.TP 4
.B p 
is a prime number. p < BASIS.
.TP 4
.B r1, r2
are integer numbers, 0 < r1, r2 < BASIS.
.TP 4
.B P1, P2
are polynomials over the p-adic field Qp in r1, r2 variables respectively.
.TP 4
.B V1, V2
are lists of variables names used by P1, P2 resp..
.TP 4
.B Vn
is a variable name in V1.   
.PP
ppftransf returns the polynomial P3, which arises from the substitution of Vn in P1 by P2.
.PP
The list of variables names used by P3 ( the union of V1 and V2 ), will be alphabetized and stored in *pV3. 

.SH SEE ALSO
itopfel

M*/
                          
/*H
	Version 1       14.09.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r1, p vertauscht
	Version 3	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE ppftransf     : 901120.910915.941201
H*/

#include <_pol3.h>

pol ppftransf( r1, p, P1, V1, r2, P2, V2, Vn, pV3 )
single r1, p, r2;
pol P1, P2;
list V1, V2, Vn, *pV3;
{
	single i, j, r3;
	pol P2P, P3, h;
	list PP,V3;
	bind( P1, P2, V1, V2, Vn );
	init( P2P, P3, h, PP, V3 );

	/*** P1 ist konstant ***/

	if( ispconst( r1, P1, &P3 ) )
	{       V3 = usunion( V1,V2 );
		V3 = vlsort( V3,&PP );
		P3 = pvinsert( 0, P1, llength( V3 )-r1 );
	}

	/*** P1 ist nicht konstant ***/

	else if( ispconst( r2, P2, &P3 ) )      /*** P2 konstant ***/
	{       PP = V1;
		for( i = 1; vncomp( Vn,lfirst( PP ) ); PP = lred( PP ),i++ );
		PP = list1( i );

		/*** Ziel: Variable aus Vn Hauptvariable ***/

		for( j = r1 - 1; j; j-- )
		{       if( j != i )    PP = lcomp( j,PP );
			else    PP = lcomp( r1,PP );
		}
		P1 = pvpermut( r1, P1, PP );
		V1 = lpermut( V1,PP );
		P3 = ppfeval( r1, p, P1, P3 );
		V3 = usdiff( V2,V1 );
		V3 = lconc( V1,V3 );
		V3 = vlsort( V3,&PP );
		r3 = llength( V3 );
		P3 = pvinsert( 0, P3, r3 - r1 + 1 );
		P3 = pvpermut( r3, P3, PP );
	}
	/*** P1 und P2 nicht konstant ***/
	else
	{       V1 = list2( V1,V2 );
		P1 = list2( P1,P2 );
		V3 = pvmerge( V1, P1, &P2 );
		P1 = lfirst( P2 );
		P2 = lsecond( P2 );
		r3 = llength( V3 );
		PP = V3;
		for( i = 1; vncomp( Vn,lfirst( PP ) ); PP = lred( PP ),i++ );

		/*** Ziel: Variable aus Vn Hauptvariable ***/

		PP = list1( i );
		for( j = r3 - 1; j; j-- )
		{       if( j != i )    PP = lcomp( j,PP );
			else    PP = lcomp( r3,PP );
		}
		P1 = pvpermut( r3, P1, PP );
		P2 = pvpermut( r3, P2, PP );
		P1 = lcinv( P1 );
		P3 = 0;
		i = 0;
		P2P = pvinsert( 0, 1, r3 );     /*** p-adisch machen ***/
		j = ppford( r3, p, P2 );
		P2P = pitoppf( r3, P2P, p, j );
		while( P1 != _0 )               /*** Auswerten ***/
		{       h = lfirst( P1 );
			j = lsecond( P1 );
			P1 = lred2( P1 );
			for( ; i < j; i++ )
				P2P = ppfprod( r3, p, P2P, P2 );
			h = list2( 0,h );
			h = ppfprod( r3, p, h, P2P );
			P3 = ppfsum( r3, p, h, P3 );
		}
		P3 = pvpermut( r3, P3, PP );
	}
	*pV3 = V3;
	return( P3 );
}
