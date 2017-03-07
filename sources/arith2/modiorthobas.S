/*M
.SH NAME
modiorthobas - module over the integers, orthogonalized basis

.SH SYNOPSIS
.nf
#include<_arith2.h>

list modiorthobas(bas)  
list bas;
 
.SH DESCRIPTION
.TP 4
.B bas
= (b_1 ... b_n) is a list of lenght n (n > 0), whereat each b_i is also a list, containg n rational numbers. These b_i's represent n vectors in Q^n, which a
re linearly independent over Z (i.e. they form a base of a Z-module, say M). 
.PP
modiorthobas returns a list, say L, with L = (basstar Nq mij).
.TP 4
basstar
= (bs_1 ... bs_n) contains a orthogonalized base of M, according to the Gram-Schmidt process.
.TP 4
Nq
= (N_1 ... N_n) ,  where N_i is the scalar product of bs_i with itself.
.TP 4
mij
= (m_i,j) is a (n-1) x (n-1) matrix over Q, so that 
.IP
bs_i = b_i - (m_i,1 * bs_1 + ... + m_i,i-1 * bs_i-1).
.IP
holds.

M*/
   
/*H
	Version 1	08.08.91	J.Schmitt
   DATE modiorthobas  : 910915.9211__
H*/

#include<_arith2.h>

list modiorthobas(bas)
list bas;
{
	list mij,M,ZM,Bs,Bs2,Bl,Bl2,bst,OB;
	single i,j,n;
	bind(bas);
	init(mij,M,ZM,Bs,Bs2,Bl,Bl2,bst,OB);

	n  = llength(bas);
	Bs = _0;
	Bl = _0;
	M  = _0;
	OB = _0;

	for(i=1;i<=n;i++) {
		ZM  = _0;
		bst = lelt(bas,i);
		Bs2 = Bs;
		Bl2 = Bl;		
		for(j=1;j<i;j++) {
			mij = vecrsprod(bst,lfirst(Bs2));
			mij = rquot(mij,lfirst(Bl2));
			ZM  = lcomp(mij,ZM);
			bst = vecrlc(itor(1),rneg(mij),bst,lfirst(Bs2));
			Bs2 = lred(Bs2);
			Bl2 = lred(Bl2);
		}
		if ( i > 1 ) {
			for(j=i;j<n;j++) ZM = lcomp(0,ZM);
			ZM = linv(ZM);
			M  = lcomp(ZM,M);
		}
		OB = lcomp(bst,OB);
		Bs = lconc(Bs,list1(bst));
		Bl = lconc(Bl,list1(vecrsprod(bst,bst)));
	}
	OB = linv(OB);
	M  = linv(M);
	M  = list3(OB,Bl,M);
	return(M);
}
