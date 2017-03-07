/*M
.SH NAME 
upmsbfzm - univariate polynomial over modular singles, Berlekamp factorization, Zassenhaus method

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmsbfzm(p, s, P, G) 
single p, s; 
pol P, G;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                   
.TP 4                                                                           
.B P                                                                            
is an univariate monic and square-free polynomial over Z/pZ of degree > 1.      
.TP 4                                                                           
.B s                                                                            
is an integer number, 2 <= s <= deg(P).                                         
s is at least as large as the number of irreducible factors of P.               
.TP 4                                                                           
.B G                                                                            
is a monic polynomial with 0 < deg(G) < deg(P), so that                         
.IP                                                                             
( G^p - G ) mod P = 0, i.e.                                                     
.IP                                                                             
P divides (G-s1)* ...*(G-sp), whereat                                           
 Z/pZ = { s1, ..., sp }.                                                        
.PP                          
upmsbfzm returns a list consisting of all elements of Z/pZ, for which           
.IP                                                                             
g.c.d.(P, G - s ) != 1                                                          
.PP                                                                             
holds.                                                                          
                                                  
M*/

/*H
	Version 1            06.01.88                 J.Schmitt 
   DATE upmsbfzm      : 890501.890601     
H*/


#include<_pol2.h>

static list syslineqms(single,single,pol,pol);
static list sysmstotf(single,list);
static list sysmssolut(single,list);

list upmsbfzm(m,s,P,G)
list P,G;
single m,s;
{
  list Ma,Matf,Hl,P1,L;
  single lz;
  bind(P,G);
  init(Ma,Matf,Hl,P1,L);

  Ma=syslineqms(m,s,P,G);
  Matf=sysmstotf(m,Ma);
  Hl=sysmssolut(m,Matf);
  Hl=lcinv(Hl);
  lz=llength(Hl);
  lz=lz-1;
  Hl=lcomp(lz,Hl);
  P1=dptop(1,Hl);
  L=upmsrf(m,P1);
  return(L);
}

/*c
		     syslineqms(m,s,P,G)
	"system of linear equations over modular singles"
	list syslineqms(m,s,P,G) single m,s; pol P,G;
	L = syslineqms(m,s,P,G);
	m ist eine Primzahl < BASIS, s ist eine positive ganze Zahl
	< BASIS. P ist ein normiertes, quadratfreies Polynom in einer
	Veraenderlichen. G ist ein normiertes Polynom in einer
	Veraenderlichen ueber Z/mZ mit 0 < deg(G) < deg(P).
	L ist eine Liste von Listen.
	L entspricht einer Liste von Zeilen einer Matrix, so dass
	die Matrix (s+1) Spalten und n Zeilen hat ( mit n=deg(P) ).
	Fuer die v-te Spalte (s1 s2 ..... sn) gilt
	s1*x^(n-1)+s2*x^(n-2)+...+sn = G(x)^(v-1) mod P(x)!
c*/
/*H
	Version 1          28.12.87              J.Schmitt
H*/


static list syslineqms(m,s,P,G)
pol P,G;
single m,s;

{
  pol Gp;
  list Hl,Hli,Zl,Gl;
  single n,n1,i,j;
  bind(P,G);
  init(Hl,Hli,Zl,Gl,Gp);

  n=pdegree(1,P);
  Zl=list1(1);
  Hl=list1(Zl);
  Zl=list1(0);

  n1=n-1;
  for (i=n1; i>0; i--) { Hl=lcomp(Zl,Hl); }

  Gp=G;

  for (j=1; j<=s; j++)    {
			    Gl=ptodp(1,Gp);
			    n1=lfirst(Gl);
			    Gl=lred(Gl);
			    n1=n1+1;
			    for (i=n1; i<n; i++) { Gl=lcomp(0,Gl); }
			    Hli=_0;
			    while (Hl!=_0) {
					      Zl=lfirst(Hl);
					      Hl=lred(Hl);
					      Zl=lcomp(lfirst(Gl),Zl);
					      Gl=lred(Gl);
					      if ( llength(Zl) > s )
							Zl=lcinv(Zl);
					      Hli=lcomp(Zl,Hli);
					   }
			    Hl=linv(Hli);
			    Gp=pmsprod(1,m,Gp,G);
			    Gp=pmsrem(1,m,Gp,P);
			  }
  return(Hl);
}

