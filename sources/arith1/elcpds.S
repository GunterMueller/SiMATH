/*M
.SH NAME
elcpds - elliptic curve pure divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h

int elcpds(N,a,z)
int N;
single a,z;

.SH DESCRIPTION
elcpds() returns a factor N. If the factorization failed,
elcpds() returns 1 or N.

.PP
.TP 4
.B N
> 1 should not be prime
.TP 4
.B a
> 0 should be chosen as random as possible and not too big, e.g. a < 1000
.TP 4
.B z
>= 0  is the maximum number of elliptic curves used

.SH NOTE
elcfds has NOTHING to do with the ec... functions!

.SH SEE ALSO
"Some integer factorization algorithms using elliptic curves"
of Richard P. Brent, September 1985.
M*/

/*H
	Version 1       13.08.1990      Marc Conrad
   DATE elcpds        : 901120.9109__
H*/
	 
#include <_arith1.h>  
int elcpds(N,a,z)
int N;
single a,z;   
{ 
	single zaehl,*L1,d,i;                
	int ggt,xh,yh,E,K,x,y;                       
	bind(N);
	init(ggt,xh,yh,E,K,x,y);     
	zaehl = 0;   
	x = 16;
	y = 4;                
	L1 = LIST_SP;          
	srand(a);       
        a = mihom(N,a);
/*---------------------Erzeuge Exponent E--------------------------------*/           
	for(E=16384;*L1<500;L1++) E = iprod(E,sexp(*L1,(15/slog2(*L1))));
	while (zaehl < z) {         
/*----------------ist y^2 = x^3 + A * x +B singulaer ??------------------*/
	  xh = miexp(N,y,2);                          
	  yh = midif(N,xh,miprod(N,x,misum(N,miexp(N,x,2),a)));  /* = B */
	  xh = miprod(N,miexp(N,a,3),4);
	  if ((ggt=igcd(misum(N,xh,miprod(N,miexp(N,yh,2),27)),N)) != 1) 
		return(ggt);
/*-------------------Berechne E * (x,y) ueber Z/NZ-----------------------*/
	  xh  = -1;
	  yh  = -1;              /*         ( -1, -1 )   =  Fernpunkt  */
	  K = E;
	  while ( K != _0 ) {     
		d = lfirst(K);   
		K =lred(K);
		for (i=0;i<30;i++) {
			if ( d & 1 )
			  if ((ggt=elcpdssum(N,x,y,xh,yh,&xh,&yh,a)) != 1) 
			  	   return(ggt);
			if ((ggt=elcpdssum(N,x,y,x,y,&x,&y,a)) != 1) 
				return(ggt);
			d >>= 1;
		}
	  }
/* -------------- naechste Kurve ---------- */
	  zaehl++;   
	  a=(a+(rand() % 10)) % (1<<20) +1;              
	  x = 16 + rand() % 100;
	  y = 4  + rand() % 100;           
	}
	return(1);
}           
