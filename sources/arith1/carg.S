/*M
.SH NAME 
carg - complex number argument

.SH SYNOPSIS
.nf
#include<_arith1.h>
#include<_PAFarith.h>

floating carg( c )
complex	c;

.SH DESCRIPTION
carg() computes the argument arg(c) of a complex number c.
.PP
.TP 4
.B c
is a complex number.
M*/
/*H
        Version 1       24.04.1997      Andreas Heiser
   DATE carg     :  
H*/

#include<_arith1.h>
#include<_PAFarith.h>

floating carg(c)
complex	c;
{	floating	arg,h;
	
	init(arg,h);
	bind(c);

	/* c != 0 */

	if(flcomp(creal(c),0)==0)
		if(flcomp(cimag(c),0)>0)
			arg=flquot(flPi(),itofl(2));
		else
			arg=flquot(flPi(),itofl(-2));
	else
	{	h=flquot(cimag(c),creal(c));
		arg=flPAFfu(Fatan,1,h);
		if(flcomp(creal(c),0)<0)
			if(flcomp(arg,0)<=0)
				arg=flsum(arg,flPi());
			else
				arg=fldif(arg,flPi());
	}
	return(arg);
}