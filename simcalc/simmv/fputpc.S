/*C
			fputpc( r, P, V, pf )

	"file put polynomial over complex numbers"
	Quellbibliothek: srclib.simmv
	Include-Datei:   _calc.h
	single fputpc(r,P,V,pf)  single r; pol P; list V; FILE *pf;
	a = fputpc(r,P,V,pf);
	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber den 
	komplexen Zahlen. 
	Ist r gleich 0, so muss V die leere Liste sein; sonst ist
	V eine Liste V = (V1,...,Vr), wobei die Elemente Vi von V
	die Variablennamen repraesentieren, und zwar in der Form:
	  Vi = ( ascii(Bu) , ascii(BZ2) , ... , ascii(BZn) )
		falls der Name der i-ten Variablen aus den n
		alphanumerischen Zeichen Bu,BZ2,...,BZn besteht.
	Ein Variablenname muss immer mit einem Buchstaben beginnen.
	Die Liste Vr repraesentiert den Namen der Hauptvariablen.
	pf ist ein Zeiger auf eine zum Schreiben geoeffnete Datei.
	fputpc schreibt ein Polynom in r Variablen ueber den
	komplexen Zahlen auf die Datei *pf.
	fputpc liefert den Ergebniswert 1.
C*/
/*H
	Version 1	24.01.1995	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

single fputpc(r,P,V,pf)
single r;
pol P;
list V;
FILE *pf;
{                    
	bind( P );

	if (!P) fputs("0",pf);
	else if (!r) 
        {	if(!OUTPUTDIG) fputcomp( P, -DIGITS, pf );
		else fputcompfx(P,1,OUTPUTDIG,pf);
	}
	else {
		single n, sch=0;
		obj kf, ks, re;
		list L;
		bind(V);
		init( kf, ks, re, L );

		P = ptodip(r,P);
		while( P != _0 )
	        {	kf = lfirst(P);
			ks = lsecond(P);
			P = lred2( P );

			ks = list2( 1, ks );
			ks = diptop( r, ks );
			if( !lfirst(kf) )
			{	if(sch)
				{	kf = lsecond(kf);
					n = flsign(kf);
					if(n<0)
					{  fprintf(pf, " - ");
					   kf = flabs(kf);
				        }
					else fprintf(pf, " + ");
					kf = list2( 0, kf );
				}
                         	if(!OUTPUTDIG) fputcomp( kf, -DIGITS, pf );
			        else fputcompfx(kf,1,OUTPUTDIG,pf);
			}
			else if( !lsecond(kf) )
			{	kf = lfirst(kf);
				if(sch)
				{	n = flsign(kf);
					if(n<0)
					{  fprintf(pf," - ");
					   kf = flabs(kf);
				        }
					else fprintf(pf," + ");
				}
	    			re = lfirst( kf );
				if( re >= 0 )
	    			{       kf = lred( kf );
	           			while( re-- )  kf = lcomp( 0,kf );
		   			if( llength( kf ) == 1 ) kf = lfirst( kf );
				        if(icomp(kf,(-1))==0) 
				        {   fprintf(pf, "- ");	
				            kf = iabs(kf);
				        }
				        if(icomp(kf,1)) fputi( kf,pf );

/** konstanter Faktor +/- 1 : 1 muss ausgegeben werden! **/

					else if(P==_0)
					{	L=list2(0,1);
						for(n=r-1;n;n--) L=list2(0,L);
						if(oequal(L,ks)) fputi(kf,pf);
						else sch=2;
					}
					else sch=2;
	    			}
				else
				{       if(!OUTPUTDIG) fputfl( kf, -DIGITS,pf);
			        	else fputflfx(kf, 1, OUTPUTDIG,pf);
				}
			}
			else
			{	re = lfirst(kf);
				n = flsign(re);
				if(n<0)
				{	if(sch) fprintf(pf, " - ");
					else    fprintf(pf, "- ");
					if(P!=_0) kf = cneg(kf);
					else 
					{	kf=lsecond(kf);
						re=flneg(re);
						kf=list2(re,kf);
					}
				}
				else if( sch )  fprintf(pf, " + ");
				L=list2(0,1);
				for(n=r-1;n;n--) L=list2(0,L);
				if(!oequal(L,ks))
				{	fprintf(pf,"(");
					n=1;
				}
				else n=0;
                         	if(!OUTPUTDIG) fputcomp( kf, -DIGITS, pf );
			        else fputcompfx(kf,1,OUTPUTDIG,pf);
				if(n) fprintf(pf,")");
			}
				
			if( P != _0 )
			/**{	if(sch<2) fprintf( pf, " * " );**/
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
				/**{	if(sch<2) fprintf( pf, " * " );**/
				{	if(sch<2) fprintf( pf, "*" );
					fputpi( r, ks, V, pf );
				}
			}
			sch=1;
		}
        }
	return(1);
}
