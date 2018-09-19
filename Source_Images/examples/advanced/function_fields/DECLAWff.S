/*M
	Let Z/pZ (X) denote the rational congruence function field of
	characteristic p.
        For a given monic separable polynomial F(Y) in Z/pZ (X) [Y] and
	a given monic irreducible polynomial P(X) in Z/pZ [X], the program
	computes ramification indices and related residue class degrees
	of P in the ring of integers O of the algebraic congruence
	function field Z/pZ(X) (Y) / (F(Y) * Z/pZ(X) (Y)).
*M/
/*H
        Version 1       11.10.93        J. Schmitt
H*/
/*cS
        ZLGff ruft auf: isimupms, issprime, lcomp, linv, ouspprmsp1dl
		upmsaddval, upprmsp1disc
        Macros: getpms, getsi, lfirst, list1, list2, lred, lsecond
		lthird, pdegree, printf, putsi
Sc*/

#include<_simath.h>
main()
{                              
	pol F,P,f1,f2;
	list V,V2,L,L1,L2;
        single n,p,e2,e,k;

	init(F,P,f1,f2,V,V2,L,L1,L2);


	V  = list1(list1('X'));
	V2 = list2(list1('X'),list1('Y'));
	printf("\n Characteristic p = ");
	p  = getsi();

	while (1) {
		if ( issprime(p,&n) != 1 ) {
			printf("\n p not prime! p = ");
			p  = getsi();
                }
		else break;
	}

	printf("\n F ( in (Z/pZ [X]) [Y] ) = ");
	F  = getpms(2,p,V2);
	while(1) {
		if ( F == ERROR ) {
			printf("\n Input incorrect! F = ");
			F  = getpms(2,p,V2);
		}
		else if ( !upprmsp1disc(p,F) ) {
			printf("\n Discriminant of F is 0. F = ");
			F  = getpms(2,p,V2);
		}
		else  break;
	}

	n  = 0;
	k  = 0;

while (1) {                      

	if (n) {
		printf("\n\n p = 0  --> End of program!\n");
		printf(" New characteristic p = ");
		p  = getsi();
		if (!p) break;
		else {
		 while (1) {
		  if ( issprime(p,&n) != 1 ) {
		   printf("\n p not prime! p = ");
		   p  = getsi();
                  }
		  else break;
		 }
                }

		printf("\n F ( in (Z/pZ [X]) [Y] ) = ");
		F  = getpms(2,p,V2);
		while(1) {
			if ( F == ERROR ) {
				printf("\n Input incorrect! F = ");
				F  = getpms(2,p,V2);
			}
			else if ( !upprmsp1disc(p,F) ) {
				printf("\n Discriminant of F is 0. F = ");
				F  = getpms(2,p,V2);
			}
			else  break;
		}
	} /* if (n)  */
	n = 1;

while (1) {

	if (k) printf("\n\n 0#  --> new p and F.");
	k = 1;
	printf("\n Monic prime polynomial in (Z/pZ)[X]: P(X) = ");
	P  = getpms(1,p,V);
	if (!P) break;
	while(1) {
	    if ( P == ERROR ) {
		printf("\n Input incorrect! P(X) = ");
		P  = getpms(1,p,V);
	    }
            else 
	    if ( pdegree(1,P) < 1 || lsecond(P) != 1 || !isimupms(p,P) ) {
		printf("\n P had to be monic and irreducible! P(X) = ");
		P  = getpms(1,p,V);
            }
	    else break;
	}
	if (!P) break;

	f1 = upprmsp1disc(p,F);
	e  = upmsaddval(p,P,f1);
	if (!e) e = 2;
	else e = 2 * e + 2;	

	L = ouspprmsp1dl(p,F,P,e);
	P  = _0;
	L1 = _0;                                   
	while ( L != _0 ) {
		L2 = lfirst(L);
		L  = lred(L);
		f1 = lfirst(L2);
		n  = pdegree(1,f1);
		f1 = lsecond(L2);
		f2 = lthird(L2);
		e  = pdegree(1,f2);
		P  = lcomp(e,P);
		n  = n / e;
		L1 = lcomp(n,L1);
	}
	L1 = linv(L1);
	P = linv(P);

	printf("\n (P) = P_1 ^ ");
	e = 1;
	while ( 1 ) {
		e++;
		putsi(lfirst(L1));
		L1 = lred(L1);
		if ( L1 != _0 ) printf(" * P_%d ^ ",e);
		else break;
	}
	printf("\n\n with related residue class degree \n\n");
	printf("      ");
	while ( 1 ) {
		printf("  ");
		putsi(lfirst(P));
		P = lred(P);
		if ( P != _0 ) printf("      ,");
		else break;
	}    
}      /* while1 END */

}      /* while2 END */

}


