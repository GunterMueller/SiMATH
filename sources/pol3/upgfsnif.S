/*M
.SH NAME
upgfsnif - univariate polynomial over Galois-field with single characteristic number of irreducible factors

.SH SYNOPSIS
.nf
#include<_pol3.h>

single upgfsnif(p, AL, P)  
single p; 
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
.B P 
is an univariate, monic and squarefree polynomial over GF(p^n) of positive degree.
.PP
upgfsnif returns the number of monic and irreducible factors of positive degree of P.
 
.SH SEE ALSO
gfsalgen

M*/
                       
/*H
	Version 1	13.07.88	J.Schmitt
   DATE upgfsnif      : 890501.9203__
H*/


# include <_pol3.h>

single upgfsnif(p,AL,P)
single p;
list AL;
pol P;
{
	gfel a;
	single n,i,j;
	list Q,Q1,P1,B,B1,C,L;

	bind(P,AL);
	init(a,Q,Q1,P1,B,B1,C,L);

/*    Spezialfall : Grad(P) == 1    */
	if ( lfirst(P) == 1 ) return(1);

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

	/*    Berechnung einer Nullraumbasis von Vektoren fuer Q */
	Q  = matransp(Q);
	B1 = magfsnsb(p,AL,Q);
	return(llength(B1));

}
