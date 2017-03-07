/*M
.SH NAME
ippnferegul2 - integral p-primary number field element regulation, version2

.SH SYNOPSIS
.nf
#include<_arith2.h>

rat ippnferegul2(F, p, Q, a0, mpa0, pa1, pa2)   
pol F, a0, mpa0, *pa1, *pa2; 
single p; 
int Q;
 
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic,  separable and univariate polynomial over the integer numbers.
.TP 4
.B p
is a prime number.
.TP 4
.B Q
is a power of p, the product of Q and an arbitrary element in a p-maximal overorder of the polynomial order of F is in the polynomial order.
.TP 4
.B a0
is a p-primary element in A, represented by a CD polynomial (s. cdprfcl), the minimal polynomial of a0 is of the same degree as F.
.TP 4
.B mpa0
is the unique (modulo p) prime polynomial divisor of the minimal polynomial of a0 over the integer numbers, so it is a monic and univariate polynomial over Z/pZ, the
degree of mpa0 must be smaller than the degree of F.
.TP 4
.B *pa1 ,*pa2
are integer elements in A, represented as CD-polynomials.
*pa1 arises by inserting a0 into mpa0.
.PP                                                         
ippnferegul2 returns the p-star value of *pa1 (s.infepstarval).
v is a rational number, and by construction greater than zero.
.PP
Let v1 be the denominater of v, then *pa2 has the p-star value 1/v1.

.SH NOTES
In difference to ippnferegul1, ippnferegul2 uses nfespecmpc2 and infeminpmpp, i.e. eventually the minimal polynomial only will be computed modulo a power of p (s.nfespecmpc2).

.SH SEE ALSO
 cdprfcl
 infepstarval
 nfespecmpc2
 infeminpmpp 
.PP
Literature: Dissertation D.J.Ford, p.45-46, or
.PP
            Diplomarbeit von R. Boeffgen p.60,
            Universitaet des Saarlandes.             

M*/

/*H
	Version 1       01.06.89        J.Schmitt                       
	Version 2	30.12.89	J.Schmitt
					Sicherung von *pa1 und *pa2.
					Aufruf von nfespecmpc2 geaendert.
   DATE ippnferegul2  : 891101.900101.9109__.9203__
H*/

#include<_arith2.h>

rat ippnferegul2(F,p,Q,a0,mpa0,pa1,pa2)
pol F;
single p;
int Q;
pol a0,mpa0;
pol *pa1,*pa2;
{
	single el,elp,dl,dlp,kl,jl,ll,e,e1,e2,vlz,wlz;
	int ml;
	rat vl, jlp;
	pol a1, a2, ma1, zlb;
	list L;
	init(ml,vl,jlp,a1,a2,ma1,zlb,L);
	bind(F,Q,a0,mpa0);

	e = 0;
	a1 = upinfeevals(F,mpa0,a0);
	dl = 1;
	el = lfirst(F) + 1;
	ma1 = 0;

	for ( ; ; ) {
		e2 = 1;
		if ( !e ) {
	        	if (a1) { 
				do {
					dl = dl + dl;
					ml = iexp(p,dl);
					zlb = cdprzmodhom(a1,ml);
				} while ( zlb == 0 );
			}
		}
		for ( ; ; ) {
			e1 = 0;
			if ( ma1 == 0 ) {
				ma1 = nfespecmpc2(F,zlb); 
				if ( ma1 != 0 ) {
					e1 = 1;
					vl = infepstarval(p,ma1);
					ma1 = 0;
					dlp = rfloor(vl) + 1;
					break;
				}
			}
			ma1 = infeminpmpp(F,zlb,p,el,Q);
			if ( lred2(ma1) == _0 ) el = el + el;
			else break;
		}
		if ( !e1 ) {
			vl = infepstarval(p,ma1);
			dlp = rfloor(vl) + 1;
			kl = lfirst(ma1) + 1;
			L = sclfupi(ma1,kl);
			ml = 1;
			jl = 0;
			while ( (ml!=0) && (L!=_0) ) {
				ml = lfirst(L);
				L = lred(L);
				jl++;
			}
			if ( !ml ) {
				jl = (kl-jl);
				elp = rceil(vl);
				elp = elp * jl;
				if ( el < elp ) {
					el = elp;
					if ( dlp < dl ) {
						dl = dlp / 2;
						e = 0;
						e2 = 0;
					}
					else {
						e = 1;
						e2 = 0;
					}
				}
			}
		}
		if (e2) {
			jlp = list2(dl,1);
			if ( rcomp(jlp,vl) < 1 ) e = 0;
			else break;
		}
	}

	ml = iexp(p,dlp);
	a2 = cdprzmodhom(a1,ml);
	vlz = rnum(vl);
	wlz = rden(vl);
	if ( vlz > 1 ) {
		jl = segcd(vlz,wlz,&kl,&ll);
		if ( kl <= 0 ) {
			kl = kl + wlz;
			ll = ll - vlz;
		}
		if ( wlz == 1 ) jl = 2;
		ml = iexp(p,(jl-ll));
		a2 = nfeexpspec(F,a2,kl,ml);
		ml = isquot(ml,p);
		if ( jl == 2 ) ml = isquot(ml,p);
		a2 = cdpriquot(a2,ml);
	}       
	*pa1 = a1;
	*pa2 = a2;
	return(vl);
}
