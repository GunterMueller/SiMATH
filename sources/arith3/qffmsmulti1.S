/*M
.SH NAME
qffmsmulti1 \- 
quadratic function field over modular singles,
search for a multiple of the regulator, first case
.\" ( q, D, d, E, L, Ls )

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmsmulti1( q, D, d, E, L, Ls )
single q;
int E, L, Ls; 
pol D, d;

H1 = qffmsmulti1( q, D, d, E, L, Ls );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q < BASIS. Let k := Z/qZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.

.TP 4
.B Condition:
	100 < q < 10000 or deg(D) <= 8
.TP 4
.B d 
= principal part of D^(1/2) in dense representation.

.TP 4
.B E, L
are integers > 1 such that

    | h - E | < L^2  ,

where h = h' * R = divisor class number of k(X,Y).
Since one has to store approximately L ideals, L should be chosen
according to the space limitations (for normal use L <= 20000).

.TP 4
.B Ls
is an integer >= 0, and defines the starting point for
the search in the interval [E-L^2,E+L^2]. 
If Ls = 0, then Ls is set to L by default.

.TP 4
.B H1
is a multiple of the regulator R of k(X,Y) such that
 
    H1 = h0 * R < E + L^2.

.SH LITERATURE
A. Stein, "Algorithmen in reell-quadratischen Kongruenz-
funktionenk"orpern",
PhD Thesis, Universit"at des Saarlandes, Saarbr"ucken, 1996.

A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH NOTE
The multiple is found by means of baby step-giant step algorithm.
At the current stage, the algorithm does not make use of
computing several baby steps at each giant step. Also,
storing can be improved.

.SH SEE ALSO
.BR qffmsreglap(),
.BR qffmsregbgb1(),
.BR qffmsmulti2(), 
.BR etc.
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_arith3.h>

int qffmsmulti1( m, D, d, E, L, Ls )
single m;
int E, L, Ls; 
pol D, d;
{        
	single i, la, ind, ei;
	int H1, d_k, d_s, d_j, d_j1, d_bib1, d_l;
	list L1;
	list IDEALS[10000];
	pol G,C1,ai,Qim1,Qi,Qip1,Pi,Pip1,rim1,ri;
	pol QQi,cQi,cPi;
	pol Qk, Pk, Qs, Ps, Ql, Pl;
	bind( D, d, E, L, Ls );
	init(G,C1,L1,Qim1,Qi,Qip1,ai,Pi,Pip1,ri,rim1);
        init( H1, d_bib1, QQi, cQi, cPi, Ql, Pl );
	init( Qk, Pk, Qs, Ps, d_k, d_s, d_j, d_j1, d_bib1, d_l );
	init(IDEALS[0..m]);

	la = qffmsnearest(m, D, d, E, &Qk, &Pk); /* A_k = A( E ) */
	d_k = isum( E, la );

	la = qffmsnearest(m, D, d, L, &Qs, &Ps); /* A_s = A( E ) */
	d_s = isum( L, la );

	if( !Ls ) Ls = L;  /* Ls = L by Default */
	la = qffmsnearest(m, D, d, Ls, &Ql, &Pl); /* A_l = A( Ls ) */
	d_l = isum( Ls, la );

	Pk = udpmsneg( m, Pk ); /* conj(A_k) = [ Qk, - Pk + sqrt(D) ] */
        if ( !lfirst(Qk) ) return( d_k ); 
        QQi = udpmsmonic( m, Qk );
	i = lthird( QQi );
	L1 = list3( QQi, Pk, 0 );
	IDEALS[i] = list1( L1 ); 	

    /* giant steps : Init I  */     
	cQi = Ql;
	cPi = Pl;
	d_j = d_l; 
        d_j1 = d_s;
	if ( !lfirst(cQi) ) return(d_j);
        cQi = udpmsmonic( m, cQi );
	udpmsqrem(m,cPi,cQi,&cPi);

    /* baby steps */
	d_s = isum( d_s, lfirst( d ) );
	H1 = idif( d_k, lfirst( Qk ) );
	Pi = Pk;
	Qi = Qk; 
	ai = udpmssum(m,Pi,d);
	ai = udpmsqrem(m,ai,Qi,&ri);
	Pip1 = udpmsdif( m, d, ri );
	Qip1 = udpmsdif( m, D, udpmsprod( m, Pip1, Pip1 ) );
	Qip1 = udpmsquot( m, Qip1, Qi );
	d_bib1 = lfirst(d);
	d_bib1 = idif( d_bib1, lfirst( Qk ) );
        if ( !lfirst(Qip1) ) return( idif( H1, d_bib1 ) );
        QQi = udpmsmonic( m, Qip1 );
	i = lthird(QQi);
 	L1 = list3( QQi, Pip1, d_bib1 );
        if( !IDEALS[i] ) IDEALS[i] = list1(L1);
        else IDEALS[i] = lcomp(L1,IDEALS[i]);
              
 	while ( icomp( d_bib1, d_s ) <= 0 ) {
 		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
		ai = udpmssum( m, Pi, d );
		ai = udpmsqrem( m, ai, Qi, &ri );
		d_bib1 = isum( d_bib1, lfirst(ai) );
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
	        if ( !lfirst(Qip1) ) return( idif( H1, d_bib1 ) );
 		QQi = udpmsmonic(m,Qip1);
                i = lthird(QQi);
                L1 = list3(QQi,Pip1,d_bib1);
                if( !IDEALS[i] ) IDEALS[i] = list1(L1);
                else IDEALS[i] = lcomp(L1,IDEALS[i]);
	}  
         
	ind = 0;
	i = lthird(cQi);
	if( IDEALS[i] ) ind = qffmssearch( m, IDEALS[i], cQi, cPi , &d_bib1 );
        if( ind > 0 ) return( isum( H1, idif( d_j, d_bib1 ) ) );
	else if( ind < 0 ) return( idif( H1, isum( d_j, d_bib1 ) ) );

    /* giant steps : Init II */
        QQi = udpmsmonic( m, Qs );
	udpmsqrem(m,Ps,QQi,&Pi);
	C1 = udpmsprod(m,Pi,Pi);
	C1 = udpmsdif(m,D,C1);
	C1 = udpmsquot(m,C1,QQi);

    /* giant steps: IC_j = IA_s * IC_{j-1}, IC_1 = A_l = A(Ls) */
	do {                             
		d_j = isum( d_j, d_j1 );   
        	ei = qffmsgsrpi(m,D,d,C1,QQi,Pi,cQi,cPi,&cQi,&cPi); 
		d_j = isum( d_j, ei );
		if ( !lfirst(cQi) ) return( d_j );
		i = lthird(cQi);
		if( IDEALS[i] ) ind = qffmssearch( m, IDEALS[i], cQi, cPi, &d_bib1 );
 	}
	while( !ind ) ;

        if( ind > 0 ) H1 = isum( H1, idif( d_j, d_bib1 ) );
	else H1 = idif( H1, isum( d_j, d_bib1 ) );
	return( H1 );
}