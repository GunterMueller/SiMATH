/*C
			calc_linequ(  fkeller )

	"calculator linear equations".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_linequ( fkeller );  list fkeller;
	X = calc_linequ( fkeller );

	fkeller enthaelt eine mxn-Matrix A und einen Vektor b der
	Laenge m. Geloest werden soll das lineare Gleichungssytem
		      (*) A * X = b
	ueber Q, rationalen Funktionen, Z/pZ, Zahlkoerpern und
	endlichen Koerpern.
	Ist (*) eindeutig loesbar, so ist X = A^(-1) * b,
		unloesbar,                X = -BASIS,
		loesbar( aber nicht eindeutig ), so ist X eine spe-
			  zielle Loesung und ausgegeben wird der Null-
			  raum von A.
	Laeuft calc_linequ fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      30.01.1989      C.Hollinger/U.Schneiders
	Version  2      11.12.1992      U.Schneiders ( Q, rat.Fkt,
						       Z/pZ, NF )
	Version  3	26.07.1993	S.Schmitt ( gf )
	Version  3.1	07.03.1996	S.Schmitt ( GF(2) )
	Version  3.2	09.10.1996	S.Schmitt ( GF(2)  die zweite )
H*/

#include<_calc.h>
list calc_linequ( fkeller )
list fkeller;
{
	single kenA, kenb, r, s, ma2=0;
	obj A, b, erg, M;
	matrix pN;
	vec pX;
	list VL, VLb;
	list AVL;
	init( A, b, erg, M, pN, pX, VL, VLb, AVL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"linequ" );
		return( -BASIS );
	}
	A = lsecond( fkeller );
	kenA = lsecond( A );
	if( kenA == 19 && ( !ssch || !pzsch ) )
	{	mistake( 196 );
		return( ERROR );
	}
	if( kenA < 5 || ( kenA > 9 && kenA != 19 && kenA != 26 && kenA != 33 ) )
	{       mistake( 91 );
		return( -BASIS );
	}
	A = lfirst( A );
	if( kenA > 6 && kenA < 10 )
	{	VL = lfirst( A );
		A = lsecond( A );
	}
	if(kenA==19 && lfirst(varlist[modsch].varwert)==2) 
	{	M=lred(A);
		if(isnullma(M))
		{	mistake(92);
			return(ERROR);
		}
		ma2=1;
	}
	else if( isnullma( A ) )
	{       mistake( 92 );
		return( -BASIS );
	}
	if(ma2) s=llength(M);
	else s = manrrow( A );
	ma2=0;
	b = lfirst( fkeller );
	kenb = lsecond( b );
	if( kenb == 21 && ( !ssch || !pzsch ) )
	{	mistake( 196 );
		return( ERROR );
	}
	if( kenb < 10 || ( kenb > 14 && kenb != 21 && kenb != 28 && kenb != 35 ) )
	{       mistake( 91 );
		return( -BASIS );
	}
	b = lfirst( b );
	if( kenb > 11 && kenb < 15 )
	{	VLb = lfirst( b );
		b = lsecond( b );
	}
	if( llength( b ) != s )
	{       mistake( 72 );
		return( -BASIS );
	}

	/*** Anpassung bei unpassender Kennung. ***/

	if( kenA > 6 && kenA < 10 ) A = list2( VL, A );
	if( kenb > 11 && kenb < 15 ) b = list2( VLb, b );
	kenA = vmtyper( b, A, kenb, kenA, &pX, &pN, 1 );
	if( kenA == ERROR ) return( ERROR );
	if( kenA > 9 && kenA != 19 && kenA != 26 && kenA != 33 )
	{       mistake( 91 );
		return( -BASIS );
	}

	if( kenA < 15 )  kenb = kenA + 5;
	else		 kenb = kenA + 2; 	

	if( kenA > 6 && kenA < 10 )
	{	VL = lfirst( pN );
		A = lsecond( pN );
		b = lsecond( pX );
		r = llength( VL );
	}
	else
	{	A = pN; b = pX; }
	pN = _0;  pX = _0;

	if( kenA == 5 )         A = maitomar( A );
	else if( kenA == 7 )    A = mapitomarfr( r, A );
	else if( kenA == 8 )	A = maprtomarfr( r, A );
	if( kenb == 10 )        
	{	b = vecitovecr( b ); kenb = 11; }
	else if( kenb == 12 )	
	{	b = vecpitovrfr( r, b ); kenb = 14; }
	else if( kenb == 13 )	
	{	b = vecprtovrfr( r, b ); kenb = 14; }
	
	/*** Berechnung der Loesungsmenge von A * X = b. ***/

	switch( kenA )
	{	case  5:
		case  6: s = marssle( A, b, &pX, &pN );
			 break;
		case  7:
		case  8:
		case  9: s = marfrssle( r, A, b, &pX, &pN );
			 break;
		case 19: M = lfirst( varlist[modsch].varwert );
			 if(M==2)
			 {	b=list1(b);
			 	b=mamstomam2(b);
				s=mam2ssle(A,b,&pX, &pN);
				ma2=1;
			 }
			 else s = mamsssle( M, A, b, &pX, &pN );
			 break;
		case 26: M =lfirst( varlist[nfsch].varwert );
			 s = manfssle( M, A, b, &pX, &pN );
			 break;
		case 33: M = lfirst( varlist[gfsch].varwert );
			 if(gfchar==2) s = magf2ssle( M, A, b, &pX, &pN );
			 else s = magfsssle( gfchar, M, A, b, &pX, &pN );
			 break;
	}

	if( s == -1 )
	{       if(!assch){
		printf(" The system of linear equations is unsolvable over ");
		if( ps )
		fprintf(datei,"out: The system of linear equations is unsolvable over ");
		switch( kenA )
		{	case  5:
			case  6: printf( "Q!\n" );
				 if( ps ) fprintf( datei, "Q!\n" );
				 break;
			case  7:
			case  8:
			case  9: printf( "rational functions!\n" );
			 	 if( ps ) fprintf( datei, "rational functions!\n" );
				 break;
			case 19: printf( "Z/%iZ!\n",M ); 
				 if( ps ) fprintf( datei, "Z/%iZ!\n",M );
				 break;
			case 26: printf( "the current number field!\n" );
				 if( ps ) fprintf( datei, "the current number field!\n" );
				 break;
			case 33: printf( "the current Galois-field!\n" );
				 if( ps ) fprintf( datei, "the current Galois-field!\n" );
				 break;
		}
		}
	/*** h.linequ ***/
		return( -BASIS );
	}
	if( s == 0 )    
	{	if( kenb == 14 )  pX = list2( VL, pX );
		if(ma2) 
		{	pX=mam2tomams(pX);
			pX=lfirst(pX);
		}	
	        erg = list2( pX, kenb );
	}
	else    /*** Existenz mehrerer Loesungen. ***/
	{      	if( kenb == 14 ) pX = list2( VL, pX ); 
		if(ma2) 
		{	pX=mam2tomams(pX);
			pX=lfirst(pX);
			pN=mam2tomams(pN);
		}	
		erg = list2( pX, kenb );
		if(!assch)
		{  printf(" The null space of the system of linear equations is generated by:\n");
		   if( ps )
		      fprintf(datei,"out: The null space of the system of linear equations is generated by:\n");
		}
		if(avsch) AVL=_0;
		while( pN != _0 )
		{       pX = lfirst( pN );
			pN = lred( pN );
			if( kenb == 14 ) pX = list2( VL, pX );
			if(avsch) AVL=lcomp(list2(pX,kenb),AVL);
			if(!assch) vecaus( pX , kenb );
		}
		if(assch)
		{  printf("\n A specific solution of the system of linear equations is:\n");
		   if( ps )
		      fprintf(datei,"\nout: A specific solution of the system of linear equations is:\n");
		}
		if(avsch)
		{	AVL=linv(AVL);
			av_basad(AVL);
		}
	}
	return( erg );
}
