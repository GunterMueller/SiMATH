/*M
.SH NAME
isuspi - is univariate squarefree polynomial over integers

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isuspi(P)  
pol P;
  
.SH DESCRIPTION
.TP 4
.B P
is an univariate and primitive polynomial over the integer numbers.
.PP
isuspi returns 
.PP
 1,	if P is square-free,
 0,	if P is not square-free or if P = 0,
 ERROR, in case of an error occurs.

M*/
                  
/*H
	Version 1       11.01.1989      A. Stein
	Version 2       04.07.1991      ueberfl. Zuweisung s=ERROR beseitigt. PS
   DATE isuspi        : 890501.910715
H*/


# include <_pol2.h>

single isuspi( P )
pol P;
{

	single s ;
	pol P1 ;

	bind(P);

/*      Trivialer Fall  */

	if ( !P ) return( 0 ) ;

/* Allgemeiner Fall  */

	else {

		P1 = pideriv(1,P);
		P = pigcdcf(1,P,P1,&P1,&P1);

		if ( ispione(1,P) ) s = 1 ;
		else s = 0 ;
	}


	return( s ) ;


}
