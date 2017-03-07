/*M
.SH NAME
Itoi - (Heidelberg) Integer to (SIMATH) integer

.SH SYNOPSIS
.nf
#include<_HDarith.h>

int Itoi(h)
Integer *h;

.SH DESCRIPTION
Itoi() returns the value of h as a SIMATH integer in list representation.
.PP
.TP 4
.B h
is an integer according to the conventions of the Heidelberg arithmetic package
.SH SEE ALSO
itoI
M*/
/*H
	Version  1      16.04.1993	Marc Conrad
	Version  2      21.08.1993	voellig neu, Marc Conrad
   DATE Itoi          : 930531.931130
H*/

#include<_HDarith.h>

#define ultosi( A ) ( (single) ( (A) & FULL_MASK ) )
/* loescht die beiden obersten Bit */
#define lpmocv( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
if ( vz == PLUS ) lsfirst( A, (a) ); else lsfirst( A, -(a)); \
if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }
/* lpmocv <=> umgekehrtes lcomp mit vz*/


int Itoi( aa )
Integer *aa;
{
	DigitType *pe;
	int AA, A, lastnonzero;
	single o, vz, digit;

	init(AA, lastnonzero);

	vz = aa->sign;
	if ((o = aa->length) == 0)
		return (0);
	else if ( ( o == 1 ) && ( *(aa->vec) < BASIS ) )  {
		if ( vz == PLUS ) return( (single) *(aa->vec) );
		else   return( -((single) *(aa->vec)) );
	}
	else{
	        single carry=0,rest,i=1;
		unsigned long b;

		if ( AVAIL == _0 ) gc();

		AA = AVAIL;

		pe = aa->vec;
		while (i <= o ) {
		        rest=SIZEOF_LONG*8;
			if (carry) {
			    digit = ultosi( b | *pe << carry );
			    if (digit)
				lastnonzero = AVAIL;
			    lpmocv(A, digit);
			    rest -= FULL_WIDTH-carry;
			    b = *pe >> FULL_WIDTH-carry;
			}
			else
			    b = *pe;
			while( rest >= FULL_WIDTH ) {
			    digit = ultosi(b);
			    if (digit)
				lastnonzero = AVAIL;
			    lpmocv(A, digit);
			    rest -= FULL_WIDTH;
			    b >>= FULL_WIDTH;
			}
			carry = rest;
			i++, pe++;
		}
		if (carry) {
		    digit = ultosi(b);
		    if (digit) {
			lastnonzero = AVAIL;
			lpmocv(A, digit);
		    }
		}
                lsred(lastnonzero, _0);
		if (AA == _0)
		    return(0);
		if (lblength(AA, 2)==1)
		    return(lfirst(AA));
		return( AA );
	}
}
