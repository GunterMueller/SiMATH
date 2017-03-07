/*M
.SH NAME
marlllred - matrix of rationals, LLL reduction

.SH SYNOPSIS
.nf
#include<_arith2.h>

list marlllred(B)  
list B; 
 
.SH DESCRIPTION
.TP 4
.B B
is an n x n matrix over Q with n > 0, such that the rows of B form n over Q linearly independent vectors in Q^n.
.PP
marlllred returns an LLL reduced matrix whose rows generate the same Z-module as the rows of B, or 0 in case of an error occurs.
.SH CAUTION
The original matrix will be changed.
 
.SH SEE ALSO
Literature: Ann. 261, 515-534 (1982).

M*/
                                 
/*H
	Version 1	08.08.1991	J.Schmitt
	Version 2	10.09.1992	2 x list2(itor(), ) aufgeloest.  PS
   DATE marlllred     : 910915.9203__.921130.9305__.9311__
H*/

#include<_arith2.h>

static list marlllredsub(single,single,list,list*);

list marlllred(bas)
list bas;
{
	single n, k, l, i, j;
	list M, B, mk, ek, Bk, Bu, mu, ne;
	rat dv, eh;
	bind(bas);
	init(M,B,mk,ek,Bk,Bu,mu,ne,dv,eh);
               
        M  = modiorthobas(bas);
	B  = lsecond(M);
        M  = lthird(M);      
	dv = list2(3,4);
	eh = list2(1,2);
	ne = list2(0,itor(1));
	n = llength(bas);
	k = 2;
	for ( ; ; ) {
		for ( ; ; ) {
			l = k - 1;
			mk = lelt(lelt(M,l),l);
			if ( rcomp(rabs(mk),eh) > 0 ) {
				M = marlllredsub(k,l,M,&bas);
				leset(bas,k,lfirst(M));
				M = lsecond(M);
			}
			Bk = B;
			for (i=2;i<k;i++) Bk = lred(Bk);
			mu = lelt(lelt(M,l),l);
			ek = lfirst(Bk);
			Bu = rprod(rprod(mu,mu),ek);
			mk = lsecond(Bk);
			Bu = rsum(Bu,mk);
			ek = rquot(mk,ek);
			mk = rdif(dv,rprod(mu,mu));
        	        if ( rcomp(mk,ek) > 0 ) break;
			ek = lelt(M,k-1);
			while( l > 1 ) {
				l = l - 1;
				mk = lelt(ek,l);
				if ( rcomp(rabs(mk),eh) > 0 ) {
					M = marlllredsub(k,l,M,&bas);
					leset(bas,k,lfirst(M));
					M = lsecond(M);
				}
			}
                	if ( k == n ) return(bas);
			k = k + 1; 		
		}
		Bk = B;
		for (i=2;i<k;i++) Bk = lred(Bk);
		ek = lfirst(Bk);
		mk = lsecond(Bk);
		mk = rquot(rprod(mk,ek),Bu);
		ek = rquot(rprod(ek,mu),Bu);
		lsfirst(Bk,Bu);
		Bk = lred(Bk);
		lsfirst(Bk,mk);
		mk = lelt(M,l);
		leset(mk,l,ek);
		lerot(bas,l,k);								
		if ( l > 1 ) {
			lerot(M,l-1,l);
			mk = lelt(M,l);
			leset(mk,l,ek);
			mk = lelt(M,l-1);
			leset(mk,l,0);
		}
		mu = rneg(mu);
		mu = list1(mu);
		mu = lcomp(itor(1),mu);
		mu = list2(ne,mu);
		ek = list1(ek);
		ek = lcomp(itor(1),ek);
		ek = list2(ek,ne);
		mu = marprod(ek,mu);
		for (i=k;i<n;i++) { 
			mk = lelt(M,i);
			for (j=2;j<k;j++) mk = lred(mk);
			ek = lfirst(mk);
			ek = list2(ek,lsecond(mk));
			ek = marvecmul(mu,ek);
			lsfirst(mk,lfirst(ek));
			mk = lred(mk);
			lsfirst(mk,lsecond(ek));
		}
		if ( k > 2 ) k = k - 1;
	}
}

/*c
	marlllredsub ist ein static modul zu marlllred
c*/
/*H
	Version 1	08.08.91	J.Schmitt
H*/

static list marlllredsub(z1,z2,B1,pB2)
single z1, z2;
list B1;
list *pB2;
{          
	single i, j;
	list m1, m2, r1, r2;
	rat r;
	bind(B1,*pB2);
	init(m1,m2,r1,r2,r);

	m1 = lelt(lelt(B1,z1-1),z2);
        r  = rfloor(m1);
	r2 = rceil(m1);
	r1 = rdif(m1,itor(r));
	r2 = rdif(itor(r2),m1);
	m2 = rcomp(r1,r2);
	if ( m2 > 0 ) r = rceil(m1);
	else if ( m2 == 0 && rcomp(0,m1) > 0 ) r = rceil(m1);
	r  = rneg(itor(r));
	r1 = lelt(*pB2,z1);
	r2 = lelt(*pB2,z2);
	m1 = vecrlc(itor(1),r,r1,r2);
	r1 = lelt(B1,z1-1);
	if ( z2 > 1 ) {
		r2 = lelt(B1,z2-1);
		for (i=1;i<z2;i++) {
			m2 = rprod(r,lfirst(r2));
			m2 = rsum(m2,lfirst(r1));
			lsfirst(r1,m2);
			r1 = lred(r1);
			r2 = lred(r2);
		}
	}
	m2 = rsum(r,lfirst(r1));
	lsfirst(r1,m2);
	m1 = list2(m1,B1);
	return(m1);
}
