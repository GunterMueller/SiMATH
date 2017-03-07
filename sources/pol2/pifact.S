/*M
.SH NAME
pifact - polynomial over integers factorization, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

list pifact(r, P)  
single r;
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables, P != 0.
.PP
pifact returns a list L = (c, P1, e1, ..., Pk, ek ),      k >= 1, where        
.IP                                                                             
 c = sign(P)*cont(P),                                                           
 Pi are coprime, irreducible, univariate                                        
 polynomials,                                                                   
 ei are integer numbers, ei > 0, with                                           
.IP                                                                             
P = c * P1^e1 * ... * Pk^ek.                                                    
.PP                                                        
pifact returns ERROR in case of an error occurs.        

M*/

/*H
	Version 1       14.04.89        A.Stein
   DATE pifact        : 891101
H*/


# include <_pol2.h>

list pifact( r, P )
single r;
pol P;
{
	list L;
	init( L );
	bind( P );

    /*** Falls r gleich 1 ***/
	if( r == 1 ) L = upifact(P);
	else {
		single e1,sgn,sgnco;
		int  c ;
		list LS,LC,L1,S1;
		pol P1,co;
		init( c,LS,L1,P1,co,LC );

	    /*** Signum von P ***/
		sgn = pisign(r,P);

	    /*** Absolutbetrag von P ***/
		P = piabs(r,P);

	    /*** Inhalt und primitiver Anteil von P ***/
		co = picontpp( r,P,&P );
		sgnco = pisign(r-1,co);

	    /*** Faktorinhalt ***/
		LC = pifact(r-1,co);
		c = lfirst(LC);
		if( sgnco < 0 ) c = ineg(c);
		LC = lred(LC);

	    /*** quadratfreie Faktorisierung des primitiven Anteils ***/
		LS =( pdegree(r,P) ) ? (pisfact( r, P )) : (_0) ;

		L = _0;

	    /*** Quadratfreie Faktoren zerlegen und kombinieren ***/
		for ( LS=linv(LS);  LS!=_0;  LS=lred(LS) )  {
			S1 = lfirst( LS );
			e1 = lfirst( S1 );
			P1 = lsecond( S1 );
			L1 = spifact( r, P1 );
			if ( L1==ERROR )  return(ERROR);
			do {
				P1 = lfirst( L1 );
				L1 = lred( L1 );
				L = lcomp2( P1, e1, L );
			}
			while ( L1 != _0 );
		}
	    /*** Faktoren des Inhalts einbeziehen ***/
		for( LC = linv(LC); LC != _0 ; LC = lred2(LC) ) {
			e1 = lfirst(LC);
			P1 = lsecond(LC);
			L1 = list2(0,P1);
			L = lcomp2(L1,e1,L);
		}

	    /*** c = sign(P) * cont(P) ***/
		if( sgn < 0 ) c = ineg(c);
		L = lcomp(c,L);

	}


    /*** Ergebnis ***/
	return( L );



}
