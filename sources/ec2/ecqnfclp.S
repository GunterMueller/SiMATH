/*M                                                                             
.SH NAME                                                                        
ecqnfclp - elliptic curve over quadratic number field coefficient of
L-series at prime ideals
                                                                                
.SH SYNOPSIS                                                                    
.nf                                                                             
# include <_ec2.h>                                                              
                                                                                
list ecqnfclp(E,PF,p,f)
list E,PF;
single p,f; 
                 
.SH DESCRIPTION                                                                 
ecqnfclp() determines the coefficient of the L-series of E over the quadratic
number field K=Q(sqrt(d)) at the prime ideals over p.
.PP
.TP 4
.B E                                                                            
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').                                                                 
.TP 4
.B PF
is the list PF = qnfpifact(d,itonf(p)).
.TP 4                                                                           
.B p                                                                            
is a single precision prime number.                                             
.TP 4                                                                           
.B f                                                                            
is the return value of ecqnfreddec(E,PF,p).
M*/                                                                             
/*H                                                                             
        Version 1       24.08.1998      S. Schmitt                              
   DATE ecqnfclp     :   980830
H*/

# include <_ec2.h>

/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/    
/***                      ( B e g i n n i n g )                         ***/    
/**************************************************************************/    
                                                                                
/*c                 
		koeflpm(E,PF,p)
	"coefficient of L-series at prime ideal of multiplicative 
	 reduction"
c*/

static single koeflpm(E,PF,p)
list E,PF;
single p;
{
	list P,pi;
	single z,s;

	bind(E,PF);
	init(P,pi);
	
	P = lfirst(PF);
	pi = lthird(PF);
	z = lfourth(PF);

	s = ecqnfrt(E,p,P,pi,z);
	return(s);
}


/*****************************************************************************/
/*c                 
		koeflpg(E,PF,np)
	
	"coefficient of L-series at prime ideal of multiplicative 
	 reduction"

	np ist die Norm von p.
c*/

static single koeflpg(E,PF,np)
list E,PF;
single np;	
{
	list P,pi;
	single z,a;

	bind(E,PF);
	init(P,pi);

	P = lfirst(PF);
	pi = lthird(PF);
	z = lfourth(PF);

	if(np==2 || np==3 || np==4 || np==9)  a = ecqnfpnp23(E,P,pi,z);
	else a = ecqnfpnp(E,P,pi,z);
	np = isum(np,1);
	a = idif(np,a);
	return(a);
}

/**********************************************************************/        
/***                                                                ***/        
/***               s t a t i c   f u n c t i o n s                  ***/        
/***                          ( E n d )                             ***/        
/***                                                                ***/
/***                                                                ***/
/***     B e g i n n i n g   o f   t h e   m a i n   p a r t        ***/        
/***                                                                ***/
/**********************************************************************/        



list ecqnfclp(E,PF,p,f)
list E,PF;
single p,f; /** f ist die Rueckgabe aus ecqnfreddec **/
{
	list L,P1;
	single a,b,np;

	bind(E,PF);
	init(L,P1);

	

	switch(f)
	{
		case 1: /** traege + g **/
			np = p*p;
			a = koeflpg(E,PF,np);
			L = list1(a);
			break;
		case 2: /** traege + m **/
			a = koeflpm(E,PF,p);
			L = list1(a);
			break;
		case 3: /** traege + a **/
			L = list1(0);
			break;
		case 4: /** verzweigt + g **/
			a = koeflpg(E,PF,p);
			L = list1(a);
			break;
		case 5: /** verzweigt + m **/
			a = koeflpm(E,PF,p);
			L = list1(a);
			break;
		case 6: /** verzweigt + a **/
			L = list1(0);
			break;
		case -1: /** zerlegt + g + g **/
			P1 = lcopy(PF);
			P1 = linv(P1);
			P1 = lred4(P1);
			P1 = linv(P1);
			PF = lred4(PF);
			a = koeflpg(E,P1,p);
			b = koeflpg(E,PF,p);
			L = list2(a,b);
			break;
		case -2: /** zerlegt + g + m **/
			P1 = lcopy(PF);
			P1 = linv(P1);
			P1 = lred4(P1);
			P1 = linv(P1);
			PF = lred4(PF);
			a = koeflpg(E,P1,p);
			b = koeflpm(E,PF,p);
			L = list2(a,b);
			break;
		case -3: /** zerlegt + g + a **/
			P1 = lcopy(PF);
			P1 = linv(P1);
			P1 = lred4(P1);
			P1 = linv(P1);
			a = koeflpg(E,P1,p);
			L = list2(a,0);
			break;
		case -4: /** zerlegt + m + g **/
			P1 = lcopy(PF);
			P1 = linv(P1);
			P1 = lred4(P1);
			P1 = linv(P1);
			PF = lred4(PF);
			a = koeflpm(E,P1,p);
			b = koeflpg(E,PF,p);
			L = list2(a,b);
			break;
		case -5: /** zerlegt + m + m **/
			P1 = lcopy(PF);
			P1 = linv(P1);
			P1 = lred4(P1);
			P1 = linv(P1);
			PF = lred4(PF);
			a = koeflpm(E,P1,p);
			b = koeflpm(E,PF,p);
			L = list2(a,b);
			break;
		case -6: /** zerlegt + m + a **/
			P1 = lcopy(PF);
			P1 = linv(P1);
			P1 = lred4(P1);
			P1 = linv(P1);
			a = koeflpm(E,P1,p);
			L = list2(a,0);
			break;
		case -7: /** zerlegt + a + g **/
			PF = lred4(PF);
			b = koeflpg(E,PF,p);
			L = list2(0,b);
			break;
		case -8: /** zerlegt + a + m **/
			PF = lred4(PF);
			b = koeflpm(E,PF,p);
			L = list2(0,b);
			break;
		case -9: /** zerlegt + a + a **/
			L = list2(0,0);
			break;
			

	}

	return(L);
}
