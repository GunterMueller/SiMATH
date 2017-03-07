/*M
.SH NAME
ip2prod - integer power of 2 product

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ip2prod(A,n)
int A;
single n;

.SH DESCRIPTION
ip2prod() returns A * 2^n for n >= 0.
M*/
/*H
	Version  1      08.08.1986      R.Boeffgen
	Version  2	19.05.1992	diverse Beschleunigungen.  MC
   DATE ip2prod       : 890501.921130
H*/


# include <_arith1.h>
#define lpmoc( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
lsfirst( A, (a) ); if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }

int ip2prod(A, n)		/* safe */
	int A;
	single n;
{
	bind(A);
	if (A == 0 || n == 0)
		return (A);
	else {
		single s, q = n / BLOG2, r = n % BLOG2;
		single a, b, c;
		int B;

		init(B);

		B = _0;
		c = 0;
		if (r) {
		s = BLOG2 - r;
			if (issingle(A)) {  
				if ( A > 0 ) { 
				b = (A << r) & 1073741823;
				c = A >> s;
				if (c)
					B = list2(b, c);
				else if (q)
					B = list1(b);
				else
					B = b; 
				} 
				else {
				b = ((-A) << r) & 1073741823;
				c = (-A) >> s;
				if (c)
					B = list2(-b, -c);
				else if (q)
					B = list1(-b);
				else
					B = -b; 
				} 
			} else {     
				int C;       
				if ( AVAIL == _0 ) gc();   
				B = AVAIL;   

				while (!(lfirst(A))) {
					A = lred(A);
					q++;
				}
				if (lfirst(A) > 0) {
					while (A != _0) {

						a = lfirst(A);
						A = lred(A);
						b = ((a << r) & 1073741823) | c;
						lpmoc(C, b)
						c = a >> s;
					}
					if (c) {
						lpmoc(C, c) }
				} else {
					while (A != _0) {

						a = -(lfirst(A));
						A = lred(A);
						b = ((a << r) & 1073741823) | c;
						lpmoc( C, -b );
						c = a >> s;
					}
					if (c) {  
          					lpmoc( C, -c );
					        }  
						
				}   
				lsred( C, _0 );

			}
		} else if (issingle(A) && q)
			B = list1(A);
		else
			B = A;

		while (q--) {
			B = lcomp(0, B);
		}
		return (B);
	}
}




