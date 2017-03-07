/*M
.SH NAME
ccri - complex construction from real and imaginary part

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex ccri(re, im)
floating re,im;

.SH DESCRIPTION/
ccri() returns the complex number z = re + I*im.
M*/

/*H
        Version 1 	16.01.1993	Georg Lay
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ccri          : 930531.941201
H*/
#include<_arith1.h>

complex ccri(r, i)
        floating r, i;
        {
        bind(r,i);
        if( r == 0 && i == 0 ) { return 0; }
        return( list2(r,i) );
        }

