/*M
.SH NAME
qffmiregbg \- 
quadratic function field over modular integers,
baby step - giant step version"

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmiregbg( M, D, s )
int M;
single s; 
pol D; 

R = qffmiregbg( M, D, s ); 

.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2. Let k := Z/MZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B s
is an integer such that 0 < s < BASIS. As long as the space
is large enough, s should be chosen in the order of magnitude
 q^(deg(D)/4). Otherwise s should be chosen less than the
maximal space size or less than a fixed maximum for the stored
reduced, principal ideals (for instance s <= 100000).
.TP 4
.B R
is the regulator of the real quadratic congruence function field
k(X,Y) and it is computed by the optimized baby step - giant step
algorithm.

.SH LITERATURE
A. Stein, 
"Baby step-Giant step-Verfahren in 
reell-quadratischen Kongruenzfunktionenk"orpern
mit Charakteristik ungleich 2",
Diplomarbeit, Universit"at des Saarlandes, Saarbr"ucken (1992).

.SH NOTE
The algorithm depends strongly on the maximal space. Since, there
has to be stored about 4 * s polynomials of degree  <= Grad(D)/2
and s integers.

.SH SEE ALSO
.BR qffmsregbg(),
.BR qffmsregbgv()
M*/

/*H
        Version 1       07.06.1994	A.Stein  
        Version 2       13.08.97	new submodule. AS  
	DATE qffmiregbg: 210297
H*/

#include <_arith3.h>

