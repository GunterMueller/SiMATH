/*M
.SH NAME
qffmsregobg - quadratic function field over modular singles regulator, original baby step - giant step version

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsregobg(m, D)  
single m; 
pol D;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a monic and squarefree polynomial in Z/mZ[X] of even degree, i.e. Z/mZ(X,D^(1/2)) is a real quadratic function field. 
.PP
qffmsregobg computes and returns the regulator of Z/mZ(X,D^(1/2)) by using the original baby step - giant step - algorithm. 
.SH NOTES
The computation requires a lot of memory space. The function had to compute s = 3*q^[deg(D)/4]/2 ideals, so the memory for 4*s polynomials of degree <= 1/2*deg(d) and s integral numbers will be need. A faster version is given by qffmsregbg.

.SH SEE ALSO
qffmsregbg

M*/
            
/*H
        Version 1       26.05.1991	A.Stein  
	Version 2       28.10.1991      korrekte Def. von s. AS
	Version 3	04.01.1993	upobgidtest verbessert. AS
   DATE qffmsregobg   : 910715.920331.9211__.930531
H*/

#include <_arith3.h>

int qffmsregobg(m,D)
single m;
pol D;
{
	single dai,das,s,i,j,ei;
	int R,dbia1,M;
	list L;
	list IDEALS[100][100];
	pol G,C1,ai,d,Qim1,Qi,Qip1,Pi,Pip1,rim1,ri;
	pol QQi,bQi,bPi;
	bind(D);
	init(G,C1,L,Qim1,Qi,Qip1,ai,Pi,Pip1,d,ri,rim1);
        init(R,dbia1,M,QQi,bQi,bPi);
	
	i = m - 1;
	init(IDEALS[0..i][0..m]);
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
	i = lthird(QQi);
	j = ( lfirst(QQi) == 1 ) ? (m) : (lfourth(QQi));
 	L = list3(QQi,Pi,dai);
	IDEALS[i][j] = list1(L); 
    /* s = Max{ ( m^[grad(D)/4] * 3/2 ) , 10000 }  */
	if ( dai % 2 ) {
		M = iexp(m,dai);
		M = isqrt(M); 
	}
	else M = iexp(m,(dai/2));
	M = isprod(M,(3/2));
	s = imin(M,10000);
	while( --s ) {
		ai = udpmssum(m,Pi,d);
		ai = udpmsqrem(m,ai,Qi,&ri);
		dai = dai + lfirst(ai);
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
		if(!lfirst(Qip1)) return(dai);
		QQi = udpmsmonic(m,Qip1);
		i = lthird(QQi);
		j = ( lfirst(QQi) == 1 ) ? (m) : (lfourth(QQi));
		L = list3(QQi,Pip1,dai);
		if( !IDEALS[i][j] ) IDEALS[i][j] = list1(L);
		else IDEALS[i][j] = lcomp(L,IDEALS[i][j]);
		Pi = Pip1;Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
	}

    /*   giant steps : Initialisierungen  */
	udpmsqrem(m,Pi,QQi,&Pi);
	C1 = udpmsprod(m,Pi,Pi);
	C1 = udpmsdif(m,D,C1);
	C1 = udpmsquot(m,C1,QQi);
	bQi = QQi;
	bPi = Pi;
        das = dai;
	dai = 0;
	dbia1 = das; 

    /* giant steps */
	do {                             
		dbia1 = isum(dbia1,das);   
		G = qffmspidprs(m,D,C1,QQi,Pi,bQi,bPi,&bQi,&bPi);  
		dbia1 = idif(dbia1,lfirst(G));   
		if( lfirst(bQi) >= lfirst(d) ) {
			ei = qffmsrpidred(m,D,d,bQi,bPi,&bQi,&bPi);  
			dbia1 = isum(dbia1,ei); 
		}
		if ( !lfirst(bQi) ) break;
 		bQi = udpmsmonic(m,bQi);
		udpmsqrem(m,bPi,bQi,&bPi);
		i = lthird(bQi);
		j = ( lfirst(bQi) == 1 ) ? (m) : (lfourth(bQi));
		if( IDEALS[i][j] ) dai = upobgidtest(m,IDEALS[i][j],bQi,bPi);
	}
	while( !dai ) ;
        R = idif(dbia1,dai);
	return(R);
}

single upobgidtest(m,L,Q,P)
single m;
list L;
pol Q,P; 
  /* L ist eine Liste von Tripeln  			            */
  /*	(QQi,Pi,dai)					            */
  /* die ein Ideal und deren Distanz zum Ursprung repraesentieren.  */
  /* Dieses Unterprogramm prueft lediglich, ob das Ideal	    */					
  /*	I = [ Q , P + D^(1/2) ]					    */
  /* in der Liste enthalten ist. Ist dies der Fall, so wird dai     */
  /* zurueckgeliefert und sonst 0.			            */			

{
	single index ;
	list L1;
	pol P2;
	bind(L,Q,P);
	init(L1,P2);

	do {
		do {
			L1 = lfirst(L);
			L = lred(L);
		}
		while( !( index = oequal(Q,lfirst(L1)) ) && L != _0 );
		if( index ) {
			P2 = lsecond(L1);
			udpmsqrem(m,P2,Q,&P2);
			if( oequal(P,P2) ) return(lthird(L1));
		}
	}
	while( L!=_0 );

	return(0);
}
 
