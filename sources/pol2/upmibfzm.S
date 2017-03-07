/*M
.SH NAME
upmibfzm - univariate polynomial over modular integers, Berlekamp factorization, Zassenhaus method

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmibfzm(p, s, P, G)  
int p; 
single s; 
pol P, G;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
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
upmibfzm returns a list consisting of all elements of Z/pZ, for which
.IP
g.c.d.(P, G - s ) != 1
.PP
holds.

M*/

/*H
	Version 1	30.07.91	J.Schmitt 
   DATE upmibfzm      : 910915
H*/

#include<_pol2.h>

static list syslineqmi(int,single,pol,pol);
static list sysmitotf(int,list);
static list sysmisolut(int,list);

list upmibfzm(ip,s,P,G)
int ip;
single s;
pol P,G;
{
	list M1,M2;
	single lz;
	bind(ip,P,G);
	init(M1,M2);

	M1 = syslineqmi(ip,s,P,G);
	M2 = sysmitotf(ip,M1);
	M1 = sysmisolut(ip,M2);
	M1 = linv(M1);
	lz = llength(M1);
	lz = lz - 1;
	M1 = lcomp(lz,M1);
	M1 = dptop(1,M1);
	M2 = upmirf(ip,M1);
	return(M2);
}

/*c
			syslineqmi(ip,s,P,G)

	"system of linear equations over modular integers"
	list syslineqmi(ip,s,P,G) int ip; single s; pol P,G;
	L = syslineqmi(ip,s,P,G);
	ip ist ein Primzahl.
	s ist eine positive single.
	P und G sind normierte Polynome in einer Variablen ueber Z /(ip)*Z.
	P ist quadratfrei und es gilt 0 < deg(G) < deg(P).
	L ist eine Matrix mit s+1 Spalten und n Zeilen mit n = deg(P).
	Fuer die v-te Spalte (s_1 s_2 ..... s_n) gilt
	s_1 * x^(n-1) + ... + s_n = G(x)^(v-1) mod P(x).
c*/
/*H
	Version 1	30.07.91	J.Schmitt
H*/

static list syslineqmi(ip,s,P,G)
int ip;
single s;
pol P,G;
{
	pol Gp;
	list Hl,Hli,Zl,Gl;
	single n,n1,i,j;
	bind(ip,P,G);
	init(Hl,Hli,Zl,Gl,Gp);


	n  = pdegree(1,P);
	Zl = list1(1);
	Hl = list1(Zl);
	Zl = list1(0);
	n1 = n-1;
	for (i=n1;i>0;i--) { Hl=lcomp(Zl,Hl); }

	Gp = G;
	for (j=1;j<=s;j++) {
		Gl = ptodp(1,Gp);
		n1 = lfirst(Gl);
		Gl = lred(Gl);
		n1 = n1 + 1;
		for (i=n1;i<n;i++) { Gl=lcomp(0,Gl); }
		Hli= _0;
		while ( Hl != _0 ) {
			Zl = lfirst(Hl);
			Hl = lred(Hl);
			Zl = lcomp(lfirst(Gl),Zl);
			Gl = lred(Gl);
  			if ( llength(Zl) > s ) Zl = lcinv(Zl);
			Hli=lcomp(Zl,Hli);
		}
		Hl = linv(Hli);
		Gp = pmiprod(1,ip,Gp,G);
		Gp = pmirem(1,ip,Gp,P);
	}
	return(Hl);
}

/*c
			sysmitotf(ip,Ma)

	"system of modular integres to triangular form"
	list sysmitotf(ip,Ma)  int ip; list Ma;
	Matf = sysmitotf(ip,Ma);
	ip ist eine Primzahl.
	Ma ist eine Matrix ueber Z / (ip)*Z, Matf ist eine Liste
	von Listen, wobei folgendes gilt: Seien s1, ... sn die Spalten
	der Matrix Ma.
	{s_1,s_2, ... s_t} sei die Menge mit minimalem Index t, fuer die
	s_1,...,s_t linear abhaengig sind.
	Dann besteht Matf aus (t-1) Listen z1, ... z(t-1), die entstanden
	sind aus (t-1) linear unabhaengigen Zeilen von Ma durch den
	Gauss'schen Algorithmus, und wobei die beginnenden Nullen in jeder
	Zeile weggelassen wurden, d.h. zv hat die Laenge (v+1) + (n-t).
c*/
/*H
	Version 1	30.07.91	J.Schmitt 
H*/


static list sysmitotf(ip,Ma)
int ip;
list  Ma;

{
	single ent;
	int a,s;
	list Hl,Hli,Hlt,Zl,Zl2;
	bind(ip,Ma);
	init(a,s,Hl,Hli,Hlt,Zl,Zl2);

	ent = 0;
	Hlt = _0;
	Hl  = Ma;

	do { 
		Hli = _0;
		do { 
			Zl = lfirst(Hl);
			Hl = lred(Hl);
			a  = lfirst(Zl);
			if ( !a ) {
				Zl  = lred(Zl);
				Hli = lcomp(Zl,Hli);
			}
		} while ( Hl != _0 && !a );

		if ( Hl == _0 ) ent = 1;
		if ( a ) { 
			Hlt = lcomp(Zl,Hlt);
			while ( Hl != _0 ) {
				Zl2 = lfirst(Hl);
				Hl  = lred(Hl);
				s   = lfirst(Zl2);
				if ( !s ) {
					Zl2 = lred(Zl2);
					Hli = lcomp(Zl2,Hli);
				}
				else {
					s   = miinv(ip,a);
					s   = mineg(ip,s);
					s   = miprod(ip,s,lfirst(Zl2));
					Zl2 = vecmilc(ip,s,1,Zl,Zl2);
					Zl2 = lred(Zl2);
					Hli = lcomp(Zl2,Hli);
				}
			}
		}
		if ( Hli != _0 ) {
			Hl = linv(Hli);
			if ( a ) ent = 0;
		}
	} while ( !ent );
	return(Hlt);
}

/*c
			sysmisolut(ip,Hl)

	"system over modular integers solution"
	list sysmisolut(ip,Hl) int ip; list Hl;
	L = sysmisolut(ip,Hl);
	ip ist eine Primzahl.
	Hl ist eine Liste von Listen aus Z / (ip)*Z folgender Form:
	die erste Liste von Hl hat eine Laenge >= 2 und jede weitere
	Liste von Hl hat eine um genau eins groessere Laenge.
	Jede Zeile von Hl beginnt mit einer Einheit in Z / (ip)*Z.
	Sei M die Matrix die Hl in folgender Weise entspricht:
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
	Version 1	30.07.91	J.Schmitt
H*/

static list sysmisolut(ip,Hl)
int ip;
list Hl;
{
	list L,Zl,lo;
	int a,b,z,su;
	bind(ip,Hl);
	init(L,Zl,lo,a,b,su,z);

	lo = list1(1);

	while ( Hl != _0 ) {
		L  = lo;
		Zl = lfirst(Hl);
		Hl = lred(Hl);
		a  = lfirst(Zl);
		Zl = lred(Zl);
		su = 0;
		while ( L != _0 ) {
			z  = miprod(ip,lfirst(Zl),lfirst(L));
			L  = lred(L);
			Zl = lred(Zl);
			su = misum(ip,su,z);
		}
		su = mineg(ip,su);
		b  = miinv(ip,a);
		b  = miprod(ip,b,su);
		lo = lcomp(b,lo);
	}
	return(lo);
}
