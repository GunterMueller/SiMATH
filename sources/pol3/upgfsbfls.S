/*M
.SH NAME
upgfsbfls - univariate polynomial over Galois-field with single characteristic Berlekamp factorization, last step

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfsbfls(p, AL, P, B, d)  
single p, d; 
list AL, B; 
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
is a monic, squarefree and univariate polynomial, deg(P) >= 2, P is not allowed to have a prime polynomial divisor of degree smaller than d
(upgfsbfls does not check the last condition).
.TP 4
.B B
= (B_1, ..., B_r), r > 0, is a list, containig monic and univariate polynomials over GF(p^n). These polynomials form a basis of the vector space of all polynomials C with deg(C) < deg(P), such that
.IP
P divides C^(p^n) - C holds.
.IP
(The linear independence of the B_i's will not be checked by upgfsbfls.)
.IP
B_1 is equal to 1.
.PP
upgfsbfls returns a list, containing all monic and irreducible factors of P, which have positive degree.
 
.SH SEE ALSO
gfsalgen

M*/
 
/*H
	Version 1       13.04.1988      J.Schmitt
	Version 2	02.04.1992	"while (1)"->"while (!llength(_0))".  PS
   DATE upgfsbfls     : 890501.9109__.920331
H*/


# include <_pol3.h>

list upgfsbfls(p,AL,P,B,d)
single p,d;
list AL;
pol P;
list B;
{
	gfel r1;
	single k,r,i,e,f,s;
	pol B1,A1,C,c,Bz;
	list L,L1,L2,Lz;

	bind(P,AL,B);
	init(r1,B1,A1,C,c,Bz,L,L1,L2,Lz);

	/*    Spezialfall : P irreduzibel    */
	L = list1(P);
	r = llength(B);
	if ( r == 1 ) return(L);

	/*    allgemeiner Fall : Faktorisierung von P    */
	B = lred(B);
	k = 1;

	do {
		L1 = _0;
		Bz = lfirst(B); B = lred(B);

		Lz=upgfsbfzm(p,AL,r,P,Bz);

		do {
		    A1 = lfirst(L); L = lred(L);
		    e = lfirst(A1);
		    if ( e > d ) {
			s = 0;
			L2=Lz;
			do {

			    r1=lfirst(L2);
			    L2=lred(L2);
			    if (r1!=0) {
					 r1=gfsneg(p,AL,r1);
					 c=list2(0,r1);
					 B1=pgfssum(1,p,AL,c,Bz);
				       }

			    else B1=Bz;

			    C = upgfsgcd(p,AL,A1,B1);
			    f = lfirst(C);
			    if ( f > 0 ) {
				if ( f == e ) s = 1;
				else {
				    L1 = lcomp(C,L1);
				    A1 = pgfsquot(1,p,AL,A1,C);
				    k = k + 1;
				    if ( k == r ) {
					L1 = lcomp(A1,L1);
					L = lconc(L1,L);
					return(L);
				    }
				    e = lfirst(A1);
				    if ( e == d ) s = 1;
				}
			    }

			}
			while (L2!=_0 && s!=1);


		    }
		    L1 = lcomp(A1,L1);
		}
	    while ( L != _0 );
	    L = L1;
	}
	while ( !llength(_0) );		/* Bei "while (1)" meldet der Com- */
					/* piler des MX300 eine Warnung.   */
}
