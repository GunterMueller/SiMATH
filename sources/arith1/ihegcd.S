/*M
.SH NAME
ihegcd - integer half extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ihegcd(A,B,pV)
int A,B,*pV;

.SH DESCRIPTION
ihegcd() returns the greatest common divisor C
of A and B. Simultaneously *pV is calculated, where
*pV = sign(B) if A equals 0 or
*pV * B - C is a multiple of A with |*pV| <= |A|/2*C otherwise.
M*/

/*H
	Version  1      23.06.86        R.Boeffgen
	Version  2      18.02.88        Korr.: V1 in Z.80 Sp.34
					 und in Z.81 Sp.44 ersetzt.  RB  
        Version  3      08.05.1989      C.H/U.S mods divs    
	Version  4      10.09.1991      V4 initialisiert, Q durch V4 ersetzt. MC
   DATE ihegcd        : 890501.890601.910930.9203__
H*/


# include <_arith1.h>

int ihegcd ( A, B, pV )
int A,B, *pV;
{
	single  a,b,c, k, m,n, q, s, u1,u2,u3, v1,v2,v3;
	int  C,D,V1,V2,V3,V4;
    /***    Initialisierung    ***/
	init(V1, V2, V3, V4, C, D);
	bind( A, B );
	A = iabs(A);
	if ( (s=isign(B)) < 0 )  B = ineg(B);
	if ( icomp(A,B)<0 )  {
		C=A, A=B, B=C;
		V1=s, V2=0;
	}
	else  V1=0, V2=s;
    /***    Folge der Reste und Entwicklung   ***/
	while (B) {
		if ( isatom(A) )  {
			C = segcd( A,B, &u1,&v1);
			V1 = isprod( V1,u1 );
			V2 = isprod( V2,v1 );
			*pV = isum( V1,V2 );
			return( C );
		}
		m = ilog2(A),  n = ilog2(B);
		if ( m-n >= (BLOG2>>1) )  {
			C = B;
			iqrem( A,B, &V4, &D );
			V3 = V2;
			V4 = idif( V1,iprod(V2,V4) );
		}
		else {  k = m-BLOG2;
			a = ip2quot( A,k ),  b = ip2quot( B,k );
			u1=v2=1,  u2=v1=0;
			for ( ; ; )  {
				q = divs( a,b ),  u3 = u1-q*u2;
				c = mods( a,b ),  v3 = v1-q*v2;
				if ( c < sabs(v3) || b-c < sabs(v2-v3) )  break;
				a = b,  b = c;
				u1 = u2,  u2 = u3;
				v1 = v2,  v2 = v3;
			}
			if ( v1==0 )  {
				iqrem( A,B, &V4, &D );
				C = B,  V3 = V2;
				V4 = idif( V1, iprod(V2,V4) );
			}
			else {  C = ilcomb( A,B, u1,v1 );
				D = ilcomb( A,B, u2,v2 );
				V3= isprod( V1,u1 );
				V3= isum( V3, isprod(V2,v1) );
				V4= isprod( V1,u2 );
				V4= isum( V4, isprod(V2,v2) );
			}
		}
		A = C,  B = D;
		V1=V3,  V2=V4;
	}
	*pV = V1;
	return( A );
}
