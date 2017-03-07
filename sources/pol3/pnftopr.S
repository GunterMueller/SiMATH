/*M
.SH NAME
pnftopr - polynomial over number field to polynomial over rationals

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnftopr(r, P)  
single r;  
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4             
.B P
is a polynomial in r variables over a number field.
.PP
The coefficients of P are algebraic numbers, so they can be represented by univariate polynomials over Q. pnftopr returns a polynomial in r+1 variables over Q, say P1, where P1 arises by replacing the coefficient of P by the regarding polynomials.
    
M*/
           
/*H
	Version 1       18.03.1993	S.Schmitt/U.Schneiders
	Version 2	29.10.1993	von 'pol2 nach 'pol2 wegen Aufruf 
					von NFELTOUDPR aus 'arith2.  PS
   DATE pnftopr	      : 930531.931130
H*/

#include <_pol3.h>

pol pnftopr( r, P )
single r;
pol P;
{
	list ks, L, ks1, e;
	obj kf;
	rat k;
	single d,i;
	init( ks, L, ks1, e, kf, k );
	bind( P );

	/*** Spezialfaelle ***/

	if( P == 0 )  return( 0 );
	if( !r) 
	{	P = nfeltoudpr( P );
		P=dptop(1,P);
		return( P );
	}
	
	/*** Umwandlung der Koeffizienten in Polynome ueber Q ***/

	P = ptodip(r,P);
	L = _0;
	while( P != _0 )
        {	kf = lfirst(P);
		ks = lsecond(P);
		P = lred2( P );
		kf = nfeltoudpr( kf );
		d=lfirst(kf);
		kf=lred(kf);
		for(i=d;i>=0;i--)
		{	k=lfirst(kf);
			kf=lred(kf);
			if(k)
			{	ks1=lcopy(ks);
				e=lsuffix(ks1,i);
				L=lcomp2(e,k,L);
			}
		}	
	}
	L = linv( L );
	r++;  
	L = diptop( r, L );

	return( L );
}
