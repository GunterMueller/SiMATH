/*M
.SH NAME
eqisnftppos - elliptic curve over quadratic number field with integral
coefficients, short normal form, torsion points with list of possible order

.SH SYNOPSIS
.nf
#include<_ec3.h>

list  eqisnftppos(d,E,T)
int d;
list   E,T;

.SH DESCRIPTION
eqisnftppos() returns the torsion points of an elliptic curve E over the 
quadratic number field K = Q(d^(1/2)). 
.PP
.TP 4
.B d
is a squarefree integer.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B T
is a list of possible orders of the torsion group.
M*/
/*H
        Version 1       09.08.1998      S. Schmitt
   DATE eqisnftppos     : 980809
H*/

# include <_ec3.h>

                                                                                
/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/    
/***                      ( B e g i n n i n g )                         ***/    
/**************************************************************************/    
                                                                                
/*c                                                                             		listtred( t, T )

	" list reduction special"

	T ist eine Liste von singles, t ist ein single. listtred
	streicht alle Zahlen, die durch t teilbar sind, aus T.
c*/


static list listtred(t,T)
single t;
list T;
{
	list L;
	single m;
	
	bind(T);
	init(L);
	
	T = linv(T);
	L = _0;
	while(T!=_0)
	{
		m = lfirst(T);
		T = lred(T);
		if(mshom(t,m)) L = lcomp(m,L);
	}
	return(L);
}

/*****************************************************************************/

/*c
		machtors(d,E,L,T)
	
	"make torsion points"

	L und T sind Listen von Torsionspunkten. machtors() testet, ob
	die Torsionspunkte von L schon in T liegen. Dann werden alle
	durch L und T durch Addition moeglichen Torsionspunkte bestimmt
	und zurueckgegeben.
c*/

static list machtors(d,E,L,T)
int d;
list E,L,T;
{
	list P,M,S,Q,ST;

	init(P,M,S,Q,ST);
	bind(d,E,L,T);

	M = _0;
	ST = lcopy(T);
	while(L!=_0)
	{
		P = lfirst(L);
		L = lred(L);
		if(!islelt(T,P))
		{
			S = lcopy(ST);
			while(S!=_0)
			{	Q = lfirst(S);
				S = lred(S);
				Q = eqisnfsum(d,E,P,Q);
				T = lcomp(Q,T);
			}
		}
	}

	return(T);
}

/*****************************************************************************/

/*c
		lpponly( T )
	
	"list prime powers only"

	T ist eine Liste von singles. lpponly() streicht alle 
	Nicht-Primzahlpotenzen sowie die 1.
c*/

static list lpponly(T)
list T;
{
	list L;
	single n,m;
	
	bind(T);
	init(L);

	T = lred(T);	 /** die 1 kommt weg **/
	T = linv(T);
	L = _0;
	while(T!=_0)
	{
		n = lfirst(T);
		T = lred(T);
		if(isspprime(n,&m)) L = lcomp(n,L);
	}
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
                                                                                

list eqisnftppos(d,E,T)
int d;
list E,T;
{
	single t,n,o,l;
	list LP,R,Q,Tneu;

	init(LP,R,Q,Tneu);
	bind(d,E,T);

	Q = list3(0,itonf(1),0);
	LP = list1(Q);

	/** falls t = q*f, (q,f)=1: Torsionspunkte der Ordnung t 
	= Torsionspunkte der Ordnung q + Torsionspunkte der Ordnung f **/
	/** Also: Nur Primzahlpotenzen in T **/

	Tneu = lcopy(T);
	Tneu = lpponly(Tneu);
	if(Tneu==_0) return(LP);

	R = llast(T);
	l = lfirst(R);

	o = 1;

	while(Tneu!=_0)
	{
		t = lfirst(Tneu);
		Tneu = lred(Tneu);

	/** Z/oZ x Z/mZ, o|m. Gibt es einen Torsionspunkt der
		Ordnung t, so muss o*lcm(m,t) die Maechtigkeit der
		Torsionsgruppe teilen **/

		n = llength(LP);
		n = iquot(n,o); /** das ist m **/
		n = ilcm(n,t);
		n = n*o;	/** das muss die #TG teilen **/
				/** also insb. kleiner sein **/
		if(n>l) 
		{
			T = listtred(t,T);
			Tneu = listtred(t,Tneu);
			R = llast(T);
			l = lfirst(R);
		}
		else if(n<=l)
		{
			R = eqisnftpn(d,E,t);
			LP = machtors(d,E,R,LP);

			/** falls es 4 Punkte der Ordnung 2 gibt **/
			if(t==2 && llength(R)==3) o=2;
			/** falls es 9 Punkte der Ordnung 3 gibt **/
			else if(t==3 && llength(R)==8) o=3*o;
			/** falls es 16 Punkte der Ordnung 4 gibt **/
			else if(t==4 && llength(R)==12) o=4;
			/** die anderen treten hoechstens 1 mal auf **/

			/** falls es keinen Punkt der Ordnung t gibt, kann es 
				auch keinen Punkt der Ordnung m, t|m geben **/
			if(R==_0) 
			{
				Tneu = listtred(t,Tneu);
				T = listtred(t,T);
				if(T!=_0)
				{
					R = llast(T);
					l = lfirst(R);
				}
			}

		}

	}

	return(LP);
}

