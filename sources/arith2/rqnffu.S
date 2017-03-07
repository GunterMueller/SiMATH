/*M
.SH NAME
rqnffu - real quadratic number field fundamental unit

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel rqnffu(D, pl)  
int D; 
single pl;
 
.SH DESCRIPTION
.TP 4
.B D
is a positive and square free integer number, generating a real quadratic number field, say K.
.TP 4
.B pl
is a single.
.PP
With help of the continued fraction algorithm, rqnffu computes and returns the fundamental unit of K, whereat pl denotes the maximal period lenght. If the origin period length is greater than pl, rqnffu returns 0.

M*/
                              
/*H
	Version 1       15.10.1987      MAR.
	Version 1.2     29.11.1988      C.Hollinger  ( Aktualisiert )
	Version 2       11.04.1989      C.Hollinger  ( Eingabe F, Typ nfel,
						       Ausgabe nfel )
	Version 3       04.01.1991      A.Stein Funktionsname neu:
					IFURQNF -> RQNFIFU
	Version 4       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS 
	Version 5       28.08.1991      Fall e=_0 ergaenzt.
					RQNFIFU -> RQNFFU.  AS
   DATE rqnffu        : 890801.910715.910915
H*/


#include<_arith2.h>

nfel rqnffu( D,pl )
int D;
single pl;
{
	single i,rest;
	int a1, a2, a3, a4, b1, b2, b3, b4, e1, e2;
	int h1, h2, p1, p2, q1, q2, q3, x, X, x0;
	nfel e;
	init ( a1, a2, a3, a4, b1, b2, b3, b4, e1, e2 );
	init ( h1, h2, p1, p2, q1, q2, q3, x, X, x0, e );
	bind( D );

	rest = mshom( 4,D );

	/*** D = 1 mod 4 -> Kettenbruchentwicklung mit 1/2*(1+D^(1/2)). ***/

	if( rest == 1 )
	{       X = isqrt( D );
		x0 = isum( 1,X );
		x0 = iquot( x0,2 );
		p2 = 1;
		q3 = 2;
		X = idif( D,1 );
		q2 = iquot( X,2 );
	}

	/*** D = 2,3 mod 4 -> Kettenbruchentwicklung mit D^(1/2). ***/

	else
	{       x0 = isqrt( D );
		p2 = 0;
		q3 = 1;
		q2 = D;
	}
	a4 = x0;
	b4 = 1;
	a3 = 1;
	b3 = 0;
	x = x0;
	x0 = isqrt( D );
	i = -1;
	do {    a1 = a2; a2 = a3; a3 = a4;
		b1 = b2; b2 = b3; b3 = b4;
		p1 = p2; q1 = q2; q2 = q3;
		i++;
		h1 = iprod( x,q3 );
		p2 = idif( h1,p1 );
		h1 = idif( p1,p2 );
		h1 = iprod( x,h1 );
		q3 = isum( h1,q1 );
		X = isum( x0,p2 );
		x = iquot( X,q3 );
		h1 = iprod( x,a3 );
		a4 = isum( h1,a2 );
		h1 = iprod( x,b3 );
		b4 = isum( h1,b2 );
	} while ( i < pl && idif( p1,p2 ) && idif( q2,q3 ) );
	if ( !(idif( q2,q3 )) )
	{       h1 = iprod( a3,b3 );
		h2 = iprod( a2,b2 );
		e1 = isum( h1,h2 );
		h1 = iprod( b3,b3 );
		h2 = iprod( b2,b2 );
		e2 = isum( h1,h2 );
	}
	else    if ( !(idif( p1,p2 )) )
		{       a3 = isum( a3,a1 );
			h1 = iprod( b2,a3 );
			h1 = isum( h1,1 );
			i = ( i%2 ) * 2;
			e1 = idif( h1,i );
			b3 = isum( b3,b1 );
			e2 = iprod( b2,b3 );
		}  
	else return( _0 );
	if ( !( idif( q2,q3) ) || !( idif( p1,p2 ) ) )
		if ( rest == 1 )
			e1 = idif( e1,e2 );

	/*** Umformung in Element des Zk. K vom Typ nfel. ***/

	if( rest == 1 )
	{       e1 = iprod( 2,e1 );
		e1 = isum( e1,e2 );
		h1 = igcd( e1,e2 );
		if( h1 % 2 )    e = list4( 2,1,e2,e1 );
		else
		{       e1 = iquot( e1,2 );
			e2 = iquot( e2,2 );
			e = list4( 1,1,e2,e1 );
		}
	}
	else    e = list4( 1,1,e2,e1 );
	return ( e );
}
