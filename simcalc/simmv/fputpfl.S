/*C
			fputpfl( r, P, V, pf )

	"file put polynomial over floating points"
	Quellbibliothek: srclib.simmv
	Include-Datei:   _calc.h
	single fputpfl(r,P,V,pf)  single r; pol P; list V; FILE *pf;
	a = fputpfl(r,P,V,pf);
	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber floating
	points. 
	Ist r gleich 0, so muss V die leere Liste sein; sonst ist
	V eine Liste V = (V1,...,Vr), wobei die Elemente Vi von V
	die Variablennamen repraesentieren, und zwar in der Form:
	  Vi = ( ascii(Bu) , ascii(BZ2) , ... , ascii(BZn) )
		falls der Name der i-ten Variablen aus den n
		alphanumerischen Zeichen Bu,BZ2,...,BZn besteht.
	Ein Variablenname muss immer mit einem Buchstaben beginnen.
	Die Liste Vr repraesentiert den Namen der Hauptvariablen.
	pf ist ein Zeiger auf eine zum Schreiben geoeffnete Datei.
	fputpfl schreibt ein Polynom in r Variablen ueber floating
	points auf die Datei *pf.
	fputpfl liefert den Ergebniswert 1.
C*/
/*H
	Version 1	24.01.1995	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

single fputpfl(r,P,V,pf)
single r;
pol P;
list V;
FILE *pf;
{                    
	bind( P );

	if (!P) fputs("0",pf);
	else if (!r) 
	{	if(!OUTPUTDIG) fputfl( P, -DIGITS, pf );
		else fputflfx(P, 1, OUTPUTDIG,pf);
	}
	else {
		single n, sch=0;
		obj kf, ks;
		bind(V);
		init( kf, ks );

		P = ptodip(r,P);
		while( P != _0 )
	        {	kf = lfirst(P);
			ks = lsecond(P);
			P = lred2( P );

			ks = list2( 1, ks );
			ks = diptop( r, ks );
			if(sch)
			{   n=flsign(kf);
			    if(n<0)
			    {	fprintf(pf, " - ");
				kf=flabs(kf);
			    }
			    else fprintf(pf, " + ");
			}
			if(!OUTPUTDIG) fputfl( kf, -DIGITS, pf );
			else fputflfx(kf, 1, OUTPUTDIG,pf);

			if( P != _0 )
			{	fprintf( pf, " * " );
				fputpi( r, ks, V, pf );
			}
			else
			{       kf = ks;	
				for( n = r; n; n--)
                                {	 if( lfirst( kf ) ) break;
					 kf = lsecond( kf );
				}
				if( n )
				{	fprintf( pf, " * " );
					fputpi( r, ks, V, pf );
				}
			}
			sch=1;
		}
        }
	return(1);
}
