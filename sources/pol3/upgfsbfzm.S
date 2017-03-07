/*M
.SH NAME
upgfsbfzm - univariate polynomial over Galois-field with single characteristic Berlekamp factorization, Zassenhaus method

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfsbfzm(p, AL, s, P, G)  
single p, s; 
list AL; 
pol P, G;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).  
.TP 4
.B P
is a monic, squarefree and univariate polynomial over GF(p^n), deg(P) >= 2.
.TP 4
.B s
is at least as large as the number of the irreducible factors of P, and in any case 2 <= s <= deg(P) must hold.
.TP 4
.B G
is a monic polynomial with 0 < deg(G) < deg(P) and 
.IP
(G^(p^n) - G) mod P = 0, i.e.
.IP
P | (G-s1) *...* (G-sq), whereby q = p^n and 
GF(p^n) = {s1,...,sq}.
.PP
upgfsbfzm returns a list, containing exactly these elements in GF(p^n), such that gcd( P, G-s) != 1 holds.

.SH SEE ALSO
gfsalgen

M*/
                  
/*H
	Version 1	13.07.88	J.Schmitt
   DATE upgfsbfzm     : 890501.8908__.9203__
H*/


#include<_pol3.h>
static list syslineqgfs(single,list,single,pol,pol);
static list sysgfstotf(single,list,list);
static list sysgfssolut(single,list,list);
list upgfsbfzm(p,AL,s,P,G)
single p,s;
list AL;
pol P,G;
{
  list Ma,Matf,Hl,P1,L;
  single lz;
  bind(AL,P,G);
  init(Ma,Matf,Hl,P1,L);

  Ma=syslineqgfs(p,AL,s,P,G);
  Matf=sysgfstotf(p,AL,Ma);
  Hl=sysgfssolut(p,AL,Matf);
  Hl=lcinv(Hl);
  lz=llength(Hl);
  lz=lz-1;
  Hl=lcomp(lz,Hl);
  P1=dptop(1,Hl);
  L=upgfsrf(p,AL,P1);
  return(L);
}

/*c
		     syslineqgfs(p,AL,s,P,G)

	"system of linear equations over Galois-field with single 
	 characteristic"
	list syslineqgfs(p,AL,s,P,G)  single p,s; pol P,G; list AL;
	L = syslineqgfs(p,AL,s,P,G);
	p ist eine Primzahl < BASIS, AL = (G,AL1) kann als Arithmetikliste
	fuer GF(p^n) interpretiert werden (siehe gfsalgen), und es gilt
	n = llength(AL1) + 1.
	s ist eine positive ganze Zahl < BASIS.
	P ist ein normiertes, quadratfreies und G ein normiertes Polynom
	in einer Veraenderlichen ueber GF(p^n) mit 0 < deg(G) < deg(P).
	L ist eine Liste von Listen.
	L entspricht einer Liste von Zeilen einer Matrix, so dass
	die Matrix (s+1) Spalten und m Zeilen hat ( mit m=deg(P) ).
	Fuer die v-te Spalte (s1 s2 ..... sm) gilt
	s1*x^(m-1)+s2*x^(m-2)+...+sm = G(x)^(v-1) mod P(x)!
c*/


static list syslineqgfs(p,AL,s,P,G)
single p,s;
list AL;
pol P,G;

{
  pol Gp;
  list Hl,Hli,Zl,Gl;
  single n,n1,i,j;
  bind(AL,P,G);
  init(Hl,Hli,Zl,Gl,Gp);

  n=pdegree(1,P);
  Zl=list1(list2(0,1));
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
			    Gp=pgfsprod(1,p,AL,Gp,G);
			    Gp=pgfsrem(1,p,AL,Gp,P);
			  }
  return(Hl);
}

