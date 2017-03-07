/*M
.SH NAME
mamilanssle - matrix of modular integers, Lanczos algorithm for determining a solution of a system of linear equations

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mamilanssle(M, A, b, sym)
int M;
matrix A;
vec b;
single sym;

.SH DESCRIPTION
mamilanssle() tries to compute and return a solution of A*x=b.
If a non-trivial divisor T of M occurs when inverting in Z/MZ,
no solution will be computed and the list (_0, T) will be returned.

.PP
.TP 4
.B M
>1 is an integer.
.TP 4
.B A
is a mxn matrix over Z/MZ.
.TP 4
.B b
is a vector of length m over Z/MZ.
.TP 4
.B sym
is either 0 or 1, where 1 indicates that A is a symmetric matrix.

.SH NOTE
.PP
If A does not have full rank, the result may be incorrect.
.PP
mamilanssle() is very efficient for matrices with many zeroes.
.PP
In case there are small factors of M, they will probably be found
and no solution will be computed.
M*/
/*H
	Version 1	08.02.94	Joachim Schmitt
   DATE mamilanssle   : 941201
H*/

#include <_matr1.h>

vec mamilanssle(M,A,w,sym)
int M;
matrix A;
vec w;
single sym;
{
    matrix At;
    vec w0,w1,w2,v1,v2,x,D;
    int s0,s1,s2,s3,b,i;
    bind(M,A,w);
    init(At,w0,w1,w2,v1,v2,x,D,s0,s1,s2,s3,b,i);

    if(M==2) {
	At = lcopy(A);
	sym = mamsssle(2,At,w,&w1,&w2);
	return(w1);
    }

    b = w;
    for(;;) { /***********************************************/	
	
	if(!sym) {
		At = _0;
		At = lcopy(A);
		At = matransp(At);
		w  = mamivecmul(M,At,b);
	}
	w0 = w;
	
	if(sym) v1 = mamivecmul(M,A,w0);
	else {
		v1 = mamivecmul(M,A,w0);
		v1 = mamivecmul(M,At,v1);
	}

	s1 = vecmisprod(M,v1,v1);
	s2 = vecmisprod(M,w0,v1);
	if (!s2) {
	/* Abbruchkriterium : w^T * A * w = 0 */
		w1 = w0;
		while(w1!=_0) {
			if (lfirst(w1)) s2 = (-1);
			w1 = lred(w1);
		}
		/* w0 = w = 0 */ 
		if (s2==0) return(w0);
	}
	if (s2 >= 0) {
	    s0 = miinv(M,s2);
	    if (!s0) {
	    /* "kleine" Loesung, d.h. M faktorisiert */
		s3 = igcd(M,s2);
		s2 = list2(_0,s3);
		return(s2);
	    }

	    /* Initialisierung des Loesungsvektors */	
	    w1 = vecmisprod(M,w0,w0);
	    w1 = miprod(M,w1,s0);
	    x = vecmismul(M,w1,w0);
	
	    s1 = miprod(M,s1,s0);
	    w1 = vecmismul(M,s1,w0);
	    w1 = vecmidif(M,v1,w1);
	
	    for(i=1;icomp(i,M)<=0;i=isum(i,1)) {

		if(sym) v2 = mamivecmul(M,A,w1);
		else {
			v2 = mamivecmul(M,A,w1);
			v2 = mamivecmul(M,At,v2);
		}
		s2 = vecmisprod(M,w1,v2);
		if (!s2) {
		/* Abbruchkriterium: w1^T*A*w1 = 0, mit w1 = w_i */
			while(w1!=_0) {
				if (lfirst(w1)) s2 = (-1);
				w1 = lred(w1);
			}
			/* wi = w1 = 0 */ 
			if (s2==0) return(x); 
		}
		if (s2 < 0) {
			i  = isum(M,1);
			break;
		}
		s1 = miinv(M,s2);
		if (!s1) {
		/* "kleine" Loesung, d.h. M faktorisiert */
			s3 = igcd(M,s2);
			s2 = list2(_0,s3);	
			return(s2);
		}

		/* Zusammenbau der Loesung x nach der Formel: */
		/* x = b1*w1 + .... + bi*wi                   */
		s2 = vecmisprod(M,w1,w);
		s2 = miprod(M,s1,s2);
		x  = vecmisum(M,x,vecmismul(M,s2,w1));

		s2 = vecmisprod(M,v2,v2);		
		s3 = vecmisprod(M,v2,v1);		
		s2 = miprod(M,s2,s1);
		s3 = miprod(M,s3,s0);
		w2 = _0;
		v1 = w1;
		D  = v2;		
		while (w0!=_0) {
			s0 = lfirst(w0);
			w0 = lred(w0);
			s0 = miprod(M,s0,s3);
			s0 = misum(M,s0,miprod(M,lfirst(v1),s2));
			v1 = lred(v1);
			s0 = midif(M,lfirst(D),s0);
			D  = lred(D);
			w2 = lcomp(s0,w2);
		}
		w2 = linv(w2);

		s0 = s1;
		w0 = w1;
		w1 = w2;
		v1 = v2;
	    }   /* end for i=1, ..., M */
	}

	/* randomisierte Konstruktion von D (als Vektor) */
	D  = _0;
	s1 = idif(M,1);
	for(s0=llength(w);s0;s0--) {
		s2 = irand(s1);
		s2 = isum(s2,1);
		s3 = igcd(M,s2);
		if (icomp(s3,1)) {
	        /* "kleine" Loesung, d.h. M faktorisiert */
			v1 = list2(_0,s3);
			return(v1);
		}
		D  = lcomp(s2,D);
	}
	/* Berechnung von D * w, w wird zerstoert */
	v1 = D;
	w0 = _0;
	while (v1!=_0) {
		s0 = miprod(M,lfirst(v1),lfirst(b));
		v1 = lred(v1);
		b  = lred(b);
		w0 = lcomp(s0,w0);
	}
	b  = linv(w0);

	/* Berechnung von D * A, A wird zerstoert */
	v2 = D;
	w1 = _0;
	while (v2!=_0) {
		v1 = lfirst(A);
		A  = lred(A);
		s1 = lfirst(v2);
		v2 = lred(v2);
		v1 = vecmismul(M,s1,v1);
		w1 = lcomp(v1,w1);
	}
	A  = linv(w1);
	sym = 0;

    } /*************** end for(;;) **********************/
}	
