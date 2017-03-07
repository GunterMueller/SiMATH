/*M
.SH NAME
ijacsym_lo - integer Jacobi-symbol ( lists only )

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ijacsym_lo(A,B)
int A,B;

.SH DESCRIPTION
ijacsym_lo() returns the value of the Jacobi-symbol (A / B)
or 1 in case B equals 1.
The computation is completely performed within the SIMATH memory
management, i.e. using only lists.

.PP
.TP 4
.B A
is an integer.
.TP 4
.B B
is an odd, positive integer with gcd(A,B) = 1.
M*/

/*H
	Version 1       19.05.1992      im wesenlichen altes ijacsym
					Marc Conrad
   DATE ijacsym_lo    : 921130
H*/


# include <_arith1.h>

single ijacsym_lo( a , m )
int a,m;
{
	single s=1,e2;
	int ha,hm,hilf,hhm;
/*  Spezialfall a = 1  */
	if ( a == 1 ) return( 1 );
/**/
/*  Spezialfall m = 1  */
	if ( m == 1 ) return( 1 );
/**/
	init( hhm ) ;
	bind( a, m );
	a = mihoms( m , a );
	do {
/* erster Ergaenzungssatz   */
		if ( isign(a) < 0 ) {
			a = ineg( a );      
			hhm = idif( m, 1 );
			hhm = iquot( hhm, 2 );
			if ( iodd( hhm )  ) s = -s;
		}
/**/
		e2 = imp2d( a );
/* zweiter Ergaenzungssatz */
		if ( sodd(e2) ) {
			a = ip2quot( a , e2 );   
			hhm = iprod(m, m );
			hhm = idif( hhm, 1 );
			hhm = iquot( hhm , 8 );
			if ( iodd( hhm )  ) s = -s;
		}
/**/
/* Reziprozitaetsgesetz  */
		if ( a != 1 ) {
			hilf = a;
			a = m;
			m = hilf;   
			hhm = idif( a,  1 );
			hhm = iquot( hhm, 2 );
			if ( iodd( hhm )  ) {     
				hhm = idif( m, 1 );
				hhm = iquot( hhm, 2 );
				if ( iodd( hhm )  ) s = -s;
			}
			a = mihoms( m , a );
		}
/**/
	} while ( a != 1 );
	return( s );
}
