/*M
.SH NAME
eqisnftpn - elliptic curve over quadratic number field with integral
coefficients, short normal form, torsion points of given prime power order

.SH SYNOPSIS
.nf
#include<_ec3.h>

list  eqisnftpn(d,E,t)
int d;
list E;
single t;

.SH DESCRIPTION
eqisnftpn() returns the torsion points of exact order t of an elliptic curve E 
over a quadratic number field K = Q(d^(1/2)).
.PP
.TP 4
.B d
is a squarefree integer.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B t
is a single precision number p^n, where p is a prime number.
M*/                                                                             
/*H                                                                             
        Version 1       09.08.1998      S. Schmitt                              
   DATE eqisnftpn     :   980815 
H*/                                                                             
                                                             

# include <_ec3.h>

/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/
                                                                                
/*c
		torsausnull( d, E, N )

	"torsion points from zeros"
	
	N ist die Liste der Nullstellen der eines Teilungspolynoms.
	torsausnull() bestimmt die Liste der Torsionspunkte aus diesen
	Nullstellen.
c*/

static list torsausnull(d,E,N)
int d;
list E;
list N;
{
	nfel x,y;
	list T,P;
	
	init(x,y,T,P);
	bind(d,E,N);

	T = _0;

	while(N!=_0)
	{
		x = lfirst(N);
		N = lred(N);
		if(ispeqisnf(E,x,&y))
		{
			P = list3(x,y,itonf(1));
			T = lcomp(P,T);	
			if(y) 
			{	y = qnfneg(d,y);
				P = list3(x,y,itonf(1));
				T = lcomp(P,T);	
			}
		}
	}
	return(T);
}
		
/*****************************************************************************/
/*c
		eqisnftp2( d, A, B )

	"elliptic curve over quadratic number field with integral
	coefficients, short normal form, torsion points of order 2"

	Bestimmt die Torsionspunkte der Ordnung 2 der elliptischen
	Kurve y^2=x^3+Ax+B.
c*/

static list eqisnftp2(d,A,B)
int d;
nfel A,B;
{
        list P,T,M;
        nfel x;

        init(P,T,M,x);
        bind(d,A,B);

        T = _0;

        if(!A)      P = list4(3,itonf(1),0,B);
        else if(!B) P = list4(3,itonf(1),1,A);
        else        P = list6(3,itonf(1),1,A,0,B);

        M = upqnfzero(d,P);
        while(M!=_0)
        {
                x = lfirst(M);
                M = lred(M);                                                    
                P = list3(x,0,itonf(1));                                        
                T = lcomp(P,T);                                                 
        }                                                                       
        return(T);                                                              
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



list eqisnftpn(d,E,t)
int d;
list E;
single t;
{
	list F,N,D;
	single p,e;
	nfel A,B;

	init(F,N,D,A,B);
	bind(d,E);

	if(t==2) 
	{
		A = eqisnfa4(E);
		B = eqisnfa6(E);
		F = eqisnftp2(d,A,B);
		return(F);
	}

	/** t = p^e **/

	F = sfel(t);
	p = lfirst(F);
	e = lsecond(F);

	F = eqisnfdivpol(E,t);
	
	/** die Torsionspunkte der Ordnung p^{e-1} sind schon gefunden **/

	if(e>1)
	{
		t = iquot(t,p);	
		N = eqisnfdivpol(E,t);
		D = list4(2,1,0,ineg(d));
        	D = ptodp(1,D);
		F = pnfquot(2,D,F,N);
	}

	/** y-Koordinate vergessen -> Polynom in 1 Variablen **/	
	
	F = lsecond(F);
	N = upqnfzero(d,F);
	F = torsausnull(d,E,N);

	return(F);
}



