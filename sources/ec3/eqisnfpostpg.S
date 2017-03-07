/*M                                                                             
.SH NAME                                                                        
eqisnfpostpg - elliptic curve over quadratic number field with integral         
coefficients, short normal form, possible divisors of the order of the          
torsion group at prime ideal with good reduction                                                                   
                                                                                
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_ec3.h>                                                                
                                                                                
list  eqisnfpostpg(E,P,Pi,z)
list   E,P;                                                                    
nfel Pi;
single z;
                                                                                
                                                                                
.SH DESCRIPTION                                                                 
eqisnfpostpg() returns the list of the possible order of the torsion group of 
an elliptic curve E over the quadratic number field K = Q(d^(1/2)). The possible
order is computed by reduction modulo a prime ideal, where E has good
reduction.
.PP                                                                             
.TP 4                                      
.B E     
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').    
.TP 4
.B P                                                                            
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod'). The prime i
deal P divides a prime number not equal to 2.                                   
.TP 4                                                                           
.B Pi                                                                           
is a prime element of the prime ideal P.                                        
.TP 4                                                                           
.B z                                                                            
is = 0,1, or 2, if the prime ideal P divides an inert, ramified or split prime  
number in Q.                                                                    
M*/                                                                             
/*H                                                                             
        Version 1       09.08.1998      S. Schmitt                              
   DATE eqisnfpostpg     :    980815 
H*/                                                                             

# include<_ec3.h>

                                                                                
/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/
                                                                                
/*c
                maketl( LP )                                                    
        "make list of divisors of list"                                         
                                                                                
        LP = (p1,...,pn) ist eine Liste von Primzahlen (die auch                
        mehrfach auftreten koennen). maketl() bestimmt die Teiler               
        von p1*...*pn.                                                          
c*/                                                                             


static list maketl(LP)
list LP;
{
        list LT,H;
        int p,r;

        init(LT,H,p,r);
        bind(LP);

        if(LP==_0) return(list1(1));

        p = lfirst(LP);
        LP = lred(LP);
        H = maketl(LP);

        LT = lcopy(H);
        while(H!=_0)
        {
                r = lfirst(H);
                H = lred(H);
                r = iprod(p,r);                                                 
                if(!islelt(LT,r)) LT = lcomp(r,LT);                             
        }                                                                       
        libsort(LT);                                                            
                                                                                
        return(LT);                                                             
}                                                                               
                                                                                
/***********************************************************************/       
/*c                                                                             
                idivl( n )
        "integer list of divisors"
                                                                                
        idivl() gibt die Liste aller Teiler von n zurueck.
                                                                                
c*/

                                                                               
list idivl(n)                                                                   
int n;                                                                          
{
        list L,LP;
                                                                                
        init(L,LP);
        bind(n);
                                                                                
        LP = ifact(n);
        L = maketl(LP);
                                                                                
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
                                                                                
list eqisnfpostpg(E,P,pi,z)
list E,P;
nfel pi;
single z;
{
	int n;
	list T;

	init(n,T);
	bind(E,P,pi);

	n = eqisnfpnp(E,P,pi,z);
	T = idivl(n);

	return(T);
}

