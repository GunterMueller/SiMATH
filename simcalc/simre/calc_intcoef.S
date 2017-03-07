/*C
			calc_intcoef( fkeller )

	"calculator integer coefficients".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_intcoef( fkeller )   list fkeller;
	L = calc_intcoef( fkeller );

	fkeller enthaelt eine elliptische Kurve E und eine ganze Zahl
	sch. L ist die zu E birational isomorphe Kurve mit Koeffizienten 
	aus Z. Die Koeffinzienten werden intern als rationale Zahlen 
	dargestellt, da sonst eine neue Kennung erforderlich waere und
	ausgabe veraendert werden muesste.
	Ist sch ungleich 0, so werden die Transformationsparameter 
	ausgegeben.
	Laeuft calc_intcoef fehlerhaft ab, so ist  L = ERROR.
C*/
/*H
	Version  1      28.08.1991      U.Schneiders
	Version  1.1    06.04.1993	S.Schmitt/U.Schneiders
	Version  2	04.02.1994	S.Schmitt/U.Schneiders
	Version  3	10.05.1995	S.Schmitt ( Transformationsparameter )
	Version  3.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

list calc_intcoef( fkeller )
list fkeller;
{
	single k, i, sch;
	rat ko[5];
	obj L, D, u;
	list AVL;
	init( L, D, u, AVL ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"intcoef" );
		return( ERROR );
	}

	L=lfirst(fkeller);
	fkeller=lsecond(fkeller);

	/*** Schalter ***/

	k = lsecond( L );
	if( k )
	{       mistake( 121 );
		return( ERROR );
	}
	sch=lfirst(L);

	/*** elliptische Kurve ***/

	k = lsecond( fkeller );
	if(k != (-1) && k != (-2) && ((k!=(-9) && k!=(-10)) || ecqnfsch==_0))
	{       mistake( 141 );
		return( ERROR );
	}
	if(k==(-9) || k==(-10))   D=lfirst(ecqnfsch);
	fkeller = lfirst( fkeller );
	fkeller=lfirst(fkeller);
	fkeller=lfirst(fkeller);

	if( k == (-1) )
	{ 	ko[0] = lfourth( fkeller );
		ko[1] = lfifth( fkeller );
		L = ecrsnftoic_o( ko[0], ko[1] );
		ko[0]=lfirst(L);
		ko[1]=lsecond(L);
		u=lthird(L);
		ko[0]=itor(ko[0]);
		ko[1]=itor(ko[1]);
		L=ecrinit(0,0,0,ko[0],ko[1]);
	}
	else if(k==(-2))
	{       ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		ko[2] = lthird( fkeller );
		ko[3] = lfourth( fkeller );
		ko[4] = lfifth( fkeller );
		L = ecrtoic_o( ko[0], ko[1], ko[2], ko[3], ko[4] );
		u=lsixth(L);
		for(i=0;i<5;i++)
		{	ko[i]=lfirst(L);
			ko[i]=itor(ko[i]);
			L=lred(L);
		}
		L=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
	}
	else 
	{	L=ecqnftoeci_o(D,fkeller);
		ko[0] = lfirst(L);
		ko[1] = lsecond(L);
		ko[2] = lthird(L);
		ko[3] = lfourth(L);
		ko[4] = lfifth(L);
		u=lsixth(L);
		L=ecqnfinit(D,ko[0],ko[1],ko[2],ko[3],ko[4]);
	}

	if(sch)
	{	
		if(avsch)
		{	AVL=_0;
			AVL=lcomp(list2(u,1),AVL);
			AVL=lcomp(list2(0,0),AVL);
			AVL=lcomp(list2(0,0),AVL);
			AVL=lcomp(list2(0,0),AVL);
			av_basad(AVL);
		}
		if(!assch)
		{   printf( " transformation with:  r = 0\n");
		    printf( "                       s = 0\n");
		    printf( "                       t = 0\n");
		    printf( "                       u = %r\n",u);
		    if( ps )
		    {   fprintf(datei, "out: transformation with:  r = 0\n");
			fprintf(datei, "                           s = 0\n");
			fprintf(datei, "                           t = 0\n");
			fprintf(datei, "                           u = %r\n",u);
		    }
		}
	}

	L = list2( L, k );
	return( L );
}
