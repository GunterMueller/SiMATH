/*C
			calc_mtoi( fkeller )

	"calculator modular to integer"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_mtoi( fkeller );  list fkeller;
	X = calc_mtoi( fkeller );

	fkeller ist eine Liste, bestehend aus einer Struktur ueber
	Z/mZ. X ist dieselbe Struktur, nur aufgefasst ueber Q.
	Laeuft calc_mtoi fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      02.11.1992      U.Schneiders
	Version  2      30.03.1993      S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

list calc_mtoi( fkeller )
list fkeller;
{
	obj a, W, L1, L2, N;
	list T;
	rat koef[5];
	single k, i;
	init( a, W, L1, L2, N, T );
	init(koef[0..4]);
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"mtoi" );
		return( ERROR );
	}
	
	k = lsecond( fkeller );
	if( k < (-8) || ( k > (-5) && k < 16 ) || k > 22 )
	{	mistake1( 34,"mtoi" );
		return( ERROR );
	}
	
	/*** Umwandlung ueber Z ***/

	W = lfirst( fkeller );
	switch( k )
	{	case 16:
		case 17: k = 0; break;
		case 18: k = 2; break;
		case 19: if(lfirst(varlist[modsch].varwert)==2) W=mam2tomams(W);
			 k = 5; break;
		case 20: k = 7; break;
		case 21: k = 10; break;
		case 22: k = 12; break;
		case (-5): k=(-1);
			   koef[0]=lfirst(W);
			   koef[1]=lsecond(W);
			   koef[0]=itor(koef[0]);
			   koef[1]=itor(koef[1]);
		  	   W=ecrinit(0,0,0,koef[0],koef[1]);
			   break;
		case (-6): k=(-2);
			   koef[0]=lfirst(W);
			   koef[1]=lsecond(W);
			   koef[2]=lthird(W); 
			   koef[3]=lfourth(W);
			   koef[4]=lfifth(W);
			   for(i=0;i<5;i++)
				koef[i]=itor(koef[i]);
			   W=ecrinit(koef[0],koef[1],koef[2],koef[3],koef[4]);
			   break;
		case(-7):  k=(-3);
			   if(!W)
			    	W=list3(0,1,0);
			   else
			   {	N=lcopy(W);
				W=lsuffix(N,1);
			   }
			   break;
		case(-8):  k=(-4);
			   if((N=lthird(W)))
			   {	L1=lfirst(W);
				L2=lsecond(W);
				L1=iprod(L1,N);
				L2=iprod(L2,N);
				L2=iprod(L2,N);
				W=list3(L1,L2,N);
			   }
			   break;
		default: break;
	}
	W = list2( W, k );
	return( W );
}	
