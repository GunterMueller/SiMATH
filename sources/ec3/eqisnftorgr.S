/*M                                                                             
.SH NAME                                                                
eqisnftorgr - elliptic curve over quadratic number field with integral 
coefficients, short normal form, torsion group
                                                                                
.SH SYNOPSIS                   
.nf                                                     
#include<_ec3.h>                                                                
                                                                      
list  eqisnftorgr(E)                              
list   E;                                                                    
                                                                                
.SH DESCRIPTION                                                                 
eqisnftorgr() returns the torsion group of an elliptic curve E over a quadratic
number field K = Q(D^(1/2)) 
.PP                                                                             
.TP 4                                                                           
.B E                                                                            
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').                                                                 
M*/                                                                             
/*H                                                                             
        Version 1       09.08.1998      S. Schmitt                              
   DATE eqisnftorgr     :    980815 
H*/                                                                             
                                                                                
                                                                                
# include <_ec3.h>                                                              

/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/    
/***                      ( B e g i n n i n g )                         ***/    
/**************************************************************************/    

/*c
		lptopil( d, LP )

	"list of primes to list of prime ideals"

	Erzeugt aus der Liste der Primzahlen LP=(p1,...,pn)
	die Liste (P1,Pi1,z1,...,Pl,Pil,zl), wobei Pj ein Primideal
	ueber einer der Primzahlen von LP ist, Pij ein erzeugendes
	Element von Pj und zj das Zerlegungsgesetz angibt.
c*/

static list lptopil(d,LP)
int d;
list LP;
{
        int p;
        list L,P,F;
        nfel Pi;
        single z;

        init(p,L,P,F,Pi);
        bind(d,LP);

        L = _0;

        while(LP!=_0)
        {
                p = lfirst(LP);
                LP = lred(LP);
                                                                               
                Pi = itonf(p);                                                  
                F = qnfpifact(d,Pi);                                            
                while(F!=_0)                                                    
                {                                                               
                        P = lfirst(F);                                          
                        Pi = lthird(F);                                         
                        z = lfourth(F);                                         
                        L = lcomp3(P,Pi,z,L);                                 
                        F = lred4(F);                                           
                }                                                               
        }                                                                       
                                                                                
        return(L);
}

/*************************************************************************/
/*c
		eqisnfpil( d, E )

	"elliptic curve over quadratic number field with integral 
	 coefficients, short normal form, prime ideal with good reduction
	 list"

	 Sucht zwei Primzahlen > 3, bei deren Fortsetzungen die Kurve
	 gute Reduktion hat. Die Fortsetzungen werden bestimmt. 
                                                                                
c*/
                                                                                
                                                                                
static list eqisnfpil(d,E) 
int d;                                                                          
list E;                                                                         
{                                                                               
        list L,P,LP,H;
        single red,a,b,z;
        nfel pi;
                                                                                
        bind(d,E);
        init(L,P,LP,H);
        init(pi);
                                                                                
        a = 4;
        b = 20;
                                                                                
        L = _0;                                                                 
        LP = list6(5,7,11,13,17,19);                                                        
                                                                                
        /** LP ist Liste von Primzahlen **/                                     
        /** in L stehen die Primzahlen, bei denen E gute Reduktion hat. **/     
        /** in H stehen die entsprechenden Primideale **/                       
                                                                                
        while(llength(L)!=2)                                                    
        {                                                                       
                if(llength(LP)==0)                                             
                {                                                               
                        a = isum(b,1);                                          
                        b = iprod(5,a);                                         
                        if(!issingle(b)) return(_0);                            
                        LP = spgen(a,b);                                        
                }                                                               
                b = lfirst(LP);
                LP = lred(LP);                                                  
                H = lptopil(d,list1(b));                                        
                while(H!=_0)                                                    
                {          
			P = lfirst(H);
                        pi = lsecond(H);
                        z = lthird(H);                                         
                        if(eqisnfrt(E,b,P,pi,z)!=2) break; /** schlechte Red **/     
                        H = lred3(H);                                           
                }                                                               
                /** gute Reduktion ueberall **/                                 
                if(H==_0) L = lcomp(b,L);                                       
        }                                                                       
        H = lptopil(d,L);                                                       
        return(H);                                                              
                                                                                
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


list eqisnftorgr(E)
list E;
{	
    if( lthird(E)==_0 ||
	lfifth( lthird( E ) ) == _0 )
    {
	/*   Torsionsgruppe noch nicht berechnet   */

	single n;
	int d;
	list L,T;

	init(d,L,T);
	bind(d,E);

	d = ecqnfflddisc(E);
 
	/** Primzahlen, bzgl. denen bei Reduktion abgesch"atzt wird **/
	
	L = eqisnfpil(d,E);
	if(L==_0) return(_0);

	/** Absch"atzung **/

	T = eqisnfpost(d,E,L);

	/** T = ( 1 t1 ... tn ) **/

	T = eqisnftppos(d,E,T);

        L = lthird( E );
	T = list2(T,_0);

	leset( L, 5, T );
	leset(  E, 3, L );

	return(lfirst(T));
   }
   return(lfirst(lfifth(lthird(E))));

}
