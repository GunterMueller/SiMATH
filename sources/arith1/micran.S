/*M
.SH NAME
micran - modular integer Chinese remainder algorithm, n arguments

.SH SYNOPSIS
.nf
#include<_arith1.h>

int micran(n,LM,LA)
single n;
list LM,LA;

.SH DESCRIPTION
micran() returns the uniquely determined element A
in Z/MZ which is congruent Ai modulo Mi for all i=1,...,n
where
.nf
- n is positive,
- LM = (M1,...,Mn) is a list of n co-prime integers,
- LA = (A1,...,An) is a list of n elements Ai in Z/Mi*Z
  for all i.

M*/
/*H
	Version 1       16.07.1987      Pascale Serf
	Version 2       26.09.1990      beschleunigt durch Karatsuba
					Ursula Schneiders
   DATE micran        : 890501.901120
H*/


# include <_arith1.h>

int micran(n,LM,LA)
single n;
list LM,LA;
{  
	single i, k;
	int M1,M2,A1,A2,N1;
	list MM,MA,M;

	bind(LM,LA);
	init(M1,M2,A1,A2,N1,MM,MA,M);

	/*    Spezialfall : n = 1    */
	if ( n == 1 ) return(lfirst(LA));

	/*    Spezialfall : n = 2    */
	if ( n == 2 ) {
		M1 = lfirst(LM);
		M2 = lsecond(LM);
		A1 = lfirst(LA);
		A2 = lsecond(LA);
		N1 = miinv(M2,mihom(M2,M1));
		return(micra(M1,M2,N1,A1,A2));
	}

	/*    allgemeiner Fall : n >= 3    */
	else {        
		k = n/2;
		MM = _0; MA = _0; N1 = 1;     
		for( i=1; i <= k; i++ )
		{	A1 = lfirst( LA );
			LA = lred( LA );
			MA = lcomp( A1, MA );
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
		A1 = micran( k, MM, MA );
		A2 = micran( n-k, LM, LA );
		M1 = miinv(M2,mihom(M2,N1));
		return( micra( N1, M2, M1, A1, A2 ) );		
	}

}
