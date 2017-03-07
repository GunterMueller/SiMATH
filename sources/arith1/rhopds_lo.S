/*M
.SH NAME
rhopds_lo - rho-method by Pollard divisor search ( lists only )

.SH SYNOPSIS
.nf
#include<_arith1.h>

int rhopds(N,b,z)
int N;
single b,z;

.SH DESCRIPTION
rhopds_lo() is identical to rhopds() but
the computation is completely performed within the SIMATH memory
management, i.e. using only lists and no arrays.

.SH SEE ALSO
rhopds
M*/

/*H 
	Version 1	05.10.1992	Marc Conrad
   DATE rhopds_lo     : 921130
H*/

#include <_arith1.h>     

int rhopds_lo (N,b,z)
int N;
single b,z;
{                          

	int x, vglx;
	single i, v;  

	bind(N);
	init(x,vglx);   
                                            
	vglx = 1967;                    /* 1967 : beliebiger Wert */
	z += 2;
	i=2;
	v=2;
	x=irem(isum(b,iprod(vglx,vglx)),N);              
/* ---------------- Begin der Iteration ------------------------- */           
	while ((igcd(idif(x,vglx),N) == 1) && (i < z) ) {                               
		if (i==v) {
			vglx = x;
			v <<= 1;
		}
		i++;
		x = irem(isum(b,iprod(x,x)),N); 
	}                    
	return(igcd(idif(vglx,x),N));

}
