/*M
.SH NAME
rdiscupifact - reduced discriminant and discriminant of an univariate polynomial over the integers, factorization

.SH SYNOPSIS
.nf
#include<_arith2.h>

list rdiscupifact(rd, c, pL)  
int rd, c; 
list *pL;
 
.SH DESCRIPTION
.TP 4
.B rd 
is the reduced discriminant of an univariate polynomial over the integer numbers.
.TP 4
.B c
is the content of the resultant equation, in all likelihood, c is equal to the quotient of the origin discriminant and the reduced discriminant.
.TP 4
.B pl
points to the list *pL.
.PP
rdiscupifact returns a list, say L       
.PP 
 L = (p_0 1 p_1 m_1 ... p_t m_t) or
 L =       (p_1 m_1 ... p_t m_t), whereby for 1 <= i <= t,
.TP 4
p_0 
is squarefree,
.TP 4
p_i
is a prime number with p_i < p_j for i < j, and
.TP 4
m_i
is a positive integer number, so that
.PP
rd = p_0 * p_1^m_1 * ... * p_t^m_t.
.PP
The factorization of the origin discriminant will be writen to *pL (in the same way as above).

M*/
                          
/*H
	Version 1	08.05.1989	J.Schmitt
	Version 2	04.07.1991	ueberfl. Variable s beseitigt.	PS
	Version 3	16.06.1992	lcomp2 -> 2 x lcomp.  MC
	Version 4	01.02.1994	ispt -> isiprime	GJL
   DATE rdiscupifact  : 891101.9001__.910715.9203__.921130.941201
H*/

#include <_arith2.h>

list rdiscupifact(rd,c,pL)
int rd,c;
list *pL;
{
	list Lr, Lc, L2, L3;
	single t;
	int A,d1,d,pl,el,rl;
	init(Lr,Lc,L2,L3,A,d1,d,pl,el,rl);
	bind(rd,c);

	d = igcdcf(rd,c,&d1,&rl);
	d1=iabs(d1);
	Lc=ifact(d);
	Lc=ifel(Lc);

	L2=Lc;
	while(L2 != _0) {
		pl = lfirst(L2);
		L2 = lred(L2);
		el = lfirst(L2);
		d = d1;
		rl = 0;
		while (rl == 0) {
			el = isum(el,1);
			d1 = d;
			iqrem(d1,pl,&d,&rl);
		}
		lsfirst(L2,idif(el,1));
		L2 = lred(L2);
	}

	/* Suche nach kleinen Primteilern */
	L2 = ispd(d1,&d);
	L2=ifel(L2);
	d1=d;
	A=1000;

	t = 0;
	for ( ; ; ) {
		d=isqrt(d1);
		if (icomp(iprod(d,d),d1)==0) { t = 1; break; }

		if (isiprime (d1))	break;

		el = iroot(d1,3,&rl);
		if (icomp(A,el) >= 0) break;
		pl = impds(d1,A,el,&rl,&d);
		if (icomp(pl,1) == 0) break;
		el = 0;
		rl = 0;
		while ( rl == 0 ) {
			el = isum(el,1);
			d1 = d;
			iqrem(d1,pl,&d,&rl);
		}
		L2 = lcomp2(pl,el,L2);
		A = pl;
	}
	if (t == 1) {
		Lr = ifact(d);
		Lr = ifel(Lr);
		Lr = ifelprod(Lr,Lr);
		L2 = lconc(Lr,L2);
		d1 = 1;
	}
	if (icomp(d1,1) != 0) L2=lcomp2(d1,1,L2);
	Lr = ifelprod(L2,Lc);

	L3 = _0;
	d1 = c;
	while (Lc != _0) {
		d = d1;
		pl = lfirst(Lc);
		Lc=lred(Lc);
		el = lfirst(Lc);
		Lc=lred(Lc);
		rl = 0;
		while (rl == 0) {
			el = isum(el,1);
			d1 = d;
			iqrem(d1,pl,&d,&rl);
		}			   
		L3 = lcomp( pl, L3 );
		L3 = lcomp( idif( el, 1 ), L3 );

	}
	L3=linv(L3);
	*pL=ifelprod(L3,L2);
	return(Lr);
}
