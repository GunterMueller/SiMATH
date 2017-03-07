/*M
.SH NAME
ecqnfptlin - are points of elliptic curve over quadratic number field linear independent?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecqnfptlin(d, E, L)
int    d;
list   E, L;

.SH DESCRIPTION
ecqnfptlin() tests, if the set of points P1,...,Pn on an elliptic curve E over a quadratic number field K = Q(d^(1/2)) are linear independent.

.PP
.TP 4
.B d
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').                                                                 
.TP 4                                                                           
.B L                                                                            
is a list containing n points Pi = ( xi, yi, zi ) on E(K), L = ( P1 ... Pr ).   
M*/                                                                             
/*H                                                                             
        Version 1       16.09.1998      S. Schmitt                          
   DATE ecqnfptlin     : 300998 
H*/                                                                             
                                                                                
                                                                                
#include<_ec2.h>              



single ecqnfptlin(d,E,L)
int d;
list E,L;
{
	list P;
	floating reg,k;

	init(P);
	init(reg,k);
	bind(d,E,L);

	if(llength(L)==1) 
	{
		P = lfirst(L);
		reg = ecqnfnetahe(d,E,P);
	}
	else
	{	
		reg = ecqnfreg(d,E,L);
	}
	reg = flabs(reg);

	k = Cfltofl(0.0001);
	if(flcomp(k,reg)>0) return(0);
	return(1);
}


