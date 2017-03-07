/*M
.SH NAME
upgfsbfact - univariate polynomial over Galois-field with single characteristic Berlekamp factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfsbfact(p, AL, P, d)  
single p, d; 
list AL; 
pol P;
    
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).    
.TP 4
.B d 
is an integer number, d < BASIS.
.TP 4
.B P
is a monic, squarefree and univariate polynomial of positive degree over GF(p^n), P is not allowed to have a prime polynomial divisor of degree smaller than d.
.PP
upgfsbfact returns a list, containing all monic and irreducible factors of P, which have positive degree.

.SH SEE ALSO
gfsalgen

M*/
                                                      
/*H
	Version 1	13.04.88	J.Schmitt
	Version 2       08.07.88        neu: Parameter d   &
					magfsnsb nicht mehr static.  JS
   DATE upgfsbfact    : 890501.9203__
H*/


# include <_pol3.h>

list upgfsbfact(p,AL,P,d)
single p,d;
list AL;
pol P;
{
	gfel a;
	single n,i,j;
	list Q,Q1,P1,B,B1,C,L;

	bind(P,AL);
	init(a,Q,Q1,P1,B,B1,C,L);

/*    Spezialfall : Grad(P) == 1    */
	if ( lfirst(P) == 1 ) return(list1(P));

/*    allgemeiner Fall : Grad(P) >= 2    */

	/*    Bildung der Matrix Q - I, zunaechst als Liste    */
	n = lfirst(P);
	Q = upgfsbqp(p,AL,P);
	Q = macup(n,Q);
	Q1 = Q;
	for ( i=0 ; i<=n-1 ; i++ ) {
		P1 = lfirst(Q1);
		for ( j=1 ; j<=i ; j++ ) P1 = lred(P1);
		a = lfirst(P1);
		a = gfsdif(p,AL,a,list2(0,1));
		lsfirst(P1,a);
		Q1 = lred(Q1);
	}

	/*    Berechnung einer Nullraumbasis von Vektoren fuer Q und
	      Umwandlung in Polynome    */
	Q  = matransp(Q);
	B1 = magfsnsb(p,AL,Q);
	B = _0;
	do {
		C = lfirst(B1); B1 = lred(B1);
		C = linv(C);
		i = n - 1;
		while ( lfirst(C) == 0 ) {
			i--;
			C = lred(C);
		}
		C = lcomp(i,C);
		C = dptop(1,C);
		B = lcomp(C,B);
	}
	while ( B1 != _0 );

	/*    eigentliche Faktorisierung    */
	L = upgfsbfls(p,AL,P,B,d);

	return(L);

}
