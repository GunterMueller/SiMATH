/*M
.SH NAME
ecqnfreddec - elliptic curve over quadratic number field reduction and
decomposition type

.SH SYNOPSIS
.nf
# include <_ec2.h>

single ecqnfreddec(E,PF,p,LRT)
list E,PF;
single p;
list LRT;

.SH DESCRIPTION
ecqnfreddec() determines the reduction type of the elliptic curve E at the
prime ideals above p in K=Q(sqrt(d)) and the decomposition type of these
prime ideals. ecqnfreddec() returns: (g: good, m: multiplicative, a: additive)

	decomposition | reduction | return value
	========================================
	inert         | g         |  1
                      | m         |  2
                      | a         |  3
	---------------------------------------
	ramified      | g         |  4
                      | m         |  5 
                      | a         |  6
	---------------------------------------
	split         | g + g     | -1
                      | g + m     | -2
                      | g + a     | -3
                      | m + g     | -4
                      | m + m     | -5
                      | m + a     | -6
                      | a + g     | -7
                      | a + m     | -8
                      | a + a     | -9
            
.PP
.TP 4                                                                           
.B E                                                                            
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').                                                                 .TP 4
.B PF
is the list PF = qnfpifact(d,itonf(p))
.TP 4                                                                           
.B p                                                                            
is a single precision prime number.                                             
.TP 4
.B LRT
is the list of prime ideals with bad reduction together with the reduction 
type.
M*/                                                                             
/*H                                                                             
        Version 1       24.08.1998      S. Schmitt                
        DATE ecqnfreddec     :   980830                                                  
H*/                                                                             
                                                                                
#include <_ec2.h>                                                               


single ecqnfreddec(E,PF,p,LRT)	
list E,PF;		
single p;
list LRT;
{	
	single z,r,s,g;
	list P,b;
	nfel pi;
	int a;
	

	init(P,b,pi,a);
	bind(E,PF,LRT);

	P = lfirst(PF);
	pi = lthird(PF);
	z = lfourth(PF);

	/** Reduktionstyp: **/

	r = 2;
	s = 2;
	g = 0;
	while(LRT!=_0)
	{
		a = lfirst(LRT);
		if(a==p)
		{
			if(!z || z==1) 
			{
				r=lthird(LRT);			
				break;
			}
			else
			{
				g++;
				b = lsecond(LRT);
				if(oequal(b,P))	r = lthird(LRT);
				else s = lthird(LRT);
				if(g==2) break;
			}
					
		}
		LRT = lred3(LRT);
	}





	if(!z)				/** traege **/
	{
		if(r==2) return(1);	/** gut **/
		if(r)	return(2);	/** multiplikativ **/
		return(3);		/** additiv **/
	}
	if(z==1)			/** verzweigt **/
	{
		if(r==2) return(4);	/** gut **/
		if(r)	return(5);	/** multiplikativ **/
		return(6);		/** additiv **/
	}
					/** zerlegt **/
	PF = lred4(PF);
	P = lfirst(PF);
	pi = lthird(PF);
	z = lfourth(PF);


	if(r==2)
	{
		if(s==2) return(-1);	/** g + g **/
		if(s) return(-2);	/** g + m **/
		return(-3);		/** g + a **/
	}
	if(r)
	{
		if(s==2) return(-4);	/** m + g **/
		if(s) return(-5);	/** m + m **/
		return(-6);		/** m + a **/
	}
	if(s==2) return(-7);		/** a + g **/
	if(s) return(-8);		/** a + m **/
	return(-9);			/** a + a **/
		
}
            

