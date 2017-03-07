/*M
.SH NAME
spifact - squarefree polynomial over integers factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list spifact( r, P )  
single r; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
With regard to the main variable, P is primitive, square-free and has positive degree and leading coefficient. 
.PP
spifact returns a list, consisting of the various positive and irreducible factors of P.
.PP
spifact returns ERROR, in case of an error occurs.
 
M*/

/*H
	Version 1       06.04.89        A. Stein
	Version 2       05.05.89        1) neue Fu. pigfcb anstatt pifcb.
					   ( cS geaendert ).
					2) Var. grad weggelassen.
					3) bei piquot if-Abrage nach Null.  AS
   DATE spifact       : 891101.9203__
H*/


# include <_pol2.h>

static list spifactsub(single,int,list,pol,list);

list spifact( r, P )
single r;
pol P;
{
	list L;
	init(L);
	bind(P);

/*** P univariat. ***/
	if( r == 1 ) L = uspifact( P );
	else {
	    pol P1;
	    list TRL,L1;
	    init(P1,L1,TRL);

/*** Berechnung eines geeigneten univariaten Polynoms P1(X),   ***/
/*** bzgl. der Hauptvariablen X von P, durch Auswertung von P. ***/
	    P1 = picevalp(r,P,&TRL);
	    P1 = piabs(1,P1);
	    P1 = piprimpart(1,P1);

/*** Faktorisierung von P1. ***/
	    L1 = uspifact( P1 );

/*** Ergebnis, falls P1 irreduzibel. ***/
	    if( lred(L1) == _0 ) L = list1(P);
	    else {
		single *lp,p,s,d1,d1m;
		pol f,PT,P1m,GCD,lc,Q;
		list S,L1m,TP,DV;
		int M,CB;
		init(PT,P1m,Q,S,L1m,TP,DV,M,CB);

/*** Vorbereitung der Translation. ***/
		TRL = linv(TRL);
		TRL = lcomp(0,TRL);

/*** Translation : P  --> P + TRL . ***/
		PT = pitransav(r,P,TRL);

/*** Finde Primzahl, die die Diskriminante von P1 nicht teilt.  ***/
		lp = LIST_SP;
		d1 = lfirst(P1);
		do {
			p = *lp;
/*** falls Primzahlliste erschoepft ***/
		    if (p==0)  {
		      fprintf( stderr,"\nFehler in spifact: ");
		      fprintf( stderr,"Primzahlliste LIST_SP erschoepft");
		      return(ERROR);
		    }

			P1m = pitopms(1,P1,p);
			d1m = lfirst(P1m);
			if ( d1m == d1 ) {
				Q = pmsderiv(1,p,P1m);
				GCD = upmsgcd(p,P1m,Q);
				s = lfirst(GCD);
			}

			lp++;
		}
		while( ( d1m != d1 ) || ( s != 0 ) ) ;

/*** Transformiere die Faktoren von P1 aus der Liste L1  ***/
/*** zu normierten Faktoren modulo p.                    ***/
		for( L1m = _0 ; L1 != _0 ; L1 = lred(L1) ) {
			f = lfirst(L1);
			f = pitopms(1,f,p);
			f = pmimonic(1,p,f);
			L1m = lcomp(f,L1m);
		}


/*** Koeffizientenabschaetzung ***/
		lc = plc(r,PT);
		Q = piprod(r,PT,list2(0,lc));
		CB = pilmfcb(r,Q);
		CB = ip2prod(CB,1);

		for( M=p; icomp(M,CB)<=0; M=isprod(M,p) );

/*** Gradabschaetzungen ***/
		DV = pdegvec(r,Q);
		for( S = _0, DV=lred(DV); DV != _0; DV = lred(DV) ) {
			s = lfirst(DV) + 1;
			S = lcomp(s,S);
		}

/*** Ermitteln der normierten Hensel-Faktoren modulo M      ***/
/*** von P mithilfe der irreduziblen Faktoren modulo p des  ***/
/*** univariaten Polynoms P1.                               ***/

		L = pihlfa(r,p,L1m,M,S,PT);

/*** Kombinieren der Hensel-Faktoren ***/

		L1 = spifactsub(r,M,S,PT,L);

/*** Ruecktranslation : Faktoren von PT --> Faktoren von P  ***/
		for( TP = _0; TRL != _0; TRL = lred(TRL) ) {
			s = lfirst(TRL);
			TP = lcomp(ineg(s),TP);
		}
		for(TP=linv(TP), L=_0; L1 != _0; L1=lred(L1)) {
			f = lfirst(L1);
			f = pitransav(r,f,TP);
			L = lcomp(f,L);
		}
	    }
	}

/*** Ergebnis ***/
	return( L );

}



