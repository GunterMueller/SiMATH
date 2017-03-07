/*M
.SH NAME
iHDfu - integer using Heidelberg arithmetic functions

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iHDfu(func,numargs,arg1,arg2)
void (*func) ();
single numargs;
integer arg1,arg2;

.SH DESCRIPTION
iHDfu() returns the result of the call to the function func
of the Heidelberg integer package (HDi) as a SIMATH integer.
.PP
.TP 4
.B func
is a function of the HDi. For detailed information on the functions
and whether they allowed here please refer to the documentation in
the HDi... files.
.TP 4
.B numargs
is the number of arguments to be passed to func.
.TP 4
.B arg1, arg2
are the arguments to be converted according to the conventions of the HDi.
M*/
/*H
	Version 1       27.09.1993      Marc Conrad
   DATE iHDfu         : 931130
H*/

#include<_HDarith.h>


int iHDfu(func, anzahlargs, arg1, arg2)
	void (*func) ();
single anzahlargs;
obj arg1, arg2;

{
	single d;
	Integer y;

	bind(arg1, arg2);
        
	cI(&y);


	if (anzahlargs == 0) {
		(*func) (&y);
	} else if (anzahlargs == 1) {
		Integer a;

		cI(&a);
		itoI(arg1, &a);
		(*func) (&y, &a);
		dI(&a);
	} else if (anzahlargs == 2) {
		Integer a, b;

		cI(&a);
		cI(&b);
		itoI(arg1, &a);
		itoI(arg2, &b);
		(*func) (&y, &a, &b);
		dI(&a);
		dI(&b);
	}
	arg1 = Itoi(&y);
	dI(&y);
	return (arg1);
}           