/*c
		   sysgfstotf(p,AL,Ma)

	"system over Galois-field with single characteristic to triangular 
	 form"
	list sysgfstotf(p,AL,Ma)  single p; list AL,Ma;
	Matf = sysgfstotf(p,AL,Ma);
	p ist eine Primzahl < BASIS, AL = (G,AL1) kann als Arithmetikliste
	fuer GF(p^n) interpretiert werden (siehe gfsalgen), und es gilt
	n = llength(AL1) + 1.
	Ma ist eine Matrix als Liste von Zeilen ueber GF(p^n);
	Matf ist eine Liste von Listen, wobei folgendes gilt:
	Seien s1, ... sm die Spalten der Matrix Ma.
	{s1,s2, ... st} sei die Menge mit minimalem Index t, fuer die
	s1,...,st linear abhaengig sind.
	Dann besteht Matf aus (t-1) Listen z1, ... z(t-1),
	die durch den Gauss'schen Algorithmus aus (t-1) linear
	unabhaengigen Zeilen von Ma entstanden sind.
	Dabei wurden die beginnenden Nullen in jeder Zeile weggelassen,
	d.h. zv hat die Laenge (v+1) + (m-t).
c*/


static list sysgfstotf(p,AL,Ma)
single p;
list  AL,Ma;

{
  single control;
  gfel a,s;
  list Hl,Hli,Hlt,Zl,Zl2;
  bind(AL,Ma);
  init(a,s,Hl,Hli,Hlt,Zl,Zl2);

  control=0;
  Hlt=_0;
  Hl=Ma;

  do { Hli=_0;
       do { Zl=lfirst(Hl);
	    Hl=lred(Hl);
	    a=lfirst(Zl);
	    if (a==0) { Zl=lred(Zl);
			Hli=lcomp(Zl,Hli); }
	  } while      ((Hl!=_0)&&(a==0));

       if (Hl==_0) control=1;
       if (a!=0) { Hlt=lcomp(Zl,Hlt);
		   while (Hl!=_0) {
				    Zl2=lfirst(Hl);
				    Hl=lred(Hl);
				    if (lfirst(Zl2)==0)         {
						Zl2=lred(Zl2);
						Hli=lcomp(Zl2,Hli); }
				    else {
					   s=gfsinv(p,AL,a);
					   s=gfsneg(p,AL,s);
					   s=gfsprod(p,AL,s,lfirst(Zl2));
					   Zl2=vecgfslc(p,AL,s,list2(0,1),Zl,Zl2);
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
			sysgfssolut(p,AL,Hl)

	"system over Galois-field with single characteristic solution"
	list sysgfssolut(p,AL,Hl)  single p; list AL,Hl;
	L = sysgfssolut(p,AL,Hl);
	p ist eine Primzahl < BASIS, AL = (G,AL1) kann als Arithmetikliste
	fuer GF(p^n) interpretiert werden (siehe gfsalgen), und es gilt
	n = llength(AL1) + 1.
	Hl ist eine Liste von Listen aus GF(p^n) folgender Form:
	die erste Liste von Hl hat eine Laenge >= 2, und jede weitere
	Liste von Hl hat eine um genau eins groessere Laenge.
	Jede Zeile von Hl beginnt mit einer Zahl != 0 in GF(p^n).
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

static list sysgfssolut(p,AL,Hl)
single p;
list AL,Hl;

{

  list L,Zl,loesung;
  gfel a,b,z,sum;
  bind(AL,Hl);
  init(a,b,z,sum,L,Zl,loesung);

  loesung=list1(list2(0,1));

  while (Hl!=_0) {
		   L=loesung;
		   Zl=lfirst(Hl);
		   Hl=lred(Hl);
		   a=lfirst(Zl);
		   Zl=lred(Zl);
		   sum=0;

		   while (L!=_0) {
				   z=gfsprod(p,AL,lfirst(Zl),lfirst(L));
				   L=lred(L);
				   Zl=lred(Zl);
				   sum=gfssum(p,AL,sum,z);
				 }
		   sum=gfsneg(p,AL,sum);
		   b=gfsinv(p,AL,a);
		   b=gfsprod(p,AL,b,sum);
		   loesung=lcomp(b,loesung);
		 }
  return(loesung);
}
