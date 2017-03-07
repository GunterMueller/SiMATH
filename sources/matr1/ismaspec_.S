/*M
.SH NAME
ismaspec_ - is matrix of ____, special ?

.SH SYNOPSIS
.nf
#include<_matr1.h>

single ismaspec_(M, isfunc, numargs, arg1, ..., arg5)
obj M, (*isfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
ismaspec_() returns 1, if M is a matrix of elements accepted by isfunc
and 0 otherwise.

.PP
.TP 4
.B M
is the object to be tested.
.TP 4
.B isfunc
is a function that checks, whether an object belongs to
a certain ring R. The function is given M and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by isfunc.
.TP 4
.B arg1, ..., arg5
are at most 5 optional arguments for isfunc.
M*/
/*H
	Version 1       26.04.1990	Th.Weis
   DATE ismaspec_     : 910915
H*/

#include <_matr1.h>

single ismaspec_(M,is,anzahlargs,arg1,arg2,arg3,arg4,arg5)
obj    M,( *is )();
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5;
{
    	single erg = 1, i;
	list   Z;
	obj    O, *p1, *p2, *p3, *p4, *p5, *p6;

    	bind( M );
	bind( arg1,arg2,arg3,arg4,arg5 );

    	p2 = p3 = p4 = p5 = p6 = &O;
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
       	if ( M )
	{
	   if ( islist( M ) )
	   {
	      i = llength( M );
	      if ( i >= 1 )
	      {
		 i = 0;
		 while ( M != _0 )
		 {
		    Z = lfirst( M );
		    M = lred( M );
		    if ( !islist( Z ) ) { erg = 0; break; }
		    else
		    {
		       if ( !i )
		       {
			  i = llength( Z );
			  if ( !i ) { erg = 0; break; }
		       }
		       if ( i != llength( Z ) ) { erg = 0; break; }
		       else
		       {
		 	  while ( Z != _0 )
			  {
			     O = lfirst( Z );
			     Z = lred( Z );
			     if ( !( *is )( *p1, *p2, *p3, *p4, *p5, *p6 ) ) { erg = 0; break; }
			  }
			  if ( !erg ) break;
		       }
		    }
		 }
	      }
	      else erg = 0;
	   }
	   else erg = 0;
	}
    	return( erg );
}
