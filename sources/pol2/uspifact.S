/*M
.SH NAME
uspifact - univariate squarefree polynomial over integers factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list uspifact( P )  
pol P;
   
.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the integer numbers.
P is primitive, square-free and has positive
degree and leading coefficient.
.PP                                                                             
uspifact returns a list, consisting of the various positive and irreducible factors of P.
.PP                                                                             
uspifact returns ERROR, in case of an error occurs.                              
M*/

/*H
	Version 1       06.05.88        R. Boeffgen
	Version 2       07.07.88        "lperm"     --> "lpermut";
					"srandperm" --> "lsrandperm".  RB
	Version 3       06.12.88        cS korrigiert;
					in 'uspifactsub1' jetzt 'prime=1'
					wo bisher 'prime=0', so dass
					'uspifactsub1' identisch mit
					'isiuspisub1';
					hierbei moegl. Rueckgabe 1 statt 0
					an 'uspifact' beruecksichtigt.  RB
	Version 4       21.06.89        neue Koeffizientenabschaetzung mit
					Landau-Mignotte-Grenze.  AS
   DATE uspifact      : 890501.891101.9203__
H*/


# include <_pol2.h>

static obj    degset;
static list   LF;
static single uspifactsub1(pol);
static list uspifactsub2(int,pol,list);

list uspifact( P )
pol P;
{
	single prime;
	list   L;
	bind( P );
	init( degset, LF );

   /*** Produkte der Faktoren gleichen Grades fuer passende  ***/
   /***      Primzahl 'prime' nach 'LF' herausfiltern;       ***/
   /*** Charakteristische Menge der Grade 'degset' bestimmen ***/
	prime = uspifactsub1( P );

   /*** falls Fehlermeldung in uspifactsub1() ***/
	if ( prime == ERROR )  L = ERROR;

   /*** Ergebnis, falls P als irreduzibel erwiesen ***/
	else if ( prime == 1 )  L = list1( P );
	else {

	   /*** Deklarationen ***/
		single c, k, n1;
		list   L1, LB, LB1, LH;
		int    M, q;
		pol    F1, P0;
		init( LB, LH, M, q );

	   /*** Faktoren gleichen Grades ermitteln ***/
		for ( LB=_0;  LF!=_0;  LF=lred2(LF) ) {
			F1 = lfirst( LF );
			n1 = lsecond( LF );
			if ( lfirst(F1) == n1 )  LB = lcomp( F1, LB );
			else {
				LB1 = upmsbfact( prime, F1, n1 );
				if (LB1==ERROR)  return( ERROR );
				LB = lconc( LB1, LB );
			}
		}

/*** Alte Koeffizientenabschaetzung:                                ***/
/*** M = | an | * 2 ^ Gr(P) * pisumnorm(P)                          ***/


/*** Neue Koeffizientenabschaetzung:                                ***/
/*** n1==Gr(P)<= 4: M = 2 * Bin(n1,n1-n1/2) * Euklidnorm(P)         ***/
/*** n1==Gr(P)> 4: M = 2^( 1+n1/2 ) * ssqrt(n1+1) * Maxnorm(P)      ***/

	    if( lfirst(P) <= 4 ) {
		M = pilmfcb( 1 , P ) ;
		M = ip2prod( M , 1 );
	    }
	    else {
		n1 = lfirst(P);
		M = ssqrt(n1+1);
		M = isprod( pimaxnorm( 1 , P ) , M );
		n1 = 1 + ( n1/2 ) ;
		M = ip2prod( M , n1 ) ;
	}

		for ( k=1, q=prime;  icomp(q,M)<=0;  k++, q=isprod(q,prime) );

	   /*** Ermitteln der normierten Hensel-Faktoren modulo q ***/
		P0 = pitopmi( 1, P, q );
		P0 = pmimonic( 1, q, P0 );
		LH = upihlfa( prime, P0, LB, k );
		for ( L1=LH;  L1!=_0;  L1=lred(L1) )  {
			F1 = lfirst( L1 );
			F1 = pitopmi( 1, F1, q );
			lsfirst( L1, F1 );
		}
	   /*** Kombinieren der Hensel-Faktoren ***/
		L = uspifactsub2( q, P, LH );
	}

   /*** Ergebnis ***/
	return( L );
}



