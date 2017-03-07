/*M
.SH NAME
isiupr - is irreducible univariate polynomial over rationals ?

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isiupr(P)  
pol P;
 
.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the rational numbers.
.PP
isiupr returns 
.PP
 1,     if P is irreducible,
 0,     if P is reducible or 0,
 ERROR, in case of an error occurs.
                                                 

M*/
                              
/*H
	Version 1       16.06.1988      vorlaeufige Version    PS
   DATE isiupr        : 890501
H*/


# include <_pol2.h>

single isiupr(P)
pol P;
{
	single s = ERROR;
	list L;

	bind(P);
	init(L);

	if ( !P ) s = 0;
	else {
	    L = uprfact(P);
	    if ( L != ERROR ) {
		if ( llength(L) > 3 ) s = 0;
		else s = 1;
	    }
	}

	return(s);
}
