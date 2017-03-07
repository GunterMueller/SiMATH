/*M
.SH NAME
ptbc - polynomial trailing base coefficient, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

obj ptbc(r, P)  
single r;  
pol P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over an arbitrary ring R.
.PP
ptbc returns an element C (say) of R, where 
.TP 4
C = 
 0                                 , for P = 0,
 the trailing base coefficient of P, else.  

M*/

/*H
	Version 1       07.04.88        R.Boeffgen
   DATE ptbc          : 890501.9011__
H*/


# include <_pol1.h>

obj ptbc( r, P )
single r;
pol P;
{
	obj C;

   /***    r oder P Null    ***/
	if ( r==0 || P==0 )  C = P;
	else {

   /***    ueberpruefe letztes Monom    ***/
		pol Pr, P1;
		for (  Pr=lred2(P);  Pr!=_0;  P=Pr, Pr=lred2(P)  );
		P1 = lsecond(P);
		if ( lfirst(P) == 0 )  C = ptbc( r-1, P1 );
		else  C = 0;
	}
   /***    Ergebnis    ***/
	return( C );
}
