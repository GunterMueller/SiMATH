/*M
.SH NAME
upmsbfls - univariate polynomial over modular singles Berlekamp factorization, last step

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmsbfls(p, P, B, d)  
single p ,d; 
pol P; 
list B;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.
.TP 4                                                                           
.B P                                                                            
is an univariate monic and square-free polynomial over Z/pZ of degree > 1.      
.TP 4                                                                           
.B B                                                                            
= (B1, ..., Br) ; for r > 1;                                                    
 is a list of univariate and monic polynomials,                                 
 especially B1 = 1.                                                             
 The Bi's form a basis of the vector space of all                               
 polynomials C with deg(C) < deg(P) so that                                     
.IP                                                                             
    P divides C^p - C.                                                          
.TP 4                                                                           
.B d                                                                            
is an integer number, 0 < d < BASIS, so that P has no irreducible factor of degree < d. ( not checked by the function ! )
.PP
upmsbfls returns a list, consisting of all monic and irreducible factors of P with positive degree.

M*/

/*H
	Version 1         10.06.87      Pascale Serf
	Version 2         24.02.88      neu: upmsbfzm.  JS
	Version 3         30.05.88      neu: Aufruf von upmsbfzm abhaengig von
					     der Groesse des Moduls.  JS
	Version 4	02.04.1992	"while (1)"->"while (!llength(_0))".  PS
	Version 5	03.04.1992      lred(B) raus wegen Aend. v. mamsnsb.  JS
   DATE upmsbfls      : 890501.9109__.920331
H*/


# include <_pol2.h>

list upmsbfls(p,P,B,d)
single p,d;
pol P;
list B;
{
	single k,r,i,e,f,s,r1;
	pol B1,A1,C,c,Bz;
	list L,L1,L2,Lz;

	bind(P,B);
	init(B1,A1,C,c,Bz);
	init(L,L1,L2,Lz);

	/*    Spezialfall : P irreduzibel    */
	L = list1(P);
	r = llength(B);
	if ( r == 1 ) return(L);

	/*    allgemeiner Fall : Faktorisierung von P    */
	/*    B = lred(B);  1.Element von B war bei urspr. mamsnsb gleich 1 */
	k = 1;
	c = list2(0,1);

	do {
		L1 = _0;
		B1 = Bz = lfirst(B); B = lred(B);
		if ( oequal(B1,list2(0,1)) ) continue;
		/* Element 1 in B ist redundant */
		if (p>=40) Lz=upmsbfzm(p,r,P,Bz);

		do {
		    A1 = lfirst(L); L = lred(L);
		    e = lfirst(A1);
		    if ( e > d ) {
			s = 0;
			if (p>=40) L2=Lz;
			else L2=list1(1);
			i = 0;
			do {

			    if (p>=40) {
				r1=lfirst(L2);
				L2=lred(L2);
				if (r1!=0) {
					 r1=msneg(p,r1);
					 c=list2(0,r1);
					 B1=pmssum(1,p,c,Bz);
				}
				else B1=Bz;
			    }
			    C = upmsgcd(p,A1,B1);
			    f = lfirst(C);
			    if ( f > 0 ) {
				if ( f == e ) s = 1;
				else {
				    L1 = lcomp(C,L1);
				    A1 = pmsquot(1,p,A1,C);
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
			    if (p<40) {
				    B1=pmssum(1,p,c,B1);
				    i++;
			    }
			}
			while (L2!=_0 && s!=1 && i!=p);


		    }
		    L1 = lcomp(A1,L1);
		}
	    while ( L != _0 );
	    L = L1;
	}
	while ( !llength(_0) );		/* Bei "while (1)" meldet der Com- */
					/* piler des MX300 eine Warnung.   */
}
