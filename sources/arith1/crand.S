/*M
.SH NAME
crand - complex randomise

.SH SYNOPSIS
.nf
#include <_arith1.h>

complex crand (mode)
single mode;

.SH DESCRIPTION
crand() returns a random complex number z. Depending on mode, z satisfies
.TP 4
.B mode = 0
0 <= Real (z), Imag (z) < 1. 
.TP 4
.B mode = 1
|z| < 1
.PP
In any case, crand() is uniformly distributed in the
respective subset of the complex plane and depends
on the global variable SEMIRAND. For a description of
SEMIRAND, see irand().
M*/

/*H
	Version 1	21.01.1996	Georg Lay
   DATE crand         : 960501
H*/

#include <_arith1.h>

complex crand (mode)
int mode;
 {
 floating a,x,y,z,_1;
 init    (a,x,y,z,_1);

 switch (mode) {

   case 1: 
	x = flrand ();
	y = flrand ();
	z = ccri (x,y);
	break;
   case 2:
	_1 = itofl (1);
	do {
	   x = flrand();	x = flsum (x,x);	x = fldif (x,_1);
	   y = flrand();	y = flsum (y,y);	y = fldif (y,_1);
	   z = ccri (x,y);
	   a = csabsv (z);
	   }
	while (flcomp (a,_1) > 0);
	break;
   }
 return (z);
 }

