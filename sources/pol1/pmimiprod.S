/*M
.SH NAME
pmimiprod - polynomial over modular integers, modular integers product, (recursive)
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmimiprod(r, M, P, A) 
single r; 
int A, M; 
pol P;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B M                                                                            
is an integer number, M > 0.                                                    
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/(M*Z).        
.TP 4
.B A
is element of Z/(M*Z).
.PP
pmimiprod returns the polynomial P1, where
.IP
P1 = A * P.
                                                                 
M*/                                                                             

/*H
	Version 1       09.05.88        R. Boeffgen
   DATE pmimiprod     : 890501
H*/


#include <_pol1.h>
 
pol pmimiprod( r, M, P, A )
single r;
int A,M;
pol P;
{
	pol P1;
	init( P1 );

   /*** P oder A Null ***/
	if (P==0 || A==0)  P1 = 0;

   /*** r Null ***/
	else if (r == 0)  P1 = miprod( M,P,A );

   /*** allgemeiner Fall ***/
	else {
		single e;
		pol F;
		init( F );
		bind( A,M,P );
		P1 = _0;
		r--;
		do {
			e = lfirst(P),  P = lred(P);
			F = lfirst(P),  P = lred(P);
			if (r)  F = pmimiprod( r,M,F,A );
			else  F = miprod( M,F,A );
			if (F)  P1 = lcomp2( F,e,P1 );
		}
		while (P != _0);
		if (P1 == _0)  P1 = 0;
		else  P1 = linv( P1 );
	}

   /*** Ergebnis ***/
	return( P1 );
}
