/*M
.SH NAME
qnfconj - quadratic number field conjugate element

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfconj( D,a )  
int D; 
nfel a;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B a
is an element of K ( for representation of number field elements s. fputnfel ).
.PP
qnfconj returns the conjugate of a with regard to K/Q.

.SH SEE ALSO
fputnfel

M*/
                        
/*H
	Version 1       19.04.1989      Christine Hollinger
	Version 2       06.07.1990      C.H.    CONJQNF -> QNFCONJ
						F als Placebo
	Version 3       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS
   DATE qnfconj       : 890801.901120.9107__.910915.9311__
H*/

#include<_arith2.h>

nfel qnfconj( D,a )
int D;
nfel a;
{
	bind( a );

	/*** Q ist Fixkoerper von K/Q. ***/

	if( a && lsecond( a ) != 0 )
	{
		int a1, HNa;
		init( a1,HNa );

		/*** x = x1+D^(1/2)*x2 -> Konj. von x = x1-D^(1/2)*x2. ***/

		a1 = lthird( a );
		a1 = ineg( a1 );
		HNa = lfirst( a );
		a = lreduct( a,3 );
		a = lcomp3( HNa, 1, a1, a);
	}
	return( a );
}