static single uspifactsub1( P )
pol P;

   /***    'uspifactsub1' ist identisch mit 'isiuspisub1'    ***/
   /*** Produkte der Faktoren gleichen Grades fuer passende  ***/
   /***      Primzahl 'prime' nach 'LF' herausfiltern;       ***/
   /*** Charakteristische Menge der Grade 'degset' bestimmen ***/
{
	list   L, Ldeg, LF1;
	obj    DS, DS0;
	single d1, fanz, i,j,k, *lp, n, p, panz, prime;
	int    c;
	pol    F, F1;
	bind( P );
	init( c, DS0, F, F1, Ldeg, LF1 );

   /*** Initialisierungen ***/
	lp = LIST_SP,   panz = 10;
	c = lsecond(P),   n = lfirst(P);
	DS0 = csetunion( ip2prod(1,n), 1 );
	n++;
	degset = idif( ip2prod(1,n), 1 );

   /*** geeignete Primzahl suchen ***/
	for ( i=prime=1;  !oequal(degset,DS0) && i<=panz;  lp++ )  {
		p = *lp;

	   /*** falls Primzahlliste erschoepft ***/
		if (p==0)  {
		    if (prime==1)  {
			fprintf( stderr,"\nFehler in uspifact: ");
			fprintf( stderr,"Primzahlliste LIST_SP erschoepft");
			prime = ERROR;
		    }
		    break;
		}

	   /*** Gradbedingung und Separabilitaet von P modulo p testen ***/
		if ( isrem(c,p) )  {
		    F = pitopms( 1,P,p );
		    F1= pmsderiv( 1,p,F );
		    if ( lfirst( upmsgcd(p,F,F1) ) == 0 )  {

		   /*** Gradliste der irreduziblen Faktoren (mod p) herstellen ***/
			F1 = pmsmonic( 1,p,F );
			LF1= upmsddfact( p,F1 );
			L=LF1,  fanz=0,  Ldeg=_0;
			while ( L != _0 )  {
				F1 = lfirst(L),  L = lred(L);
				d1 = lfirst(L),  L = lred(L);
				k = lfirst(F1) / d1;
				fanz += k;
				for ( j=0;  j++<k;  Ldeg=lcomp(d1,Ldeg) );
			}

		   /*** falls p geeigneter als prime ***/
			if ( fanz < n )  prime=p, n=fanz, LF=LF1;

		   /*** Charakteristische Menge der Grade aktualisieren***/
			DS = csetpart( Ldeg );
			degset = csetinter( DS, degset );
			i++;
		    }
		}
	}

   /*** falls P irreduzibel ***/
	if ( oequal(degset,DS0) )  prime=1, LF=_0;

   /*** Ergebnis ***/
	return( prime );
}



static list uspifactsub2( q, P, LH  )
int q;
pol P;
list LH;
{
	single anz, anzmax, grad, i;
	int    b0, b1, c0;
	list   L, L1, M, Red;
	pol    cpol, F, f, P0, Q, R;
	bind( q, P, LH );
	init( b1, c0, L, M, cpol, F, P0, Q );

   /*** Initialisierungen ***/
	anz = 1,  L = _0;
	anzmax = llength( LH );
	LH = lpermut( LH, lsrandperm(anzmax) );

	for ( ; ; ) {

	   /*** Polynom vorbereiten ***/
		c0 = lsecond( P );
		cpol = list2( 0,c0 );
		P0 = piiprod( 1, P, c0 );
		b0 = ptbc( 1,P0 );
		c0 = mihom( q,c0 );
		while ( anz <= anzmax/2 )  {

	       /*** neue Menge von Faktoren zum Test vorbereiten ***/
		    Red = LH,  M = _0;
		    for ( i=1; i<=anz; i++ )  {
			M = lcomp( Red,M );
			Red = lred( Red );
		    }
		    do {

		   /*** pruefen, ob erste Kombination aus M ein Faktor ***/
			Red = M,  b1 = c0,  grad = 0;
			do {
				f = lfirst( lfirst(Red) );
				grad += lfirst( f );
				b1 = miprod( q, b1, ptbc(1,f) );
				Red = lred( Red );
			}
			while ( Red !=_0 );
			b1 = mitos( q, b1 );
			if (( b1!=0 || b0==0 )
			&&  iodd( ip2quot(degset,grad) )
			&&  ( b0==0 || irem(b0,b1)==0 ) )
			{
				for ( Red=M, F=cpol; Red!=_0; Red=lred(Red) ) {
					f = lfirst( lfirst(Red) );
					F = pmiprod( 1, q, F, f );
				}
				F = pmitos( 1, q, F );
				Q = piqrem( 1, P0, F, &R );
				if ( R==0 )  break;
			}

		   /*** naechste Menge zum Test vorbereiten ***/
			M = lrednext( M );
		    }
		    while ( M != _0 );

	       /*** falls kein Faktor gefunden wurde: Anzahl der ***/
	       /*** zusammenzufassenden Hensel-Faktoren erhoehen ***/
		    if ( M==_0 )  anz++;

	       /*** falls Faktor gefunden wurde ***/
		    else  break;
		}

	   /*** falls fertig ***/
		if ( anz > anzmax/2 )  return( lcomp(P,L) );

	   /*** gefundenen Faktor aussondern ***/
		F = piprimpart( 1,F );
		L = lcomp( F,L );
		P = piiquot( 1, Q, lsecond(F) );
		anzmax -= anz;
		do {
			L1 = lfirst( M );
			if ( L1 == LH )  LH = lred( LH );
			else {
				Red = lred( L1 );
				LH = linv( LH );
				L1 = lred( L1 );
				LH = linv( LH );
				lsred( L1, Red );
			}
			M = lred( M );
		}
		while ( M != _0 );
	}
}
