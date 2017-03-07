/*M
.SH NAME
pmidiscr - polynomial over modular integers discriminant

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmidiscr(r, p, P, n)  
single r, n; 
int p; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a polynomial in r variables over Z/pZ.
.TP 4                                                                           
.B n                                                                            
is an integer number, 1 <= n <= 3.
.PP                                                                             
pmidiscr returns the discriminant, say P1, of P with regard to the main variable, so P1 is a polynomial in r-1 variables.     
.PP                                                                             
The value of n determines the algorithm used by pmidiscr as follows : In the case n < 2, pmidiscr computes the resultant of P and its derivation, namely 
.IP
 n = 1: computation of the determinant of the                                   
        Sylvester matrix (s. psylvester),                                       
 n = 2: Collins algorithm (s. pmirescoll).
.PP
In the case n = 3, pmidiscr uses the Hankel matrix for the one-level computation of the discriminant (s. pmidiscrhank).
In case of doubt, you should try n = 3, especially if P is monic with regard to 
the main variable.  
.PP
For r = 1, pmidiscr uses the Collins algorithm, in the case of p divides deg(P1), pmidiscr always uses the Hankel matrix (even if r = 1).  

.SH CAUTION
In some cases, it could be possible that the Collins algorithm does not lead to a result, then pmidiscr returns ERROR.
   
.SH SEE ALSO
 psylvester
 pmidiscrhank
 pmirescoll

M*/

/*H
	Version 1       17.09.1992     	U.Schneiders   
	Version 2 	26.04.1993	M.Conrad (n=3 eingefuehrt)
   DATE pmidiscr      : 921130.930531
H*/


#include <_pol2.h>

pol pmidiscr(r, M, P, n)
	single r;
	int M;
	pol P;
	single n;
{
	single e;
	pol P1, P2;

	bind(M, P);
	init(P1, P2);

/* Berechnung der Diskriminante */             
	if ( pdegree( r, P ) == 0 ) return ( 0 );
	if (mihom(M, pdegree(r, P)) == 0)
		n = 3;
	if (n == 3)
		P1 = pmidiscrhank(r, M, P);
	else {
		P1 = pmideriv(r, M, P);
		if (r > 1) {
			if (n == 2)
				n = 3;
			P1 = pmires(r, M, P, P1, n);
		} else
			P1 = pmires(r, M, P, P1, 3);
		if (P1 != ERROR) {
			e = pdegree(r, P);
			P2 = plc(r, P);
			r--;
			P1 = pmiquot(r, M, P1, P2);
			if (e % 4 >= 2)
				P1 = pmineg(r, M, P1);
		}
	}
	return (P1);
}
