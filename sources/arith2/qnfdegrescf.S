/*M
.SH NAME
qnfdegrescf - quadratic number field degrees of the residue class fields

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfdegrescf( D,p )  
int D; 
single p;
   
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B p
is a prime number, so it is a prime spot of Q. 
.PP
qnfdegrescf returns a list, say L, containing the degrees of the residue class field of the extensions of p on K, i.e.
.TP 4
for p having only one extension, say P, on K, L is equal to (f), where f is in {1,2}, 
.TP 4
for p having two extensions, say P1 resp. P2, on K, L is equal to (1 1).

M*/
              
/*H
	Version 1       18.04.1989      Christine Hollinger
	Version 2       06.07.1990      C.H.  DEGRESCFQNF -> QNFDEGRESCF
	Version 3       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS
   DATE qnfdegrescf   : 890801.901120.9107__.910915
H*/

#include<_arith2.h>

list qnfdegrescf( D,p )
int D;
single p;
{
	list f;
	init( f );
	bind( D );

	/*** p = 2, so D Quadrat in Q2 <-> D = 1 mod 8 u. 2|w2( a ).***/

	if( p == 2 )
	{       D = mshom( 8,D );
		switch( D )
		{       case 1: f = list2( 1,1 );
				break;
			case 2:
			case 3: f = list1( 1 );
				break;
			case 5: f = list1( 2 );
				break;
			case 6:
			case 7: f = list1( 1 );
				break;
			default:break;
		}
	}

	/*** p != 2, so D Quadrat in Qp <-> (a/p) = 1 und 2|wp(D). ***/

	else
	{       if( D % p )
		{       p = ijacsym( D,p );
			if( p == 1 )    f = list2( 1,1 );
			else    f = list1( 2 );
		}
		else    f = list1( 1 );
	}
	return( f );
}
