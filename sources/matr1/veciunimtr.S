/*M
.SH NAME
veciunimtr - vector of integers unimodular transformation

.SH SYNOPSIS
.nf
#include<_matr1.h>

single veciunimtr(V, W, i, pV1, pW1)
vec V, W;
single i;
vec *pV1, *pW1;

.SH DESCRIPTION
veciunimtr() computes the two vectors *pV1 and *pW1
of integers and returns 0.  
*pV1 and *pW1 are linear combinations of V and W
and for v=V[i] and w=W[i] it holds that
*pV1[i]=gcd(v,w) and  *pW1[i]=0.

.PP
.TP 4
.B V,W
are vectors of integers.
V and W must have equal length.
.TP 4
.B i
must be a valid index for V and W.
.TP
.B *pV1,*pW1
are assigned vectors of integers
as described above.

.SH SEE ALSO
vecupmsunimt
M*/
/*H
	Version 1       15.05.89        J.Schmitt
	Version 2	30.12.90	J.Schmitt
					Sicherung von *pV1;
   DATE veciunimtr    : 891101.900101
H*/

#include<_matr1.h>

single veciunimtr(V,W,i,pV1,pW1)
vec V,W;
single i;
vec *pV1,*pW1;
{
	list V1;
	int c,v,w,v1,w1,v2,w2;
	init(V1,c,v,w,v1,w1,v2,w2);
	bind(V,W);

	v = lelt(V,i);
	w = lelt(W,i);
	c = iegcd(v,w,&v1,&w1);
	if ( c == 0 ) { v2 = 0; w2 = 0;}
	else {
		v2 = iquot(w,c);
		v2 = ineg(v2);
		w2 = iquot(v,c);
	}
	V1=vecilc(v1,w1,V,W);
	*pW1=vecilc(v2,w2,V,W);
	*pV1=V1;
	return(0);
}
