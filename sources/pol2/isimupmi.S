/*M
.SH NAME
isimupmi - is irreducible, monic, univariate polynomial over modular integers ?

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isimupmi(p, A)  
int p; 
obj A;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.   
.PP
isimupmi returns returns 1, if A is an univariate, monic and irreducible polynomial over Z/pZ, and 0 else (also in the case A = 0). 

M*/
                  
/*H
	Version 1 	16.08.91	J.Schmitt
	Version 2	20.10.95	Spez.fall p=2: M. Conrad
   DATE isimupmi      : 910915.951201
H*/

# include <_pol2.h>

single isimupmi(p,A)
int p;
obj A;
{
	single n,i,j;
	list a,Q,Q1,P,B1,L;

	bind(p,A);
	init(a,Q,Q1,P,B1,L);
	

	if( p == 2 ) return ( isimupm2(A) ); 
	if ( !A || !ispmi(1,p,A) ) return(0);
	if ( lsecond(A) != 1 ) return(0);

	n = lfirst(A);
	if ( n <= 1 ) return(1);

	Q = list2(0,1);
	if (   !oequal( upmigcd(p,A,pmideriv(1,p,A)), Q)   ) return(0);

	Q  = upmibqp(p,A);
	Q  = macup(n,Q);
	Q1 = Q;
	for ( i=0 ; i<=n-1 ; i++ ) {
		P = lfirst(Q1);
		for ( j=1 ; j<=i ; j++ ) P = lred(P);
		a = lfirst(P);
		a = midif(p,a,1);
		lsfirst(P,a);
		Q1 = lred(Q1);
	}

	Q  = matransp(Q);
	B1 = maminsb(p,Q);
	if ( llength(B1) == 1 ) a = 1;
	else a = 0;

	return(a);
}
