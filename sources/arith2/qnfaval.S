/*M
.SH NAME
qnfaval - quadratic number field additive valuation

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfaval( D, p, a )  
int D; 
single p; 
nfel a;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B p
is a prime number, so it is a prime spot of Q.
.TP 4
.B a
is an element of K, a != 0 ( for representation of number field elements s. fputnfel ).
.PP
The additive p-adic valuation wp of Q has either one extension wP or two extensions wP1 and wP2 on K. Let wP, wP1 and wP2 resp. be normed, then qnfaval returns a list, say W, where 
.PP
W = (wP(a))  resp. W = (wP1(a) wP2(a)).
.SH CAUTION
If w has two extensions wP_i (i = 1,2) on K and there exist only a '>=' estimation for the wP_i's, then W has the form 
.IP    
W = (ab_1 ab_2 w), where
.PP 
wP_i >= ab_i, i = 1,2,
.PP 
w = wP_1(a) + w_P2(a) = wp( Norm(K/Q)(a) ).
  
.SH SEE ALSO
fputnfel

M*/
                            
/*H
	Version 1       19.04.1989      Christine Hollinger
	Version 2       09.05.1989      Christine Hollinger
	Version 3       01.03.1991      Fehler verb. (NORMQNF -> QNFNORM)   PS
	Version 4       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS
	Version 5	09.02.1006	Fehler beseitigt (D wurde veraendert).  PS
   DATE qnfaval       : 890801.910301.9107__.910915.9311__.960201
H*/

#include<_arith2.h>

list qnfaval( D, p, a )
int D;
single p;
nfel a;
{
	int a0, a1, HNa, w, w0, w1;
	single sch;
	list W;
	rat R;
	init( a0, a1,  HNa, w, w0, w1, W, R );
	bind( D,a );

	/*** a = 1/HNa * ( a1*D^(1/2) + a0 ). ***/

	/*** p = 2 ***/

	if ( p == 2 ) {
		switch ( isrem(D,8) ) {
			case 1:  sch = 2;	/* zerlegter Fall */
			case 5:  sch = 1;	/* traeger Fall */
			default: sch = 0;	/* verzweigter Fall */
		}
	}

	/*** p != 2 ***/

	else {
		sch = 0;
		if ( isrem(D,p) ) {
			if ( ijacsym(D,p) == 1 ) sch = 2;
			else                     sch = 1;
		}
	}

	/*** sch = 2 <=> Es existieren 2 Fortsetzungen. ***/

	if( sch == 2 )
	{       HNa = lfirst( a );
		w = iaval( p,HNa );
		if( !lsecond( a ) )     /*** a aus Q. ***/
		{       a0 = lthird( a );
			w0 = iaval( p,a0 );
			w = idif( w0,w );
			W = list2( w,w );
		}
		else    /*** a aus K-Q. ***/
		{       a1 = lthird( a );
			a0 = lfourth( a );
			/*** wp( D^(1/2) ) = 0. ***/
			if( !a0 )
			{       w1 = iaval( p,a1 );
				w = idif( w1,w );
				W = list2( w,w );
			}
			else
			{       w1 = iaval( p,a1 );
				w0 = iaval( p,a0 );
				if( w1 != w0 )
				{    w1 = imin(w1,w0 );
				     w = idif( w1,w );
				     W = list2( w,w );
				}
				else
				{       /* w2( a ) >= w. */
					w = idif( w1,w );
					R = qnfnorm( D,a );
					a0 = lfirst( R );
					w0 = iaval( p,a0 );
					a1 = lsecond( R );
					w1 = iaval( p,a1 ); 
					w0 = idif( w0,w1 );
					W = list3(w,w,w0);
				}
			}
		}
	}
	else    /*** Es existiert nur eine Fortsetzung. ***/
	{       R = qnfnorm( D,a );
		a0 = lfirst( R );
		w0 = iaval( p,a0 );
		a1 = lsecond( R );
		w1 = iaval( p,a1 );
		w = idif( w0,w1 );
		if( sch )       /*** eP/p = 1. ***/
			w = iquot( w,2 );
		W = list1( w );
	}
	return( W );
}



