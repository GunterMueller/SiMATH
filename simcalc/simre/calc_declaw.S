/*C
			calc_declaw( fkeller ) 

	"calculator decomposition law"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_declaw( fkeller );  list fkeller;
	X = calc_declaw( fkeller );

	fkeller enthaelt eine Primzahl p.
	Berechnet werden Verzweigungsindices und Restklassengrade
	der Fortsetzung von p in den aktuellen Zahlkoerper.
	X = fkeller;
	Laeuft calc_declaw fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      30.09.1992      U.Schneiders
H*/

#include <_calc.h>

list calc_declaw( fkeller )
list fkeller;
{
	single e, f, r;
	int p;
	list L;
	list(AVL);
	obj F;
	init( p, L, AVL, F );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 || lsecond( fkeller ) )
	{	mistake( 188 );
		return( ERROR );
	}
	
	p = lfirst( fkeller );
	if( isatom( p ) && issprime( p, &F ) <= 0 )
	{	mistake( 188 );
		return( ERROR );
	}
	else if(!isatom(p))
	{
		L = ispd(p,&F);
		if(L!=_0) 
		{
			mistake(188);
			return(ERROR);
		}
	}

	if( !nfsch )
	{	mistake( 163 );
		return( ERROR );
	}		

	/*** Berechnung und Ausgabe ***/

	F = lfirst( varlist[nfsch].varwert );
	L = lsecond( F );
	if( icomp( L, 1 ) )
	{	mistake( 192 );
		return( ERROR );
	}
	if( isatom( p ) ) L = nfspdeclaw( F, p );
	else	          L = nfipdeclaw( F, p );

	r = llength( L ) / 2;	
	if(!assch)
	{   if(r==1) 
	    {	printf( " In the current number field the prime %i has 1 extension.\n", p );
	    	printf( " The ramification index and residue class degree (e,f) are:\n" );
	    }
	    else 
	    {	printf( " In the current number field the prime %i has %i extensions.\n", p, r );
	    	printf( " The ramification indices and residue class degrees (e_i,f_i) are:\n" );
	    }
	    if( ps )
	    { if(r==1) 
	      {	fprintf( datei, "out: In the current number field the prime %i has 1 extension.\n", p );
	      	fprintf( datei, "     The ramification index and residue class degree (e,f) are:\n    " );
	      }
	      else 
	      {	fprintf( datei, "out: In the current number field the prime %i has %i extensions.\n", p, r );
	      	fprintf( datei, "     The ramification indices and residue class degrees (e_i,f_i) are:\n    " );
	      }
	    }
	}
	if(avsch)  AVL=list1(list2(r,0));

	for( ; r; r-- )
	{	e = lfirst( L );
		f = lsecond( L );
		L = lred2( L );
		if(!assch)
		{  printf( " (%i,%i)", e, f );
		   if( ps ) fprintf( datei, " (%i,%i)", e, f );
		   if( L != _0 )
		   {	printf( "," );
			if( ps ) fprintf( datei, "," );
		   }
		}
		if(avsch)
		{	AVL=lcomp(list2(e,0),AVL);
			AVL=lcomp(list2(f,0),AVL);
		}
	}
	if(!assch)
	{  printf( "\n" );
	   if( ps ) fprintf( datei, "\n" ); 
	}
	if(avsch)
	{	AVL=linv(AVL);
		av_basad(AVL);
	}

	return( fkeller );
}
		

