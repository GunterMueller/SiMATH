/*M
.SH NAME
ecqnfminnth - elliptic curve over quadratic number field minimal Neron-Tate height
 
.SH SYNOPSIS
.nf
#include<_ec2.h>
 
floating ecqnfminnth(E)
list   E;
 
.SH DESCRIPTION
ecqnfminnth() returns an estimate for the minimal Neron-Tate height of
non torsion points on E(K). 
 
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
M*/
/*H
        Version 1      06.11.1998        S. Schmitt
   DATE ecqnfminnth    : 981115
H*/
 
#include<_ec2.h>

floating ecqnfminnth( E )
list E;
{
	floating delta, eps;
	list L,P;
	int d;

	init(delta,eps);	
	init(L,P);	
	init(d);
    	bind( E );

	delta = ecqnfdwhnth(E);
/**
printf(" delta = ");
putflfx(delta,3,10);
printf("\n");
**/
	eps = Cfltofl(0.01);
	delta = flsum(eps,delta);
	d = ecqnfflddisc(E);

	L = eqisnfspbh(E,delta);	
	while(L!=_0)
	{
		P = lfirst(L);
		L = lred(L);
		delta = ecqnfnetahe(d,E,P);
		if(flcomp(delta,0)>0 && flcomp(delta,eps) < 0) eps = delta;

	}
	return(eps);	
}
