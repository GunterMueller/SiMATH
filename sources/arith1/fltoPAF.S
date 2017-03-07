/*M
.SH NAME
fltoPAF - (SIMATH) floating point to Papanikolaou floating point"

.SH SYNOPSIS
.nf
#include<_PAFarith1.h>

single fltoPAF(f, x)
floating f;
Float *x;

.SH DESCRIPTION
fltoPAF() performs the assignment *x=f and returns 0.
.PP
.TP 4
.B f
is a SIMATH floating point number in list representation.
.TP 4
.B x
is a floating point number according to the conventions of the Papanikolaou floating point package.

.SH SEE ALSO
PAFtofl
M*/

/*H
	Version  1      02.09.1993	Marc Conrad
   DATE fltoPAF       : 931130
H*/

#include<_PAFarith.h>          

int fltoPAF(f, x)
	floating f;
	Float *x;

{
	if (!f) {
		x->m.length = 0;
		x->m.sign = 0;
		x->e = -BinPrec;
	} else {  
		bind( f ); 
		itoI(flmant(f), &(x->m));
		x->e = 30 * flexpo(f) + Flength(x);
		/* Fnormalize(x); */
	}
	return (0);
}





