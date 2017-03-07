/*C
			ecgf2npmp2(G, a6, c, L)

        "elliptic curve over Galois-field with characteristic 2,
	number of points modulo a power of 2"
        Quellbibliothek: srclib.ec3
        Include-Datei:   _ec3.h
        single ecgf2npmp2(G,a6,c,L) obj G; gf2el a6; single c; list L;
	m = ecgf2npmp2(G,a6,c,L);
        G ist ein irreduzibles normiertes Polynom in einer Variablen
        ueber Z/2Z vom Grad n in der speziellen Bit-Darstellung
        (vgl. udpm2tosb) als erzeugendes Polynom fuer GF(2^n).
        a6 ist ein Element aus GF(2^n), das als Polynom in einer Variablen
        ueber Z/2Z vom Grad < n in spezieller Bit-Notation dargestellt wird
        und ungleich Null ist.
        Sei E die elliptische Kurve ueber GF(2^n), die durch die Gleichung
                      y^2 + x*y = x^3 + a6
        gegeben ist. (Siehe auch ecgf2npmspv1.)
	c ist eine single mit 2<c<20 sowie c < n. c sollte nicht groesser
	als 6 sein, sonst laeuft das Programm unverhaeltnismaessig lange.
        L ist die Liste der Teilungspolynome, d.h. insbesondere eine Liste
        von Polynomen in einer Veraenderlichen ueber GF(2^n) mit
	Koeffizienten in spezieller Bit-Darstellung.
	Das erste Teilungspolynom in L hat Index 0 und das letzte einen
	Index, der groesser als 2^(c-1) - 3 ist.
        Sei N = # E(GF(2^n)), d.h. N sei die Maechtigkeit der rationalen
        Punktgruppe von E. Dann ist m = N modulo 2^c.
C*/
/*H
	Version 1	12.05.93	J.Schmitt
   DATE ecgf2npmp2    : 931130
H*/

#include<_ec3.h>

static single ecgf2npmp2su(obj,list,pol,list);

single ecgf2npmp2(G,a6,c,L)
obj G;
gf2el a6;
single c;
list L;
{
	single n,i,s;
	gf2el aq,ac;
	pol   Gc,Hc;
	list  Le;
	init(aq,ac,Gc,Hc,Le);
	bind(G,a6,L);
	
	for(n=lfirst(G)-c,aq=a6;n--;aq=gf2squ(G,aq));
	for(n=c-3,ac=aq;n--;ac=gf2squ(G,ac));
	
	Hc = gf2squ(G,ac);
	Hc = gf2squ(G,Hc);
	Gc = list6(2,list2(0,1),1,ac,0,Hc);
	ac = list2(0,1);
	Hc = list4(3,ac,1,Hc);
	n  = 3;
	s  = 8;
	Le = list2(1,5);
	i  = ecgf2npmp2su(G,L,Gc,Le);
	Le = list2(i,i+s);
	s  = 2 * s;
	while ( ++n <= c ) {
		for(ac=aq,i=c-n;i--;ac=gf2squ(G,ac));
		Gc = pgf2square(1,G,Gc);
		ac = pgf2gf2prod(1,G,Hc,ac);
		ac = pgf2sum(1,G,ac,Gc);
		Hc = pgf2prod(1,G,Gc,Hc);
		Gc = ac;
		i  = ecgf2npmp2su(G,L,Gc,Le);
		Le = list2(i,i+s);
		s  = 2 * s;
	}
	i = 1 - i;
	if ( i < 0 ) {
		n = sexp(2,c);
		i = i + n;
	}
	return(i);
}

/*c
	ecgf2npmp2su ist ein static modul, das ausschliesslich von
	ecgf2npmp2 benutzt wird.
*c/
/*H
	Version 1	13.05.93	J. Schmitt
H*/

static single ecgf2npmp2su(G,L,Gc,Le)
obj G;
list L;
pol Gc;
list Le;
{
	single e;
	pol Q, xhq,h;
	bind(G,L,Gc,Le);
	init(Q,xhq,h);

	xhq = list2(0,1);
	xhq = list2(1,xhq);
	h   = upgf22pvprem(G,lfirst(G),Gc); 
	xhq = pgf2sum(1,G,xhq,h);
	e = lfirst(Le);
	Q = lelt(L,(e+2));
	Q = pgf2prod(1,G,Q,lelt(L,e));
      	    pgf2qrem(1,G,Q,Gc,&Q);
	h = lelt(L,(e+1));
	h = pgf2square(1,G,h);
      	    pgf2qrem(1,G,h,Gc,&h);
	h = pgf2prod(1,G,h,xhq);
      	    pgf2qrem(1,G,h,Gc,&h);
	Q = pgf2sum(1,G,Q,h);
	h = upgf2gcd(G,Q,Gc);
	if(!pdegree(1,h)) e = lsecond(Le);
	return(e);
}
