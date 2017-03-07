/*M
.SH NAME
isiuspi - is irreducible univariate squarefree polynomial over integers ?

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isiuspi(P)  
pol P;
 
.SH DESCRIPTION
.TP 4
.B P
is an univariate, primitive and square-free polynomial over the integer numbers.
.PP
isiuspi returns 
.PP
 1,     if P is irreducible,
 0,     if P is reducible or 0,
 ERROR, in case of an error occurs.

M*/
     
/*H
	Version 1       06.12.1988      Modifizierung von uspifact.   RB
        Version 2       22.05.1989      C.H/U.S ( isiuspisub1.S
                                               in Apollo-Version )    
	Version 3       04.07.1991      ueberfl. Variable Q beseitigt.  PS
   DATE isiuspi       : 890501.890601.910715
H*/


# include <_pol2.h>

static single isiuspisub1(pol);
static single isiuspisub2(int,pol,list);
static obj    degset;
static list   LF;

single isiuspi( P )
pol P;
{
	single s, prime;
	bind( P );
	init( degset, LF );

   /*** Produkte der Faktoren gleichen Grades fuer passende  ***/
   /***      Primzahl 'prime' nach 'LF' herausfiltern;       ***/
   /*** Charakteristische Menge der Grade 'degset' bestimmen ***/
	s = prime = isiuspisub1( P );

   /*** falls P nicht als irreduzibel erwiesen, falls keine Fehlermeldung ***/
	if ( s!=1  &&  s!=ERROR )  {
	   /*** Deklarationen ***/
		single k, n1;
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

	   /*** Koeffizientenabschaetzung ***/
		M = iprod( lsecond(P), pisumnorm(1,P) );
		M = ip2prod( M, lfirst(P) );
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

	   /*** einen Faktor suchen durch Kombinieren der Hensel-Faktoren ***/
		s = isiuspisub2( q, P, LH );
	}

/*** Ergebnis ***/
return( s );
}



static single isiuspisub1( P )
pol P;

   /***    'isiuspisub1' ist identisch mit 'uspifactsub1'    ***/
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
			fprintf( stderr,"\nFehler in isiuspi: ");
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
                                k = lfirst( F1 );
				k = divs( k, d1);
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



static single isiuspisub2( q, P, LH  )
int q;
pol P;
list LH;

   /*** einen Faktor suchen durch Kombinieren der Hensel-Faktoren ***/
{
	single anz, anzmax, grad, i;
	int    b0, b1, c0;
	list   M, Red;
	pol    cpol, F, f, P0, R;
	bind( q, LH );
	init( b1, c0, M, cpol, P0 );

   /*** Initialisierungen ***/
	anz = 1;
	anzmax = llength( LH );
	LH = lpermut( LH, lsrandperm(anzmax) );

   /*** Polynom vorbereiten ***/
	c0 = lsecond( P );
	P0 = piiprod( 1, P, c0 );
	cpol = list2( 0,c0 );
	b0 = ptbc( 1,P0 );
	c0 = mihom( q,c0 );
	while ( anz <= anzmax/2 )  {

       /*** (neue) Menge von Faktoren zum Test vorbereiten ***/
	    Red = LH,  M = _0;
	    for ( i=1; i<=anz; i++ )  {
		M = lcomp( Red,M );
		Red = lred( Red );
	    }
	    do {

	   /*** aktuelle Kombination aus M vorpruefen ***/
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
		   /*** aktuelle Kombination aus M genau nachrechnen ***/
			for ( Red=M, F=cpol; Red!=_0; Red=lred(Red) ) {
				f = lfirst( lfirst(Red) );
				F = pmiprod( 1, q, F, f );
			}
			F = pmitos( 1, q, F );
			piqrem( 1, P0, F, &R );

		   /*** Ende, falls Faktor gefunden ***/
			if ( R==0 )  return( 0 );
		}

	   /*** naechste Menge zum Test vorbereiten ***/
		M = lrednext( M );
	    }
	    while ( M != _0 );

       /*** falls kein Faktor gefunden wurde: Anzahl der ***/
       /*** zusammenzufassenden Hensel-Faktoren erhoehen ***/
	    anz++;
	}

   /*** jetzt P als irreduzibel erwiesen ***/
	return( 1 );
}
