/*M
.SH NAME
inearesttor - integer nearest to rational number

.SH SYNOPSIS
.nf
#include<_arith1.h>

int inearesttor(r)
rat r;

.SH DESCRIPTION
inearesttor() returns nearest integer
to the rational number r.
If there are two choices, the one with
smaller absolute value will be returned.
M*/
/*H
	Version 1	08.08.91	J.Schmitt
   DATE inearesttor   : 910915
H*/

#include<_arith1.h>

int inearesttor(r)
rat r;
{
	int c1;
	rat r1,eh;
	bind(r);
	init(c1,r1,eh);
	                   
	eh = list2(1,2);
	if ( rcomp(eh,rabs(r)) >= 0 ) return(0);
	if ( rcomp(r,0) > 0 ) {
	        c1 = rfloor(r);
		r1 = rdif(r,itor(c1));
		if ( rcomp(eh,r1) < 0 ) c1 = rceil(r);
	}
	else {
		c1 = rceil(r);
		r1 = rdif(itor(c1),r);
		if ( rcomp(r1,eh) > 0 ) c1 = rfloor(r);
	}
	return(c1);
}
