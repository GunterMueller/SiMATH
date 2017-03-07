/*C
			fputpnf( r, F, P, V, Vnf, pf )

	"file put polynomial over number field"
	Quellbibliothek: srclib.simmv
	Include-Datei:   _pol3.h
	single fputpnf(r,F,P,V,Vnf,pf)  single r; pol F,P;
				       list V,Vnf; FILE *pf;
	a = fputpnf(r,F,P,V,Vnf,pf);
	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber einem
	Zahlkoerper K. F ist das zugehoerige irreduzible Polynom in
	einer Variablen ueber Z, das den Zahlkoerper erzeugt, d.h. K
	entsteht durch Adjunktion einer Nullstelle von F.
	Ist r gleich 0, so muss V die leere Liste sein; sonst ist
	V eine Liste V = (V1,...,Vr), wobei die Elemente Vi von V
	die Variablennamen repraesentieren, und zwar in der Form:
	  Vi = ( ascii(Bu) , ascii(BZ2) , ... , ascii(BZn) )
		falls der Name der i-ten Variablen aus den n
		alphanumerischen Zeichen Bu,BZ2,...,BZn besteht.
	Ein Variablenname muss immer mit einem Buchstaben beginnen.
	Die Liste Vr repraesentiert den Namen der Hauptvariablen.
	Analog ist Vnf eine einelementige Variablenliste, die den
	Namen einer Nullstelle von F repraesentiert.
	pf ist ein Zeiger auf eine zum Schreiben geoeffnete Datei.
	fputpnf schreibt ein Polynom in r Variablen ueber einem Zahl-
	koerper K auf die Datei *pf. Die Koeffizienten werden dann als
	Polynome in der Variablen von Vnf ueber Q aufgefasst.
	fputpnf liefert den Ergebniswert
		0       falls der Programmablauf fehlerfrei war;
		ERROR   falls Fehler auftraten.
C*/
/*H
	Version 1       11.04.1991      A. Stein
	Version 2	30.04.1992	U. Schneiders ( Calcul.-Vers. )
H*/
/*cS
	fputpnf ruft auf: diptop, fputnfel, fputpi, ptodip
	Macros: fprintf, fputs, lfirst, lred2, lsecond
Sc*/


#include <_pol3.h>

single fputpnf(r,F,P,V,Vnf,pf)
single r;
pol F,P;
list V, Vnf;
FILE *pf;
{                    
	bind( F, P, Vnf );

	if (!P) fputs("0",pf);
	else if (!r) 
	{	P=kenntest(list2(P,24));
		r=lsecond(P);
		P=lfirst(P);
		if(r==24) fputnfel(F,P,Vnf, pf);
		else if(r==1) fputr(P, pf);
		else fputi(P, pf);
	}
	else {
		single n, sch=0;
		obj kf, ks;
		list L;
		bind(V);
		init( L, kf, ks );

		P = ptodip(r,P);
		L = _0;
		while( P != _0 )
	        {	kf = lfirst(P);
			ks = lsecond(P);
			P = lred2( P );

			ks = list2( 1, ks );
			ks = diptop( r, ks );
			kf=kenntest(list2(kf,24));
			n=lsecond(kf);
			kf=lfirst(kf);
			if(n==24) 
			{	if(sch) fprintf(pf, " + ");
				fputnfel( F, kf, Vnf, pf );
			}
			else if(n==1) 
			{	if(sch)
				{   n=rsign(kf);
				    if(n<0)
				    {	fprintf(pf, " - ");
					kf=rabs(kf);
				    }
				    else fprintf(pf, " + ");
				}
				fputr( kf, pf );
			}
			else 
			{	if(sch)
				{   n=isign(kf);
				    if(n<0)
				    {	fprintf(pf," - ");
					kf=iabs(kf);
				    }
				    else fprintf(pf," + ");
				}
				else if(icomp(kf,(-1))==0) 
				{	fprintf(pf,"- ");	
					kf = iabs(kf);
				}
				if(icomp(kf,1)) fputi( kf, pf );

/** konstanter Faktor +/- 1 : 1 muss ausgegeben werden! **/

				else if(P==_0)
				{	L=list2(0,1);
					for(n=r-1;n;n--) L=list2(0,L);
					if(oequal(L,ks)) fputi(kf,pf);
					else sch=2;
				}
				else sch=2;
			}
			if( P != _0 )
			{	if(sch<2) fprintf( pf, "*" );
				fputpi( r, ks, V, pf );
			}
			else
			{       kf = ks;	
				for( n = r; n; n--)
                                {	 if( lfirst( kf ) ) break;
					 kf = lsecond( kf );
				}
				if( n )
				{	if(sch<2) fprintf( pf, "*" );
					fputpi( r, ks, V, pf );
				}
			}
			sch=1;
		}
        }
	return(1);
}
