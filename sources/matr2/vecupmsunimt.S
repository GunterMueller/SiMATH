/*M
.SH NAME
vecupmsunimt - vector of univariate polynomials over modular single primes, unimodular transformation

.SH SYNOPSIS
.nf
#include<_matr2.h>

single vecupmsunimt(p, V, W, i, pV1, pW1)
single p,i;
vec V,W,*pV1,*pW1;

.SH DESCRIPTION
vecupmsunimt() computes the two vectors *pV1 and *pW1
of polynomials in one variable over Z/pZ and returns 0.  
*pV1 and *pW1 are linear combinations of V and W
and for v=V[i] and w=W[i] it holds that
*pV1[i]=gcd(v,w) and  *pW1[i]=0.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B V,W
are vectors of polynomials in one variable over Z/pZ.
V and W must have equal length.
.TP 4
.B i
must be a valid index for V and W.
.TP
.B *pV1,*pW1
are assigned vectors of polynomials in one variable over Z/pZ
as described above.

.SH SEE ALSO
veciunimtr

M*/
/*H
	Version 1       15.12.89        J.Schmitt
   DATE vecupmsunimt  : 901120
H*/

#include<_matr2.h>

single vecupmsunimt(p,V,W,i,pV1,pW1)
single p,i;
vec V,W;
vec *pV1,*pW1;
{
	pol v,w,v1,w1,v2,w2;
	init(v,w,v1,w1,v2,w2);                         
	bind(V,W);

	v = lelt(V,i);
	w = lelt(W,i);
	w2 = upmsegcd(p,v,w,&v1,&w1);
	if ( w2 == 0 ) v2 = 0;
	else {
		v2 = pmsquot(1,p,w,w2);
		v2 = pmsneg(1,p,v2);
		w2 = pmsquot(1,p,v,w2);
	}
	v=vecpmslc(1,p,v1,w1,V,W);
	*pW1=vecpmslc(1,p,v2,w2,V,W);
	*pV1=v;
	return(0);
}
