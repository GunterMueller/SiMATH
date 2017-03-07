/*M
.SH NAME
nffielddiscr - number field, field discriminant

.SH SYNOPSIS
.nf
#include<_arith2.h>

list nffielddiscr(F)  
pol F;
  
.SH DESCRIPTION
.TP 4
.B F
is a monic, irreducible and univariate polynomial in dense representation over Z, deg(F) > 1.
.PP
Let z be a root of F and K be the number field Q(z).
.PP
nffielddiscr returns a list (p_1 e_1 ... p_r e_r), representing the field discriminant of K (say d_K), i.e. 
.IP
d_K = p_1^e_1 * ... * p_r^e_r.
.PP
For d_K = 1, nffielddiscr returns the empty list.
 
M*/
                
/*H
	Version 1       09.08.91	J.Schmitt
	Version 2       24.09.91	J.S. ouspibaslmoi eingebaut
   DATE nffielddiscr  : 910915.910930
H*/

#include<_arith2.h>

list nffielddiscr(F)
pol F;
{
	list L,Lk,B,M,H;
	single n,i,k,e;
	int p,Q,rd,c;
	init(L,Lk,B,M,H,p,Q,rd,c);
	bind(F);

	F   = dptop(1,F);
	rd  = upireddiscc(F,&c);
	L   = rdiscupifact(rd,c,&Lk);
	M   = Lk;
	B   = _0;
	while ( Lk != _0 ) {
		e = lsecond(Lk);
		if ( e != 1 ) {
			p = lfirst(Lk);      
			if ( oupidedekmt(p,F) ) {
				Q  = iexp(p,lsecond(L));
				B  = lcomp2(p,Q,B);
			}
		}
		L  = lred2(L); 
		Lk = lred2(Lk);
	}

	if ( B == _0 ) return(M);
	do {
		p = lfirst(B);
		B = lred(B);
                Q = lfirst(B);
                B = lred(B);
		if ( issingle(p) ) ouspibaslmo(F,p,Q,&k);
		else ouspibaslmoi(F,p,Q,&k);
		H = _0;
		while ( M != _0 ) {
			Q = lfirst(M);
			M = lred(M);
			e = lfirst(M);
			M = lred(M);
			if ( !icomp(p,Q) ) e = e - 2*k;
			if (e) {
				H = lcomp(Q,H);
				H = lcomp(e,H);
			}
		}
		if ( H != _0 ) M = linv(H);
	} while ( B != _0 );         
	return(M);
}
