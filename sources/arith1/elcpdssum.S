/*M
.SH NAME
elcpdssum - elliptic curve prime divisor search sum

.SH SYNOPSIS
.nf
#include<_arith1.h

int elcpdssum( N, x1, y1, x2, y2, px3, py3, a ) 
int N, x1, y1, x2, y2, *px3, *py3;
single a;
.SH DESCRIPTION
elcpdssum() tries to calculate (px3, py3) = (x1, y1) + (x2, y2)
and returns 1 on success or a factor P > 1 of N otherwise.

.PP
.TP 4
.B N, a
N > a > 0 , base and coefficient of the 'elliptic curve' y^2 = x^3 + a*x + b over Z/NZ, where b is uniquely identified by a and (x1, y1)
.TP 4
.B x1, y1 , x2, y2
(x1, y1), (x2, y2) are located on the 'elliptic curve'
It general it holds that 0 <= x1, y1, x2, y2 < N.
If x1 = y1 = -1, then (x1, y1) is interpreted as the point at infinity.
If x2 = y2 = -1, then (x2, y2) is interpreted as the point at infinity.

.SH NOTE
elcfds has NOTHING to do with the ec... functions,
it is used by elcpds to factor N.

.SH SEE ALSO
elcpds, elcpfs
M*/
                            
/*H          
	Version 1       08.08.1990      Marc Conrad
   DATE elcpdssum     : 901120.9109__
H*/
                         
#include <_arith1.h>                                

int elcpdssum(N, x1, y1, x2, y2, px3, py3, a)
int N, x1, y1, x2, y2, *px3, *py3;
single a; 
{ 
	int lambda,zwerg,dx,yy;   /* alles Hilfsvariablen */      

	bind(N, x1, y1, x2, y2);
	init(lambda,zwerg,dx,yy);      

	if (x1 == -1) {
		*px3 = x2;
		*py3 = y2;
		return (1);                    
	}
	if (x2 == -1) {
		*px3 = x1;
		*py3 = y1;     
		return(1);
	}
	if ( !(dx = midif(N,x1,x2)) ) { 
		if (!(yy = misum(N,y1,y2))) { /* y1 = y2 od. y1 = -y2 */
			*px3 = -1;    
			*py3 = -1;
			return(1);    
		}
		else {
			if (ihegcd(N,yy,&zwerg) != 1) return(igcd(N,yy));
			yy = misum(N,mihom(N,isprod(miexp(N,x1,2),3)),a);
			lambda = miprod(N,yy,mihom(N,zwerg));
		}
	}
	else {  
		if (ihegcd(N,dx,&zwerg) !=1) return(igcd(N,dx));
		zwerg = mihom(N,zwerg);
		lambda = miprod(N,zwerg,midif(N,y1,y2));                          
	}                                        
	dx = midif(N,midif(N,miexp(N,lambda,2),x1),x2);
	*py3 =midif(N,miprod(N,midif(N,x1,dx),lambda),y1);
	*px3 = dx;
	return(1);
}
                    
