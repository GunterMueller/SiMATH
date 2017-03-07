/*C
			calc_trace( fkeller )

	"calculator trace"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_trace( fkeller );  list fkeller;
	X = calc_trace( fkeller );

	1.Fall: fkeller ist eine Liste, bestehend aus einem 
		Zahlkoerperelement a aus K und zugehoeriger Kennung. 
		X ist die Spur von a bzgl. K/Q .
	2.Fall: fkeller ist eine beliebige quadratische Matrix.
		X ist die Spur dieser Matrix.
	Laeuft calc_trace fehlerhaft ab, so ist  X = ERROR.
C*/
/*H
	Version  1      30.09.1992      U.Schneiders
	Version  2	11.07.1994	S.Schmitt
	Version  2.1	04.03.1996	S.Schmitt ( GF(2) )
H*/

#include <_calc.h>

list calc_trace( fkeller )
list fkeller;
{
	pol F;
	obj k,S,VL;
	single sch=0,r;
	init( F, k, S, VL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"trace" );
		return( ERROR );
	}
	
	k = lsecond( fkeller );
	if( k != 24 && k && k!=1 )
	{	sch=1;
		if( (k<5 || k>9) && k!=19 && k!=20 && k!=26 && k!=27 && k!=33 && k!=34)
		{	mistake1( 34,"trace" );
			return( ERROR );
		}		
	}
	if( (!k || k==1) && !nfsch )
	{	mistake( 163 );
		return( ERROR );
	}
	
	/*** Berechnung 1.Fall ***/
	
	if(!sch)
	{   F = lfirst( varlist[nfsch].varwert );
	    if( k != 24 )
	    {	F = lfirst( F );
		fkeller = lfirst( fkeller );
		if( !k ) 
		{	fkeller= iprod( F, fkeller );
			k = list2( fkeller, 0 );	
		}
		else
		{	F = itor( F );
			fkeller = rprod( F, fkeller );
			k = list2( fkeller, 1 );
		}
	    }
	    else		
	    {	k = lsecond( F );
		if( icomp( k, 1 ) )
		{	mistake( 192 );
			return( ERROR );
		}
	
		k = lfirst( fkeller );
		k = nftrace( F, k );
		k = list2( k, 1 );
	    }
	    return( k );
	}

	/*** Berechnung 2.Fall ***/

	else
	{   fkeller=lfirst(fkeller);
	    if(k==7 || k==8 || k==9 || k==20 || k==27 || k==34)
	    {	VL=lfirst(fkeller);
		r=llength(VL);
		fkeller=lsecond(fkeller);
	    }
	    if(k==19)
	    {	VL=lfirst(varlist[modsch].varwert);
		if(VL==2) fkeller=mam2tomams(fkeller);
	    }
	    S=lfirst(fkeller);
	    if(llength(fkeller)!=llength(S))
	    {	mistake(331);
		return(ERROR);
	    }	
	    switch(k)
	    {	case 5: S=maitrace(fkeller);
			S=list2(S,0);
			break;
		case 6: S=martrace(fkeller);
			S=list2(S,1);
			break;
		case 7: S=mapitrace(r,fkeller);
			S=list2(VL,S);
			S=list2(S,2);
			break;
		case 8: S=maprtrace(r,fkeller);
			S=list2(VL,S);
			S=list2(S,3);
			break;
		case 9: S=marfrtrace(r,fkeller);
			S=list2(VL,S);
			S=list2(S,4);
			break;
		case 19:if(issingle(VL)) S=mamstrace(VL,fkeller);
			else S=mamitrace(VL,fkeller);
			S=list2(S,17);
			break;
		case 20:S=lfirst(varlist[modsch].varwert);
			if(issingle(S)) S=mapmstrace(r,S,fkeller);
			else S=mapmitrace(r,S,fkeller);
			S=list2(VL,S);
			S=list2(S,18);
			break;
		case 26:S=lfirst(varlist[nfsch].varwert);
			S=manftrace(S,fkeller);
			S=list2(S,24);
			break;
		case 27:S=lfirst(varlist[nfsch].varwert);
			S=mapnftrace(r,S,fkeller);
			S=list2(VL,S);
			S=list2(S,25);
			break;
		case 33:S=lfirst(varlist[gfsch].varwert);
			if(gfchar!=2) S=magfstrace(gfchar,S,fkeller);
			else S=magf2trace(S,fkeller);
			S=list2(S,31);
			break;
		case 34:S=lfirst(varlist[gfsch].varwert);
			if(gfchar!=2) S=mapgfstrace(r,gfchar,S,fkeller);
			else S=mapgf2trace(r,S,fkeller);
			S=list2(VL,S);
			S=list2(S,32);
			break;
	    }
	    return(S);
	}
}	