/*c
		   sysmstotf(m,Ma)
	"system over modular singles to triangular form"
	list sysmstotf(m,Ma)  single m; list Ma;
	Matf = sysmstotf(m,Ma);
	m ist eine Primzahl < BASIS. Ma ist eine Matrix als Liste
	von Zeilen ueber Z/mZ, Matf ist eine Liste von Listen, wobei
	folgendes gilt: Seien s1, ... sn die Spalten der Matrix Ma.
	{s1,s2, ... st} sei die Menge mit minimalem Index t, fuer die
	s1,...,st linear abhaengig sind.
	Dann besteht Matf aus (t-1) Listen z1, ... z(t-1), die entstanden
	sind aus (t-1) linear unabhaengigen Zeilen von Ma
	durch den Gauss'schen Algorithmus,
	und wobei die beginnenden Nullen in jeder Zeile weggelassen wurden,
	d.h. zv hat die Laenge (v+1) + (n-t).
c*/
/*H
	Version 1        23.12.87                J.Schmitt 
        Version 2        22.05.89                C.H/U.S mods  
H*/


static list sysmstotf(m,Ma)
single m;
list  Ma;

{
  single control,a,s;
  list Hl,Hli,Hlt,Zl,Zl2;
  bind(Ma);
  init(Hl,Hli,Hlt,Zl,Zl2);

  control=0;
  Hlt=_0;
  Hl=Ma;

  do { Hli=_0;
       do { Zl=lfirst(Hl);
	    Hl=lred(Hl);
            a = lfirst( Zl );
	    a= mods( a, m);
	    if (a==0) { Zl=lred(Zl);
			Hli=lcomp(Zl,Hli); }
	  } while      ((Hl!=_0)&&(a==0));

       if (Hl==_0) control=1;
       if (a!=0) { Hlt=lcomp(Zl,Hlt);
		   while (Hl!=_0) {
				    Zl2=lfirst(Hl);
				    Hl=lred(Hl);
                                    s = lfirst( Zl2 );
				    if ( mods( s, m)==0)         {
						Zl2=lred(Zl2);
						Hli=lcomp(Zl2,Hli); }
				    else {
					   s=msinv(m,a);
					   s=msneg(m,s);
					   s=msprod(m,s,lfirst(Zl2));
					   Zl2=vecmslc(m,s,1,Zl,Zl2);
					   Zl2=lred(Zl2);
					   Hli=lcomp(Zl2,Hli); }
				  }
		 }
       if (Hli!=_0) {
		      Hl=linv(Hli);
		      if (a!=0) control=0;
		    }

     } while (control==0);

  return(Hlt);
}

/*c
			sysmssolut(m,Hl)
	"system over modular singles solution"
	list sysmssolut(m,Hl) single m; list Hl;
	L = sysmssolut(m,Hl);
	m ist eine Primzahl < BASIS. Hl ist eine Liste von Listen
	aus Z/mZ folgender Form : die erste Liste von Hl hat eine
	Laenge >= 2 und jede weitere Liste von Hl hat eine um genau
	eins groessere Laenge. Jede Zeile von Hl beginnt mit einer
	Zahl != 0 in Z/mZ.
	Sei M die Matrix die Hl in folgender Weise entspricht :
	M hat soviele Zeilen wie Hl Listen, jede Zeile von M ist
	solang wie die laengste Liste von Hl.
	Die letzten Stellen der Zeilen von M entsprechen der Liste
	von Hl, die vorderen Stellen sind Null.
	Entspreche L1 dem Loesungsvektor des homogenen Gleichungssystem
	von M, der moeglichst viele Nullen am Ende hat, nicht der Null-
	vektor ist und dessen letztes Element !=0 gleich 1 ist!
	Dann entspricht L der Liste, die entstanden ist aus L1 durch
	Streichen der Nullen am Ende.
c*/
/*H
	Version 1         28.12.87               J.Schmitt
H*/

static list sysmssolut(m,Hl)
list Hl;
single m;

{

  list L,Zl,loesung;
  single a,b,z,sum;
  bind(Hl);
  init(L,Zl,loesung);

  loesung=list1(1);

  while (Hl!=_0) {
		   L=loesung;
		   Zl=lfirst(Hl);
		   Hl=lred(Hl);
		   a=lfirst(Zl);
		   Zl=lred(Zl);
		   sum=0;

		   while (L!=_0) {
				   z=msprod(m,lfirst(Zl),lfirst(L));
				   L=lred(L);
				   Zl=lred(Zl);
				   sum=mssum(m,sum,z);
				 }
		   sum=msneg(m,sum);
		   b=msinv(m,a);
		   b=msprod(m,b,sum);
		   loesung=lcomp(b,loesung);
		 }
  return(loesung);
}
