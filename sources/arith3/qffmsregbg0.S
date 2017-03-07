/*M
.SH NAME
qffmsregbg0 \- 
quadratic function field over modular singles regulator,
baby step - giant step version, zero case

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmsregbg0( m, D, s )
single m, s; 
pol D; 

R = qffmsregbg0( m, D, s ); 

.SH DESCRIPTION
.TP 4
.B m
is a prime integer, 2 < m < BASIS. Let k:= Z/mZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B Condition:
	m > 10000
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
k(X,Y), and it is computed by the optimized baby step - giant step
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
.BR qffmiregbg(),
.BR qffmsregbg()
M*/

/*H
        Version 1       10.11.1993	A. Stein
H*/
/*cS
	qffmsregbg0 ruft auf: isum, lcomp, oequal, ptodp, qffmspidprs,
		qffmspidsqus, qffmsrpidred, udpmsdif, udpmsmonic, 
		udpmsneg, udpmsprod, udpmsqrem, udpmssum, upmssrpp
	Macros: idif, lfirst, lfourth, list1, list2, list3, lred, 
		lsecond, lthird, udpmsquot
Sc*/



#include <_arith3.h>

int qffmsregbg0(m,D,s)
single m,s;
pol D;
{        
	single dai,das,i,j,ei,T,hush=307;
	int R,dbia1;
	list L;
	list IDEALS[308][308];
	pol G,C1,ai,d,Qim1,Qi,Qip1,Pi,Pip1,rim1,ri;
	pol QQi,QQip1,bQi,bPi;
	bind(D);
	init(G,C1,L,Qim1,Qi,Qip1,ai,Pi,Pip1,d,ri,rim1);
        init(R,dbia1,QQip1,QQi,bQi,bPi);

        i = hush - 1;
	init(IDEALS[0..i][0..hush]);

	/* Hauptteil */ 
	d = upmssrpp(m,D);
	
	/* Initialisierungen */
	D = ptodp(1,D);
	d = ptodp(1,d);
	rim1 = 0;
	ai = d;
	Pi = d; 
	Qim1 = list2(0,1); 	
	Qi = udpmsprod(m,d,d);
	Qi = udpmsdif(m,D,Qi);
	dai = lfirst(d);
        if ( !lfirst(Qi) ) return(dai); 
        QQi = udpmsmonic(m,Qi);
	i = lthird(QQi) % hush;
	j = ( lfirst(QQi) == 1 ) ? (hush) : (lfourth(QQi) % hush);
 	L = list3(QQi,Pi,dai);
	IDEALS[i][j] = list1(L); 
	T = dai/2 + 1;
               
 	while ( --s ) {
		ai = udpmssum(m,Pi,d);
		ai = udpmsqrem(m,ai,Qi,&ri);
		dai = dai + lfirst(ai);
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
		QQip1 = udpmsmonic(m,Qip1);
 		if (oequal(Pi,Pip1)) return(2*dai-lfirst(D)+lfirst(Qi));	
		if (oequal(QQi,QQip1)) return(2*dai-lfirst(d));
		i = lthird(QQip1) % hush;
		j = ( lfirst(QQip1) == 1 ) ? (hush) : (lfourth(QQip1) % hush);
		L = list3(QQip1,Pip1,dai);
		if( !IDEALS[i][j] ) IDEALS[i][j] = list1(L);
		else IDEALS[i][j] = lcomp(L,IDEALS[i][j]);
 		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		QQi = QQip1; QQip1 = _0;
		rim1 = ri; ri = _0;
	}  

    /* giant steps : Initialisierungen zum Quadrieren */     
	bQi = QQi;
	bPi = Pi;
	udpmsqrem(m,bPi,bQi,&bPi);
	C1 = udpmsprod(m,bPi,bPi);
	C1 = udpmsdif(m,D,C1);
	C1 = udpmsquot(m,C1,bQi);
        das = dai;

    /* Erweiterung des Intervalls */
 	while ( --T ) {
		ai = udpmssum(m,Pi,d);
		ai = udpmsqrem(m,ai,Qi,&ri);
		dai = dai + lfirst(ai);
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
		QQip1 = udpmsmonic(m,Qip1);
 		if (oequal(Pi,Pip1)) return(2*dai-lfirst(D)+lfirst(Qi));	
		if (oequal(QQi,QQip1)) return(2*dai-lfirst(d));
		i = lthird(QQip1) % hush;
		j = ( lfirst(QQip1) == 1 ) ? (hush) : (lfourth(QQip1) % hush);
		L = list3(QQip1,Pip1,dai);
		if( !IDEALS[i][j] ) IDEALS[i][j] = list1(L);
		else IDEALS[i][j] = lcomp(L,IDEALS[i][j]);
 		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		QQi = QQip1; QQip1 = _0;
		rim1 = ri; ri = _0;
	}  
         
	dai = 0;
    /* Quadriere das Ausgangsideal */
	das = das + das;
     	G = qffmspidsqus(m,D,C1,bQi,bPi,&bQi,&bPi);  
 	das = das - lfirst(G);   
	if( lfirst(bQi) >= lfirst(d) ) {
		ei = qffmsrpidred(m,D,d,bQi,bPi,&bQi,&bPi);  
		das = das + ei; 
	}
	if ( !lfirst(bQi) ) return(das);
	bQi = udpmsmonic(m,bQi);
	udpmsqrem(m,bPi,bQi,&bPi);
	i = lthird(bQi) % hush;
	j = ( lfirst(bQi) == 1 ) ? (hush) : (lfourth(bQi) % hush);
	if( IDEALS[i][j] ) dai = qffmssearchs(m,IDEALS[i][j],bQi,bPi);
        if( dai ) return( ( das - dai ) ); 
   
    /* giant steps : Initialisierung */
	QQi = bQi;
	Pi = bPi; 
	dbia1 = das; 
	C1 = udpmsprod(m,Pi,Pi);
	C1 = udpmsdif(m,D,C1);
	C1 = udpmsquot(m,C1,QQi);

    /* giant steps */
	do {                             
		dbia1 = isum(dbia1,das); 
		ei = qffmsgsrpi(m,D,d,C1,QQi,Pi,bQi,bPi,&bQi,&bPi); 
		dbia1 = isum(dbia1,ei); 
		if ( !lfirst(bQi) ) break;
 		bQi = udpmsmonic(m,bQi);
		udpmsqrem(m,bPi,bQi,&bPi);
		i = lthird(bQi) % hush;
		j = ( lfirst(bQi) == 1 ) ? (hush) : (lfourth(bQi) % hush);
		if( IDEALS[i][j] ) dai = qffmssearchs(m,IDEALS[i][j],bQi,bPi);
	}
	while( !dai ) ;

        R = idif(dbia1,dai);
	return(R);
}
