/*M                                                                             
.SH NAME                                                                        
eqisnfpost - elliptic curve over quadratic number field with integral          
coefficients, short normal form, possible divisors of the order of the
torsion group                                  
                                                                                
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_ec3.h>                                                                
                                                                                
list  eqisnfpost(d,E,LP)   
int d;
list   E,LP;                                                                       
                                                                                
.SH DESCRIPTION                                                                 
eqisnfpost() returns the list of the possible divisors of the order of the 
torsion group of an elliptic curve E over the quadratic number field 
K = Q(d^(1/2)) 
.PP                                                                             
.TP 4                                                                           
.B d
is a squarefree integer.
.TP 4
.B E                                                                            
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').                                                                 
.TP 4
.B LP
is a list LP = (P1,Pi1,z1,...,Pn,Pin,zn), where the Pj are prime ideals where the curve E has good reduction. Pij is a prime element and zj is the reduction type of Pn.
M*/                                                                            
/*H                                                                             
        Version 1       09.08.1998      S. Schmitt                              
   DATE eqisnfpost     : 980815 
H*/
                                                                                
                                                                                
# include <_ec3.h>

/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/    
/***                      ( B e g i n n i n g )                         ***/    
/**************************************************************************/    

/*c
		qnflpostec( d )

	"quadratic number field, list of all possible orders of torsion 
 	 groups of elliptic curves"		 

	Listet alle moeglichen Maechtigkeiten von Torsionsgruppen
	elliptischer Kurven ueber Q(sqrt(d)) auf.
c*/

static list qnflpostec(d)
int d;
{
        list L;

        init(L);
        bind(d);

        L = _0;
        if(!icomp(d,-3)) L = list1(36);
        L = lcomp6(14,15,16,18,20,24,L);
        L = lcomp6(8,9,10,11,12,13,L);
        L = lcomp6(2,3,4,5,6,7,L);
        L = lcomp(1,L);

        return(L);
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



list eqisnfpost(d,E,LP)
int d;
list E,LP;
{	
	list P,T,TT;
	single z;
	nfel pi;

	init(P,T,TT,pi);
	bind(d,E,LP);	/** LP = (P1,...,Pn) und die Pi's sind jeweils
				P,Pi,z. **/

	TT = qnflpostec(d);

	while(LP!=_0)
	{	
		P = lfirst(LP);
		pi = lsecond(LP);
		z = lthird(LP);
		LP = lred3(LP);

		T = eqisnfpostpg(E,P,pi,z);
		TT = sinter(TT,T);

		if(llength(TT)==1) return(TT);
	}

	return(TT);
}
