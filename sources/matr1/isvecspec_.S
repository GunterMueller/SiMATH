/*M
.SH NAME
isvecspec_ - is vector of ____, special ?

.SH SYNOPSIS
.nf
#include<_matr1.h>

single isvecspec_(V, isfunc, numargs, arg1, ..., arg5)
obj V, (*isfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
isvecspec_() returns 1, if V is a vector of elements accepted by isfunc
and 0 otherwise.

.PP
.TP 4
.B M
is the object to be tested.
.TP 4
.B isfunc
is a function that checks, whether an object belongs to
a certain ring R. The function is given V and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by isfunc.
.TP 4
.B arg1, ..., arg5
are at most 5 optional arguments for isfunc.
M*/



/*H
	Version 1       19.04.1990	Th. Weis
   DATE isvecspec_    : 910915
H*/

#include <_matr1.h>

single isvecspec_(V,is,anzahlargs,arg1,arg2,arg3,arg4,arg5)
obj    V,( *is )();
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5;
{
	obj    O, *p1, *p2, *p3, *p4, *p5, *p6;
	single erg = 1, i;

	bind( V );
	bind( arg1,arg2,arg3,arg4,arg5 );

	p1 = p2 = p3 = p4 = p5 = p6 = &O;
	switch ( anzahlargs )
	{
	   case 0: p1 = &O;        /** Z, Q **/
		   break;
	   case 1: p1 = &arg1;     /** ms, Pi, Pr **/
		   p2 = &O;
		   break;
	   case 2: p1 = &arg1;     /** Pms **/
		   p2 = &arg2;
		   p3 = &O;
		   break;
	   case 3: p1 = &arg1;     /** Pgfs **/
		   p2 = &arg2;
		   p3 = &arg3;
		   p4 = &O;
		   break;
	   case 4: p1 = &arg1;
		   p2 = &arg2;
		   p3 = &arg3;
		   p4 = &arg4;
		   p5 = &O;
		   break;
	   case 5: p1 = &arg1;
		   p2 = &arg2;
		   p3 = &arg3;
		   p4 = &arg4;
		   p5 = &arg5;
		   p6 = &O;
		   break;
	}
	if ( islist( V ) )
	{
	   i = llength( V );
	   if ( i >= 1 )
	   {
	      while ( V != _0 )
	      {
		 O = lfirst( V );
		 V = lred( V );
		 if ( !( *is )( *p1, *p2, *p3, *p4, *p5, *p6 ) ) { erg = 0; break; }
	      }
	   }
	   else erg = 0;
	}
	else erg = 0;
	return( erg );
}
