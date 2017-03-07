/*M
.SH NAME
picran - polynomials over integers chinese remainder algorithm, n arguments, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol picran(r, n, LM, LP)  
single r, n; 
list LM, LP;
  
.SH DESCRIPTION
.TP 4
.B r, n
are integer numbers, 0 < r, n < BASIS.
.TP 4
.B LM 
= ( M1, ..., Mn)
is a list consisting of n coprime integer numbers.
.TP 4
.B LP 
= ( P1, ..., Pn)
is a list consisting of n polynomials Pi, where
for 1 <= i <= n:
.IP 
Pi is a polynomial in r variables over Z/(Mi*Z).
.PP
Let M := M1 * ... * Mn, then picran returns the unique polynomial P over Z/M*Z, with
.IP
P congruent Pi modulo Mi, for i = 1, ..., n.

M*/

/*H
	Version 1	11.07.1994	S. Schmitt
   DATE picran	      : 941201
H*/

# include <_pol1.h>

int picran(r,n,LM,LP)
single r,n;
list LM,LP;
{  
	single i, k;
	int M1,M2,P1,P2,N1;
	list MM,MP,M;

	bind(LM,LP);
	init(M1,M2,P1,P2,N1,MM,MP,M);

	/*    Spezialfall : n = 1    */
	if ( n == 1 ) return(lfirst(LP));

	/*    Spezialfall : n = 2    */
	if ( n == 2 ) {
		M1 = lfirst(LM);
		M2 = lsecond(LM);
		P1 = lfirst(LP);
		P2 = lsecond(LP);
		N1 = miinv(M2,mihom(M2,M1));
		return(picra(r,P1,P2,M1,M2,N1));
	}

	/*    allgemeiner Fall : n >= 3	   */
	else {	      
		k = n/2;
		MM = _0; MP = _0; N1 = 1;     
		for( i=1; i <= k; i++ )
		{	P1 = lfirst( LP );
			LP = lred( LP );
			MP = lcomp( P1, MP );
			M1 = lfirst( LM ); 
			N1 = iprod( N1, M1 );
			LM = lred( LM );
			MM = lcomp( M1, MM );
		}
		M = LM; M2 = 1;
		while( M != _0 )
		{	M2 = iprod( M2, lfirst( M ) );
			M = lred( M );
		}		
		P1 = picran( r, k, MM, MP );
		P2 = picran( r, n-k, LM, LP );
		M1 = miinv(M2,mihom(M2,N1));
		return( picra( r, P1, P2, N1, M2, M1 ) );		
	}

}
