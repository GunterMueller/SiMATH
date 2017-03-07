/*M
.SH NAME
intpp - integer p-part

.SH SYNOPSIS
.nf
#include<_arith1.h>

int intpp(p,m)
single p;
int m;

.SH DESCRIPTION
For p prime and m!=0 intpp() returns the maximum power n of p with n|m.
M*/
/*H
	Version 1       28.07.1988      Christine Hollinger
   DATE intpp         : 890501.9311__
H*/


#include<_arith1.h>

int intpp( p,m )
single p;
int m;
{
	single r;
	int mp, n, q;
	init( mp, n, q );
	bind( m );

 
	mp = m;
	r = 0;
	while( !r )
	{       isqrem( mp, p, &q, &r );
		if( !r )    mp = q;
	}
	n = iquot( m,mp );
	return( n );
}
