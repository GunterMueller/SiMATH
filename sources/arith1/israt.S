/*M
.SH NAME
israt - is rational number ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single israt(R)
obj R;

.SH DESCRIPTION
israt() returns 1 in case R is a rational number,
and 0 otherwise.
M*/
/*H
	Version 1       12.1.1987                Pascale Serf
	Version 2       20.01.1988               eingebaut :
							1.) islist
							2.) isint
							3.) isign
								MAR.
   DATE israt         : 890501
H*/


# include <_arith1.h>

single israt(x)
obj x;
{
	if (x==0) return(1);
	if ( isatom(x) ) return(0);
	if ( !islist(x) ) return( 0 );
	if ( llength(x)!=2 ) return(0);
	if ( !isint(lfirst(x)) || !isint(lsecond(x)) ) return( 0 );
	if ( lfirst(x) == 0 || isign(lsecond(x)) <= 0 ) return(0);
	if ( igcd(lfirst(x),lsecond(x)) != 1 ) return(0);
	return(1);
}
