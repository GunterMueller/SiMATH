/*M
.SH NAME
qnframind - quadratic number field ramification indices

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnframind( D, p )  
int D; 
single p;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B p
is a prime number, so it is a prime spot on Q.
.PP
qnframind returns a list, say L, containing the ramification indeces of the extensions of p on K, i.e.
.PP
If p has only one extension, say P, on K, L = (e) where e is the ramification indice of P/p (so e is element of {1, 2}).
.PP
If p has two extensions on K, say P1 and P2, then L = (1 1).

M*/
                                           
/*H
	Version 1       18.04.1989      Christine Hollinger
	Version 2       06.07.1990      C.H.   RAMINDQNF -> QNFRAMIND
	Version 3       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS
   DATE qnframind     : 890801.901120.9107__.910915
H*/

#include<_arith2.h>

list qnframind( D,p )
int D;
single p;
{
	list e;
	init( e );
	bind( D );

	/*** p = 2, so D Quadrat in Q2 <-> D = 1 mod 8 u. 2|w2( a ). ***/

	if( p == 2 )
	{       D = mshom( 8,D );
		switch( D )
		{       case 1: e = list2( 1,1 );
				break;
			case 2:
			case 3: e = list1( 2 );
				break;
			case 5: e = list1( 1 );
				break;
			case 6:
			case 7: e = list1( 2 );
				break;
			default:break;
		}
	}

	/*** p != 2, so D Quadrat in Qp <-> (a/p) = 1 und 2|wp(D). ***/

	else
	{       if( D % p )
		{       p = ijacsym( D,p );
			if( p == 1 )    e = list2( 1,1 );
			else    e = list1( 1 );
		}
		else    e = list1( 2 );
	}
	return( e );
}
