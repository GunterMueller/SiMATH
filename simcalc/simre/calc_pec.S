/*C
			calc_pec( fkeller )

	"calculator point on elliptic curve".
	list calc_pec(fkeller); list fkeller;
	L = calc_pec( fkeller );

	fkeller ist eine Liste bestehend aus zwei oder drei Objekten
	mit zugehoerigen Kennungen. Sie entsprechen den Koordinaten
	eines Punktes in affiner bzw. projektiver Darstellung. Ihre
	Kennung muss 0, 1, 17 oder 24 sein. 
	In projektiver Darstellung ueber Z/pZ und ueber Zahlkoerpern
	wird die projektive Standarddarstellung, d.h. z = 1, berechnet.
	Sonst wird die normierte Darstellung berechnet 
	(siehe fgetecrp()).
	Laeuft calc_pec fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.11.1990      U.Schneiders
	Version  2      31.03.1992      U.Schneiders ( Z/mZ )
	Version  2.1    21.05.1992      U.Schneiders ( NF )
	Version  3      26.03.1993	S.Schmitt/U.Schneiders
	Version  3.1    12.07.1993	U.Schneiders (GF in char 2)
H*/
 
#include <_calc.h>

list calc_pec( fkeller )
list fkeller;
{
	single ak, akmax, i, ken, o;
	obj a, koef[3], z, z1;
	list L;
	init( a, L, z, z1 );
	init( koef[0..2] );
	bind( fkeller );

	/*** affine oder projektive Darstellung ***/

	ken = llength( fkeller );
	if( ken != 2 && ken != 3 )
	{       mistake( 108 );
		return( ERROR );
	}
	if( ken == 2 )  {   ken = (-3); i = 1;   }
	else            {   ken = (-4); i = 2;   }

	/*** Koordinaten aus Z oder Q ***/

	L = _0; akmax = 0;
	while( fkeller != _0 )
	{       a = lfirst( fkeller );
		ak = lsecond( a );
		if( ak && ak != 1 && ak != 17 && ak != 24 && ak != 31 )
		{       mistake( 109 );
			return( ERROR );
		}
		if( ak == 17 && !pzsch )
		{	mistake( 46 );
			return( ERROR );
		}
		if( ak == 31 && gfchar != 2 )
		{	mistake( 107 );
			return( ERROR );
		}
		if( ( (ak == 17 || ak == 31) && akmax == 24 ) 
		|| ( ak == 24 && (akmax == 17 || akmax ==31)) )
		{	mistake( 165 );
			return( ERROR );
		}
		if( ((ak==17 && akmax==31) || (ak==31 && akmax==17)) &&
		gfchar != lfirst( varlist[modsch].varwert) )
		{	mistake( 266 );
			return( ERROR );
		}
		if( ak > akmax )  akmax = ak;
		koef[i] = a;
		i--;
		fkeller = lred( fkeller );
	}


	if( ken == (-3) ) o = 2;
	else              o = 3;
	for( i = 0; i < o; i++ )
	{	a = lfirst( koef[i] );
		ak = lsecond( koef[i] );
		switch( akmax )
		{       case 1: if( !ak ) a = itor( a );
				break;
			case 17:if( ak < 2 )
				{	a = calc_m( koef[i] );
					if( a == ERROR ) return( ERROR );
					a = lfirst( a );
				}
				break;
			case 24:if( ak < 2 )
				{	a = calc_nf( koef[i] );
					if( a == ERROR ) return( ERROR );
					a = lfirst( a );
				}
				break;
			case 31:if( ak < 30 )
				{	a = calc_gf( koef[i] );
					if( a == ERROR ) return( ERROR );
					a = lfirst( a );
				}
				break;
			default: break;	
   		}
		if(akmax>1)
		        L = lcomp( a, L );
		koef[i] = a;
	}
	if(akmax>1)
	         L = linv( L );
	else
	{	if(akmax)
		{	if(ken==(-3))
			{	if(koef[0]) a=lsecond(koef[0]);
				else a=1;
				if(koef[1]) z=lsecond(koef[1]);
				else z=1;
				z=ilcm(a,z);
				a=itor(z);
				koef[0]=rprod(koef[0],a);
				koef[1]=rprod(koef[1],a);
				if(koef[0])
				   koef[0]=lfirst(koef[0]);
				if(koef[1])
				   koef[1]=lfirst(koef[1]);
				koef[0]=iprod(koef[0],z);
				koef[1]=iprod(koef[1],z);
				koef[1]=iprod(koef[1],z);		
				L=list3(koef[0],koef[1],z);
			}
			else
		        {	if(!koef[2])
					L=list3(0,1,0);
				else
				{	if(koef[0]) a=lsecond(koef[0]);
					else a=1;
					if(koef[1]) z=lsecond(koef[1]);
					else z=1;
					if(koef[2]) z1=lsecond(koef[2]);
					else z1=1;
					a=ilcm(a,z);	
					a=ilcm(a,z1);
					a=itor(a);
					for(i=0;i<3;i++)
					{   koef[i]=rprod(koef[i],a);
					    if(koef[i])
					       koef[i]=lfirst(koef[i]);
					}
					koef[0]=iprod(koef[0],koef[2]);
					koef[1]=iprod(koef[1],koef[2]);
					koef[1]=iprod(koef[1],koef[2]);
					L=list3(koef[0],koef[1],koef[2]);
				}
			}
		}
		else
		{	if(ken==(-3))
				L=list3(koef[0],koef[1],1);
			else
			{	if(!koef[2])
					L=list3(0,1,0);
				else
				{	koef[0]=iprod(koef[0],koef[2]);
					koef[1]=iprod(koef[1],koef[2]);
					koef[1]=iprod(koef[1],koef[2]);
					L=list3(koef[0],koef[1],koef[2]);
				}
			}
		}	
	}
					
	if( akmax == 17 )
        {	 ken = ken - 4;
		 a = lfirst( varlist[modsch].varwert );
	}
	else if( akmax == 24 )
        {	 ken = ken - 8;
		 a = lfirst( varlist[nfsch].varwert );
	}
	else if( akmax == 31 )
        {	 ken = ken - 12;
		 a = lfirst( varlist[gfsch].varwert );
	}

	/*** projektive Standarddarstellung ***/

	if( ken == (-8) )
		L = ecmpsrpp( a, L );
	else if( ken == (-12) )
		L = ecnfsrpp( a, L );
	else if( ken == (-16) )
		L = ecgf2srpp( a, L );

	L = list2( L, ken );           
	return( L );
}
