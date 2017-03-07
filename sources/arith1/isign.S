/*M
.SH NAME
isign - integer sign

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isign(A)
int A;

.SH DESCRIPTION
isign() returns the sign of A.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2 	21.05.1992	etwas schneller.  MC
   DATE isign         : 890501.921130
H*/


# include <_arith1.h>

single isign(A)
	int A;
{
	/***    A single    ***/
	if (isatom(A))
		return (ssign(A));
	/***    A mehrfach genau    ***/
	else {
		single a;

		while ((a = lfirst(A)) == 0) {
			A = lred(A);
		}
		return (((a) < 0 ? -1 : 1));
	}
}
