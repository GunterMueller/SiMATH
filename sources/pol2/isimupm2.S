/*M
.SH NAME
isimupm2 - is irreducible, monic, univariate polynomial modulo 2?

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isimupm2(A)  
obj A;

.SH DESCRIPTION
.PP
isimupm2 returns 1, if A is an univariate, monic and irreducible polynomial over Z/2Z, and 0 else (also in the case A = 0).

M*/
                      
/*H
	Version 1 	20.10.95	Marc Conrad	
   DATE isimupm2      : 951201
H*/

/* 
   Der Algorithmus ist im grossen und ganzen der gleiche
   wie in isimupmi(2, A)
*/



#include<_pol2.h>

/* Entspricht dem macup in isimupmii Achtung! Zeilen sind anders, 
es kommt also nicht die gleiche Matrix heraus.
*/
list ptozeile(n, i, p) 
	single n, i; 
	list p; 
	{ 
	single s, zz, u, z; 
	list Z; 

	bind( p ); 
	init( Z ); 

 	u = 29; 	
	Z = _0; 
	z = 0; 
	p = linv(p); 

	for(zz = 0; zz < n; zz++, u-- ) { 
		if( u == -1 ) { 
			u = 29; 
			Z = lcomp(z, Z); 
			z = 0; 
		        }	
		if( p != _0 && lsecond(p) == zz )  { 
			s = 1; 
			p = lred2(p); 
			} 
		else s = 0; 
	        if( zz == i ) s = s ^ 1; 
		if( s ) z = z | (1<<u); 
		}
	z = z >> (u+1);
	Z = lcomp(z, Z); 
	
	return( Z); 

	} 


single isimupm2(A)
obj A;
{
	single n,i,j;
	list a,Q,M, Z;

	bind(A);
	init(a,Q,M, Z);

	if ( !A || !ispmi(1,2,A) ) return(0);
	if ( lsecond(A) != 1 ) return(0);

	n = lfirst(A);
	if ( n <= 1 ) return(1);

	Q = list2(0,1);
	if (   !oequal( upmigcd(2,A,pmideriv(1,2,A)), Q)   ) return(0);

	Q  = upmibqp(2,A);
	M = _0;
		
	for(i=0; i<n; i++ ) { 
		Z = ptozeile(n,i,lfirst(Q)); 
	 	Q = lred(Q); 
		M = lcomp(Z, M); 
		}
	
		
	M = lcomp(n, M); 
	a = mam2nzc(M,2); 
	if( a != 1 ) return 0; 
	
	return(1);
}