int qffmiregbg(M,D,s)
int M;
pol D;
single s;
{
   /* if( issingle(M) ) return( qffmsregbgv(M,D,s) ) ;*/
    {
	unsigned i;
	single dai,das,ei,T,hush=65536; /* 2^16 = 65536 */
	int R,dbia1,I;
	list L;
	list IDEALS[65536];
	pol G,C1,ai,d,Qim1,Qi,Qip1,Pi,Pip1,rim1,ri;
	pol QQi,QQip1,bQi,bPi;
	bind(M,D);
	init(G,C1,L,Qim1,Qi,Qip1,ai,Pi,Pip1,d,ri,rim1);
        init(R,dbia1,QQip1,QQi,bQi,bPi);

	i = hush - 1;
	init(IDEALS[0..i]);
	/* Hauptteil */ 
	d = upmisrpp(M,D);
	
	/* Initialisierungen */
	D = ptodp(1,D);
	d = ptodp(1,d);
	rim1 = 0;
	ai = d;
	Pi = d; 
	Qim1 = list2(0,1); 	
	Qi = udpmiprod(M,d,d);
	Qi = udpmidif(M,D,Qi);
	dai = lfirst(d);
        if ( !lfirst(Qi) ) return(dai); 
        QQi = udpmimonic(M,Qi);
	I = lthird(QQi);
	i = ( issingle(I) ) ? ( I ) : ( lfirst(I) );
	i <<= 16; i >>= 16;
 	L = list3(QQi,Pi,dai);
	IDEALS[i] = list1(L); 
	T = dai/2 + 1;
               
 	while ( --s ) {
		ai = udpmisum(M,Pi,d);
		ai = udpmiqrem(M,ai,Qi,&ri);
		dai = dai + lfirst(ai);
		Pip1 = udpmidif(M,d,ri);
		Qip1 = udpmidif(M,ri,rim1);
		Qip1 = udpmiprod(M,ai,Qip1);
		Qip1 = udpmisum(M,Qim1,Qip1);
		QQip1 = udpmimonic(M,Qip1);
 		if (oequal(Pi,Pip1)) return(2*dai-lfirst(D)+lfirst(Qi));
		if (oequal(QQi,QQip1)) return(2*dai-lfirst(d));
		I = lthird(QQip1);
		i = ( issingle(I) ) ? ( I ) : ( lfirst(I) );
		i <<= 16; i >>= 16;
		L = list3(QQip1,Pip1,dai);
		if( !IDEALS[i] ) IDEALS[i] = list1(L);
		else IDEALS[i] = lcomp(L,IDEALS[i]);
 		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		QQi = QQip1; QQip1 = _0;
		rim1 = ri; ri = _0;
	}  

    /* giant steps : initialisations for squaration */     
	bQi = QQi;
	bPi = Pi;
	udpmiqrem(M,bPi,bQi,&bPi);
	C1 = udpmiprod(M,bPi,bPi);
	C1 = udpmidif(M,D,C1);
	C1 = udpmiquot(M,C1,bQi);
        das = dai;

    /* extend the interval a little bit */
 	while ( --T ) {
		ai = udpmisum(M,Pi,d);
		ai = udpmiqrem(M,ai,Qi,&ri);
		dai = dai + lfirst(ai);
		Pip1 = udpmidif(M,d,ri);
		Qip1 = udpmidif(M,ri,rim1);
		Qip1 = udpmiprod(M,ai,Qip1);
		Qip1 = udpmisum(M,Qim1,Qip1);
		QQip1 = udpmimonic(M,Qip1);
 		if (oequal(Pi,Pip1)) return(2*dai-lfirst(D)+lfirst(Qi));	
		if (oequal(QQi,QQip1)) return(2*dai-lfirst(d));
		I = lthird(QQip1);
		i = ( issingle(I) ) ? ( I ) : ( lfirst(I) );
		i <<= 16; i >>= 16;
		L = list3(QQip1,Pip1,dai);
		if( !IDEALS[i] ) IDEALS[i] = list1(L);
		else IDEALS[i] = lcomp(L,IDEALS[i]);
 		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		QQi = QQip1; QQip1 = _0;
		rim1 = ri; ri = _0;
	}  
         
	dai = 0;
    /* Squaration of the initial ideal */
	das = das + das;
     	G = qffmipidsqus(M,D,C1,bQi,bPi,&bQi,&bPi);  
 	das = das - lfirst(G);   
	if( lfirst(bQi) >= lfirst(d) ) {
		ei = qffmirpidred(M,D,d,bQi,bPi,&bQi,&bPi);  
		das = das + ei; 
	}
	if ( !lfirst(bQi) ) return(das);
	bQi = udpmimonic(M,bQi);
	udpmiqrem(M,bPi,bQi,&bPi);
	I = lthird(bQi);
	i = ( issingle(I) ) ? ( I ) : ( lfirst(I) );
	i <<= 16; i >>= 16;
	if( IDEALS[i] ) dai = qffmisearchs(M,IDEALS[i],bQi,bPi);
        if( dai ) return( ( das - dai ) ); 
   
    /* giant steps : initialations */
	QQi = bQi;
	Pi = bPi; 
	dbia1 = das; 
	C1 = udpmiprod(M,Pi,Pi);
	C1 = udpmidif(M,D,C1);
	C1 = udpmiquot(M,C1,QQi);

    /* giant steps */
	do {                             
		dbia1 = isum(dbia1,das);   
		G = qffmipidprs(M,D,C1,QQi,Pi,bQi,bPi,&bQi,&bPi);  
		dbia1 = idif(dbia1,lfirst(G));   
		if( lfirst(bQi) >= lfirst(d) ) {
			ei = qffmirpidred(M,D,d,bQi,bPi,&bQi,&bPi);  
			dbia1 = isum(dbia1,ei); 
		}
		if ( !lfirst(bQi) ) break;
 		bQi = udpmimonic(M,bQi);
		udpmiqrem(M,bPi,bQi,&bPi);
		I = lthird(bQi);
		i = ( issingle(I) ) ? ( I ) : ( lfirst(I) );
		i <<= 16; i >>= 16;
		if( IDEALS[i] ) dai = qffmisearchs(M,IDEALS[i],bQi,bPi);
	}
	while( !dai ) ;

        R = idif(dbia1,dai);
	return(R);
    }
}
