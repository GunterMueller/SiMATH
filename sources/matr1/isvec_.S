/*M
.SH NAME
isvec_ - is vector of ____ ?

.SH SYNOPSIS
.nf
#include<_matr1.h>

single isvec_(V, isfunc, numargs, arg1, arg2)
obj V, (*isfunc)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
isvec_() returns 1, if V is a vector of elements accepted by isfunc
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
.B arg1, arg2
are at most 2 optional arguments for isfunc.
M*/








/*H
	Version 1       21.02.1989      Ursula Schneiders
	Version 2	12.10.1990	p2 und p3 vorbesetzt. PS
	Version 3       16.10.1990      ueberfl. Variable i rausgeworfen. US
	Version 4	24.07.1991	single arg1,arg2;
					 -->  obj arg1,arg2;  Th. W.
   DATE isvec_        : 890601.901120.910915
H*/

#include <_matr1.h>

single isvec_(V,is,anzahlargs,arg1,arg2)
obj    V,(*is)();
single anzahlargs;
obj    arg1,arg2;
{
	single erg=1;
	obj O, *p1, *p2, *p3;
	bind(V);
 	bind(arg1,arg2);

	if( !islist( V ) || V == _0 ) return( 0 );

	switch ( anzahlargs )
	{
		case 0: p1 = &O;        /** Z, Q **/
			p2 = p3 = &O;   /* damit die Apollo nicht abstuerzt */
			break;
		case 1: p1 = &arg1;     /** ms, Pi, Pr **/
			p2 = &O;
			p3 = &O;        /* damit die Apollo nicht abstuerzt */
			break;
		case 2: p1 = &arg1;     /** Pms **/
			p2 = &arg2;
			p3 = &O;
			break;
	}

	while ( V != _0 )
	{
		O = lfirst( V );
		V = lred( V );
		if ( !(*is)( *p1, *p2, *p3) ) {erg = 0; break;}
	}
	return(erg);
}
