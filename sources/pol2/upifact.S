/*M
.SH NAME
upifact - univariate polynomial over integers factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>  

list upifact(P)  
pol P;
  
.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the integer numbers.
P != 0.
.PP
upifact returns a list L = (c, P1, e1, ..., Pk, ek ),      k >= 1, where
.IP
 c = sign(P)*cont(P),
 Pi are coprime, irreducible, univariate
 polynomials,
 ei are integer numbers, ei > 0, with
.IP
P = c * P1^e1 * ... * Pk^ek.
.PP
upifact returns ERROR in case of an error occurs.

M*/

/*H
	Version 1       15.04.88        R. Boeffgen
	Version 2       06.01.89        A. Stein
	Version 3       26.07.89        A. Stein: pineg gestrichen.
   DATE upifact       : 890501.891101.9011__
H*/


# include <_pol2.h>

list upifact( P )
pol P;
{
	single sgn;
	int  c;
	list L;
	init( c,L );
	bind( P );

   /*** primitiver Anteil ***/
	sgn = pisign( 1,P );
	c = picontpp( 1,P,&P );
	if ( sgn<0 ) c = ineg( c );
	L = _0;

   /*** falls Grad > 0 ***/
	if ( pdegree(1,P) )  {

		single e1;
		list  LS, L1, S1;
		pol   P1;
		init( LS,L1,P1 );

	   /*** quadratfreie Faktorisierung ***/
		LS = pisfact( 1,P );

	   /*** quadratfreie Faktoren zerlegen ***/
		for ( LS=linv(LS);  LS!=_0;  LS=lred(LS) )  {
			S1 = lfirst( LS );
			e1 = lfirst( S1 );
			P1 = lsecond( S1 );
			L1 = uspifact( P1 );
			if ( L1==ERROR )  return(ERROR);
			do {
				P1 = lfirst( L1 );
				L1 = lred( L1 );
				L = lcomp2( P1, e1, L );
			}
			while ( L1 != _0 );
		}
	}
   /*** Ergebnis ***/
	return( lcomp(c,L) );
}
