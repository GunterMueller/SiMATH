/*C
			fputpgfs( r, P, V, Vgfs, pf )

	"file put polynomial over Galois-field"
	Quellbibliothek: srclib.simmv
	Include-Datei:   _calc.h
	fputpgfs(r,P,V,Vgfs,pf)  single r; pol P; list V,Vgfs; 
				 FILE *pf;
	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber einem
	endlichen Koerper GF(q) der Charakteristik p < BASIS.
	Ist r gleich 0, so muss V die leere Liste sein; sonst ist
	V eine Liste V = (V1,...,Vr), wobei die Elemente Vi von V
	die Variablennamen repraesentieren, und zwar in der Form:
	  Vi = ( ascii(Bu) , ascii(BZ2) , ... , ascii(BZn) )
		falls der Name der i-ten Variablen aus den n
		alphanumerischen Zeichen Bu,BZ2,...,BZn besteht.
	Ein Variablenname muss immer mit einem Buchstaben beginnen.
	Die Liste Vr repraesentiert den Namen der Hauptvariablen.
	Analog ist Vgfs eine einelementige Variablenliste, die den Namen
	eines primitiven Elementes der Koerpererweiterung GF(q)/(Z/pZ)
	repraesentiert.
	pf ist ein Zeiger auf eine zum Schreiben geoeffnete Datei.
	fputpgfs schreibt ein Polynom in r Variablen ueber GF(q) auf
	die Datei *pf. 
C*/
/*H
	Version 1       07.06.1993      S.Schmitt/U.Schneiders
H*/
/*cS
	fputpgfs ruft auf: diptop, fprintf, fputgfsel, fputpi, fputs, 
			   ptodip
	Macros: lfirst, list2, lred2, lsecond
Sc*/


#include <_calc.h>

fputpgfs(r,P,V,Vgfs,pf)
single r;
pol P;
list V, Vgfs;
FILE *pf;
{
	bind(P,V,Vgfs);

	if (!P) fputs("GF(0)",pf);
	else if (!r) fputgfsel(P,Vgfs,pf);
	else {
		single n;
		obj kf, ks;
		list L;
		init( L, kf, ks );

		P = ptodip(r,P);
		L = _0;
		while( P != _0 )
	        {	kf = lfirst(P);
			ks = lsecond(P);
			P = lred2( P );

			ks = list2( 1, ks );
			ks = diptop( r, ks );
			fputgfsel( kf, Vgfs, pf );
			if( P != _0 )
			{	fprintf( pf, "*" );
				fputpi( r, ks, V, pf );
			}
			else
			{       kf = ks;	
				for( n = r; n; n--)
                                {	 if( lfirst( kf ) ) break;
					 kf = lsecond( kf );
				}
				if( n )
				{	fprintf( pf, "*" );
					fputpi( r, ks, V, pf );
				}
			}

			if( P != _0 ) fprintf( pf, " + " );
			
		}
        }
}
