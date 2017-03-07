/*M
.SH NAME
isbaslllred - is basis over the integers LLL - reduced ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isbasilllred(bas)  
list bas;
  
.SH DESCRIPTION
.TP 4
.B bas
= (b_1 ... b_n)
is a list of length n > 0, where the b_i's (i = 1, ..., n) are also lists, each consisting of n rational numbers. Each b_i represent a vektor in Q^n. The b_i's are linearly independent over Z.
.PP
isbaslllred returns a positive number, if that basis (with regard to the order above) is not LLL-reduced, and 0 if the basis is LLL-reduced.
  
.SH SEE ALSO
For LLL-reduced s. Math.Ann. 261, 515-524 (1982). 

M*/

/*H
	Version 1	08.08.91	J.Schmitt
   DATE isbasilllred  : 910915
H*/

#include<_arith2.h>

single isbasilllred(bas)
list bas;
{                  
	single i, j, n;
	rat fi;
	list M, M1, M2, M3;
	bind(bas);
	init(fi,M,M1,M2,M3);
	            
	n  = llength(bas);              
	fi = list2(1,2);
        M  = modiorthobas(bas);
	M1 = lthird(M);
	for(i=1;i<n;i++) 
	{
		for(j=1;j<=i;j++) {
			M2 = lelt(M1,i);
			M2 = lelt(M2,j);
			if ( rcomp(rabs(M2),fi) > 0 ) {
				i++;
				j = 1000 * j + i;
				return(j);

			/* | m_(i+1,j) | > 1/2 !!! */
			}
		}
	}
	fi = list2(3,4);
	M1 = lfirst(M);
	M3 = lthird(M);
	for(i=1;i<n;i++) {
		M2 = lfirst(M1);
		M  = rprod(fi,vecrsprod(M2,M2));
		M2 = lelt(lelt(M3,i),i);
		M2 = vecrsmul(M2,lfirst(M1));
		M1 = lred(M1);
		M2 = vecrsum(M2,lfirst(M1));
		M2 = vecrsprod(M2,M2);
		if ( rcomp(M2,M) < 0 ) return(i);

                /* Gleichung (1.5.) nicht erfuellt fuer i !!! */
	}
	return(0);
}
