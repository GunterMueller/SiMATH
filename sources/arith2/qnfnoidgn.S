/*M
.SH NAME
qnfnoidgn - quadratic number field number of ideals with given norm p^e

.SH SYNOPSIS
.nf
#include<_arith2.h>

single qnfnoidgn(d,p,e)
int d;
single p,e;

.SH DESCRIPTION
qnfnoidgn() returns the number of ideals with norm p^e in Q(sqrt(d)).

.PP
.TP 4
.B d
is a squarefree integer not equal to 0 and 1.
.TP
.B p
is a single precision prime.
.TP
.B e
is a single precision number.
M*/
/*H
        Version  1      24.08.1998      S.Schmitt
   DATE rsqrt         : 980830
H*/

# include <_arith2.h>

single qnfnoidgn(d,p,e)
int d;
single p,e;
{
	single m;
	list L;

	bind(d);
	init(L);

	L = qnframind(d,p);
	if(llength(L)==2) m=e+1;	/** zerlegt **/
	else if(lfirst(L)==2) m=1;	/** verzweigt **/
	else				/** traege **/
	{
		if(mshom(2,e)) m = 0;
		else m = 1;
	}
	return(m);
}
