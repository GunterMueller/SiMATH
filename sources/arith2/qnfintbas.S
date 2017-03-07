/*M
.SH NAME
qnfintbas - quadratic number field integral basis

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfintbas( D )  
int D;
     
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.PP
qnfintbas returns a list of two elements of K, say a1 and a2, which are a basis of the ring of integers of K/Q, more exact :
.IP
 a1 = 1, 
 a2 = D^(1/2),             for D = 2 or 3 mod 4,
    = 1/2 * (D^(1/2) + 1), for D = 1 mod 4.      

M*/
                             
/*H
	Version 1       11.04.1989      Christine Hollinger
	Version 2       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.
					INTBASQNF -> QNFINTBAS.  PS
   DATE qnfintbas     : 890801.910915
H*/

#include<_arith2.h>

list qnfintbas( D )
int D;
{
	nfel a;
	list B;
	init( a, B );
	bind( D );

	D = mihom( 4,D );
	switch( D )
	{       case 1: a = list4( 2,1,1,1 );
			break;
		case 2:
		case 3: a = list4( 1,1,1,0 );
			break;
		default:break;
	}
	B = list1( a );
	a = list3( 1,0,1 );
	B = lcomp( a,B );
	return( B );
}
