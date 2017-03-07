/*M
.SH NAME
isiupi - is irreducible univariate polynomial over integers ?

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isiupi(P)  
pol P;
    
.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the integer numbers.
.PP
isiupi returns
.PP
 1,     if P is irreducible,
 0,     if P is reducible or 0,
 ERROR, in case of an error occurs.           

M*/
                       
/*H
	Version 1       16.06.1988      vorlaeufige Version    PS
	Version 2       17.06.1988      endgueltige Version    RB
					(Modifizierung von upifact)
   DATE isiupi        : 890501
H*/



# include <_pol2.h>

single isiupi( P )
pol P;
{
	single s=0;

	if (P) {
		if ( pdegree(1,P) <= 1 )  s = 1;
		else {

		   /*** falls Grad>1: auf Quadratfreiheit testen ***/
			pol D,G,Q,R;
			bind( P );
			P = piprimpart( 1,P );
			D = pideriv(1,P);
			G = pigcdcf(1,P,D,&Q,&R);

		   /*** quadratfreies P untersuchen ***/
			if ( lfirst(G)==0 )  s = isiuspi( P );
		}
	}
   /*** Ergebnis ***/
	return( s );
}
