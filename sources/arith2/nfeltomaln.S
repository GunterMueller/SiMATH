/*M
.SH NAME
nfeltomaln - number field element to matrix line

.SH SYNOPSIS
.nf
#include<_arith2.h>

list nfeltomaln(n,a)  
single n; 
nfel a;
 
.SH DESCRIPTION
.TP 4
.B a
is an number field element, represented by a list (HNa, r, a_r, ..., a_0) (s.nfneg).
.TP 4
.B n
is an natural number, n > r.
.PP
nfeltomaln returns a list L (say) of length n+1.
.PP
.nf
For a = 0, L is equal to (1, 0, ..., 0),
for a = (HNa, r, a_r, ..., a_0), L is equal to 
(HNa, 0, ..., 0, a_r, ...,a_0).   

.SH SEE ALSO
nfneg

M*/
      
/*H
	Version 1       10.08.1988      Pascale Serf
   DATE nfeltomaln    : 890601
H*/




# include <_arith2.h>

list nfeltomaln(n,a)
single n;
nfel a;
{
	single r,i;
	list L = _0;

	bind(a,L);

	/***    1.Fall : a = 0    ***/
	if ( !a ) {
	    for ( i=1 ; i<=n ; i++ ) L = lcomp(0,L);
	    L = lcomp(1,L);
	}

	/***    2.Fall : a != 0    ***/
	else {
	    r = lsecond(a);             /* Grad von a */
	    n--;
	    for ( ; r<n ; r++ ) L = lcomp(0,L);
	    L = lcomp(lfirst(a),L);
	    a = lred2(a);
	    L = lconc(L,a);
	}

	/***    Rueckgabe    ***/
	return(L);
}
