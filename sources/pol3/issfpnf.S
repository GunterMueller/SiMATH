/*M
.SH NAME
issfpnf - is squarefree polynomial over number field

.SH SYNOPSIS
.nf
#include<_pol3.h>

single issfpnf(r, F, D, P)  
single r; 
int D; 
pol F, P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is a monic polynomial in dense representation.
.PP
Let t denote a zero of F, then t generates a number field, say K.
.TP 4
.B D
is a natural number, such that the ring of integers of K is in 1/D * Z[t] (s. ouspidenic).
.TP 4
.B P                                                                            
is a polynomial in r variables over K.
.PP
issfpnf returns 1, if P is squarefree with regard to the main variable, and 0 else.
                               
.SH SEE ALSO
ouspidenic

M*/
                                      
/*H
	Version 1 	15.03.95	Wolfgang Schwarz
   DATE issfpnf       : 951201
H*/

# include <_pol3.h>

single issfpnf(r,F,D,P)
single r;
int D;
pol F,P;
{

	single s ;
	pol P1,Muell ;

	bind(F,D,P);
	init(P1,Muell);

/*      Trivialer Fall  */

	if ( !P ) return( 0 ) ;

/* Allgemeiner Fall  */

	else {
		P1 = pnfderiv(r,F,P);
		P = pnfgcdcf(r,F,D,P,P1,&Muell,&Muell);

		if ( ispconst(r,P,&Muell) ) s = 1 ;
		else s = 0 ;
	     }

	return( s ) ;

}
