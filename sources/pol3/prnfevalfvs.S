/*M
.SH NAME
prnfevalfvs - polynomial over rationals number field element evaluation first variable special version

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol prnfevalfvs(r, F, P)  
single r;  
pol F, P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a polynomial in r variables over Q.
.PP
Let k denotes the generating element of K.
.PP
prnfevalfvs returns a polynomial in r-1 variables over K, which arises by the substitution of the first variable found in the list of variable names beloning to P by k.
                             
M*/
 
/*H
	Version 1       14.05.1992	U. Schneiders
	Version 2	05.02.1993	Fehler beseitigt.  US
   DATE prnfevalfvs   : 921130.930115
H*/

#include <_pol3.h>

pol prnfevalfvs( r, F, P )
single r;
pol F, P;
{
	list kf, L;
	obj ks;
	init( kf, ks, L );
	bind( F, P );

	/*** Sonderfaelle ***/

	if( P == 0 )   return( 0 );
	if( r == 1 ) 
        {	P = uprtonfel( F, P );
		return( P );
	}

	/*** Umwandlung der Koeffizienten in Zahlkoeperelemente ***/

	r--;
	P = ptodip(r,P);
	L = _0;
	while( P != _0 )
        {	kf = lfirst(P);
		ks = lsecond(P);
		P = lred2( P );
		kf = uprtonfel( F, kf );
		if( kf ) L = lcomp2( ks, kf, L );
		
	}
	if( L == _0 ) return( 0 );
	L = linv( L );
	L = diptop( r, L );

	return( L );
}