static list spifactsub( r, M, S, P, LH  )
single r;
int M;
list S;
pol P;
list LH;
{
	single anz, anzmax, i;
	int    b0, b1, c0;
	list   L, L1, LM, Red;
	pol    cpol, F, f, P0, Q, R;
	bind( M, S, P, LH );
	init( b0, b1, c0, L, LM, cpol, R, F, P0, Q );

   /*** Initialisierungen ***/
	anz = 1,  L = _0;
	anzmax = llength( LH );
	LH = lpermut( LH, lsrandperm(anzmax) );

	for ( ; ; ) {

	   /*** Polynom vorbereiten ***/
		cpol = plc( r, P );
		c0 = ptbc(r-1,cpol);
		cpol = list2( 0,cpol );
		P0 = piprod( r, cpol, P );
		b0 = ptbc( r,P0 );
		c0 = mihom( M,c0 );
		while ( anz <= anzmax/2 )  {

	       /*** neue Menge von Faktoren zum Test vorbereiten ***/
		    Red = LH,  LM = _0;
		    for ( i=1; i<=anz; i++ )  {
			LM = lcomp( Red,LM );
			Red = lred( Red );
		    }
		    do {

		   /*** pruefen, ob erste Kombination aus LM ein Faktor ***/
			Red = LM,  b1 = c0;
			do {
				f = lfirst( lfirst(Red) );
				b1 = miprod( M, b1, ptbc(r,f) );
				Red = lred( Red );
			}
			while ( Red !=_0 );
			b1 = mitos( M, b1 );
			if (( b1!=0 || b0==0 )
			&& ( b0 == 0 || irem(b0,b1)== 0 ))
			{
				for(Red=LM,F=cpol;Red!=_0;Red=lred(Red)) {
					f = lfirst( lfirst(Red) );
					F = pmimidprod( r, M, S, F, f );
				}
				F = pmitos( r, M, F );
				Q = piqrem( r, P0, F, &R );
				if ( R==0 )  break;
			}

		   /*** naechste Menge zum Test vorbereiten ***/
			LM = lrednext( LM );
		    }
		    while ( LM != _0 );

	       /*** falls kein Faktor gefunden wurde: Anzahl der ***/
	       /*** zusammenzufassenden Hensel-Faktoren erhoehen ***/
		    if ( LM==_0 )  anz++;

	       /*** falls Faktor gefunden wurde ***/
		    else  break;
		}

	   /*** falls fertig ***/
		if ( anz > anzmax/2 )  return( lcomp(P,L) );

	   /*** gefundenen Faktor aussondern ***/
		F = piprimpart( r,F );
		L = lcomp( F,L );
		cpol = list2(0,plc(r,F));

		R = piquot( r, Q, cpol );
		if( R ) P = R;
		else P = Q;

		anzmax -= anz;
		do {
		       L1 = lfirst( LM );
		       if ( L1 == LH )  LH = lred( LH );
		       else {
				Red = lred( L1 );
				LH = linv( LH );
				L1 = lred( L1 );
				LH = linv( LH );
				lsred( L1, Red );
			}
			LM = lred( LM );
		}
		while ( LM != _0 );
	}
}
