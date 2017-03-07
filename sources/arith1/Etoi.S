/*M
.SH NAME
Etoi - Essen integer to SIMATH integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

int Etoi( e )
LONG e[];

.SH DESCRIPTION
Etoi() returns the value of e as a SIMATH integer in list representation.
.PP
.TP 4
.B e
is a positive integer according to the conventions of the Essen arithmetic package

.SH SEE ALSO
Etoineg, itoE, itoEb, itoEsb
M*/

/*H
	Version  1      24.12.1991	Marc Conrad
   DATE Etoi          : 920331.9211__
H*/


#include<_list.h>
#include<_Earith.h>

#define uitosi( A ) ( (single) ( (A) & (~(3<<30)) ) )     
/* loescht die beiden obersten Bit */
#define lpmoc( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
lsfirst( A, (a) ); if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }
/* lpmoc <=> umgekehrtes lcomp */
int Etoi(e)
	LONG *e;

{           
	LONG *pe;
	int AA, A;           
	single o;

	init(AA);

	if ((o = e[0]) == 0)
		return (0);    
	else if ( ( o == 1 ) && ( e[1] < BASIS ) ) 
		return( (single) (e[1]) );
	else {                
		unsigned a, b, c, d, k=30, l=2, i=2;     
		single s;    
                                                   
		if ( AVAIL == _0 ) gc();   

		AA = AVAIL;   

		o = e[0];  
		pe = e + 1;     
		a = *(pe++);
		s = uitosi(a);        
		lpmoc( A, s )
		while (i <= o ) {    
			b = *(pe++);  
			i++;
			c = (a >> k);
			d = (b << l);   
			k -= 2; 
			l += 2;
			s = uitosi( c | d );    
			lpmoc( A, s );
			if ( l == 30 ) { 
				s = (single) ( b >> 2 );
				if( i > o ) { 
					if ( s ) lpmoc( A, s )   
					lsred( A, _0 );
					return ( AA );
					}
				lpmoc( A, s );  
				i++; 
				a = *(pe++);  
				lpmoc ( A, uitosi( a ) ) 
				k = 30;
				l = 2;
				}     
					
			else a = b;
			}
		s = (single) ( a >> k );    
		if( s ) lpmoc( A, s )
                lsred( A, _0 );
	return ( AA );     
	}
}
