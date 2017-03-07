/*C
			calc_ecgnp( fkeller )

	"calculator elliptic curve with given number of points".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	int calc_ecgnp( fkeller )   list fkeller;
	L = calc_ecgnp( fkeller );

	fkeller ist eine Liste, bestehend aus entweder einer 
	Primzahl p, der Anzahl der rationalen Punkte m und der
	Diskriminante D des imaginaerquadratischen Zahlkoerpers,
	oder nur aus m und D. Im zweiten Fall ist p die mit curmod
	spezifizierte Primzahl.
	Es muss gelten: p>3
			m>=0
			D<=0
	m und D duerfen nicht gleichzeitig 0 sein.
	Laeuft calc_ecgnp fehlerhaft ab, so ist  L = ERROR.
C*/
/*H
	Version  1	25.10.1993	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

int calc_ecgnp( fkeller )
list fkeller;
{
	single lp,lm,ks,sch,nsch=0;
	int x,h1,j,h,h2,h3,p;
	obj pi,D,m,e;
	list L,K,P;
	list AVL;
	init(x,h1,j,h,h2,h3,p,pi,D,m,e,L,K,P,AVL);
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/
# ifdef ___CASI

	sch = llength( fkeller );
	if( sch != 2 && sch !=3 )
	{       mistake1( 34,"ecgnp" );
		return( ERROR );
	}

	if( sch == 3 )
	{ 
		/*** Primzahl ***/

		p = lthird( fkeller );
		ks = lsecond( p );
		if( ks )
		{       mistake( 46 );
			return( ERROR );
		}
		p = lfirst( p );
		if( isatom( p ) )
		{	ks = issprime( p, &j );
			if( !ks || ks == (-1) )
			{       mistake( 46 );
				return( ERROR );
			}
			if(p==2 || p==3)
			{	mistake(279);
				return(ERROR);
			}
		} 
		else
		{	L = ispd(p,&m);
			if(L!=_0)
			{
				mistake(46);
				return(ERROR);
			}
		}
	}
	else 
	{	if(!modsch)
		{	mistake(158);
			return(ERROR);
		}
		p=lfirst(varlist[modsch].varwert);
		if(icomp(p,3)<=0)
		{	mistake(279);
			return(ERROR);
		}
	}
	
		/*** Anzahl der Punkte ***/

	m=lsecond(fkeller);
	ks=lsecond(m);
	if(ks)
	{	mistake1(34,"ecgnp");
		return(ERROR);
	}
	m=lfirst(m);
	if(isign(m)<0)
	{	mistake1(34,"ecgnp");
		return(ERROR);
	}

		/*** Test, ob m im Hasse-Intervall liegt ***/

	if(m)
	{	h=iprod(2,p);
		h=isum(h,1);
		if(icomp(m,h)>0)
		{	mistake(280);
			return(ERROR);
		}
		h=isum(p,1);
		h=idif(h,m);
		h=iprod(h,h);
		h2=iprod(4,p);
		h=idif(h,h2);
		if(isign(h)>=0)
		{	mistake(280);
			return(ERROR);
		}
	/*	h = isfp( h );*/
	}
	else nsch=1;

		/*** Diskriminante ***/

	D=lfirst(fkeller);
	ks=lsecond(D);
	if(ks)
	{	mistake1(34,"ecgnp");
		return(ERROR);
	}
	D=lfirst(D);
	if(isign(D)>0)
	{	mistake1(34,"ecgnp");
		return(ERROR);
	}
	if(nsch && !D)
	{	mistake1(34,"ecgnp");
		return(ERROR);
	}
	D=isfp(D);

		/*** Testen, ob bei gegeb. m und D D richtig gewaehlt ***/
	if( m && D )
	{	h2 = rcons( h, D );
		h2 = lfirst( h2 );
		h3 = isqrt( h2 );
		h3 = iprod( h3, h3 );
		if( icomp( h3, h2 ) )
		{	mistake1( 34,"ecgnp" );
			return( ERROR );
		}
	}

		/*** Berechnung von m ***/
	
	if(nsch)
	{	if(mshom(4,D)!=1) h = iprod( 4, D );
		else h = D;
		L = iprpdbqf( h, 0, 10000 );
		if( L ) 
		{	if(!assch)
			  L = llength( lfirst( L ) ) + 2 * llength( lsecond( L ) );
		}
		else
		{	mistake( 281 );
			return( ERROR );
		}
		if(avsch) AVL = list1(list2( L,0 ));
		if(!assch){
		printf( " class number = %i\n", L );
		if( ps ) fprintf( datei, "out: class number = %i\n", L );
		}
	        L=iprniqf(p,h);
		if(!L)
		{	mistake(46);
			return(ERROR);
		}
		if(L==_0)
		{	mistake(282);
			return(ERROR);
		}
		x=iprod(2,p);
		x=isum(x,1);
		lp=ilog10(x);
		while(L!=_0)
		{	m=lfirst(L);
			L=lred(L);
			e = lfirst( m );
			j = lsecond( m );
			if( !mihom(4,h) )   /*** h = 0 mod 4 ***/
			{	e = idif( e, 1 );
				e = iprod( e, e );
				j = iprod( j, j );
				j = iprod( j, h );
				j = rcons( j, 4 );
				j = rnum( j );
				m = idif( e, j );
			}
			else
			{	e = idif( e, 1 );
				h1 = idif( 1, h );
				h1 = rcons( h1, 4 );
				h1 = rnum( h1 );
				h3 = iprod( e, j );
				e = iprod( e, e );
				j = iprod( j, j );
				j = iprod( h1, j );	
				m = isum( e, h3 );
				m = isum( m, j );
			}
			K=iecgnpj(p,m,0,10000,D);		
			if(K==(-1))
			{	mistake(46);
				return(ERROR);
			}
			if(K==_0)
			{	mistake(281);
				return(ERROR);
			}
			j=lfirst(K);
		
		/*** elliptische Kurve und Twist ***/

			h1 = isum( p, 1 );
			if( (!j || j==mihom(p,1728)) && icomp( m, h1 ) )
			{	K=iprniqf(p,h);
				if(!K)
				{	mistake(46);
					return(ERROR);
				}
				if(K==_0)
				{	mistake(282);
					return(ERROR);
				}
				while( K != _0 )
				{	pi=lfirst(K);
					K = lred( K );
					e = lfirst( pi );
					h3 = lsecond( pi );
					if( !mihom(4,h) )   /*** h = 0 mod 4 ***/
					{	e = idif( e, 1 );
						e = iprod( e, e );
						h3 = iprod( h3, h3 );
						h3 = iprod( h3, h );
						h3 = rcons( h3, 4 );
						h3 = rnum( h3 );
						h1 = idif( e, h3 );
					}
					else
					{	e = idif( e, 1 );
						h1 = idif( 1, h );
						h1 = rcons( h1, 4 );
						h1 = rnum( h1 );
						x = iprod( e, h3 );
						e = iprod( e, e );
						h3 = iprod( h3, h3 );
						h3 = iprod( h1, h3 );	
						h1 = isum( e, x );
						h1 = isum( h1, h3 );
					}
					if(!icomp(h1,m)) break;
				}	
				K=iecjtoeqsv(p,j,pi);
			}
			else 
			{	K=iecjtoeq(p,j);
				if(K==_0)
				{	mistake(46);
					return(ERROR);
				}
			        h1=lfirst(K);
				h2=lsecond(K);
				if( icomp(p,46337)<=0) 
				{	j=ecmspsnfnp(p,h1,h2);
					if(j==ERROR)
					{	mistake(87);
						return(ERROR);
					}
				}
				else if( icomp( p, 100000000 ) < 0 )
				{       for( ks = 0; ks < 2; ks++ )
					{       j = ecmspsnfsha( p, h1, h2 );
						if( j != NULL && j >= 0 )  break;
					}
					if( j == NULL || j < 0 )
					{       mistake( 247 );
						return( ERROR );
					}
				}
				else     
				{	P=ecmpsnffp(p,h1,h2);
					P=ecmpsnfmul(p,h1,h2,m,P);
					if(!lthird(P)) j=m;
					else j=(-1);
				}		
				if(icomp(j,m)) K=lred2(K);
				else  K=list2(h1,h2);	
			}
	
		/*** Ausgabe der ellipt. Kurve ***/

			h1=lfirst(K);
			h2=lsecond(K);
			if(!assch)	
		        {	lm=ilog10(m);
				lm=lp-lm;
			        printf(" m = ");
				if(ps) fprintf(datei,"out: m = ");
			
				for(ks=0;ks<lm;ks++)
				{	puts(" ");
					if(ps) fputs(" ",datei);
				}
				if(sch==3)
				{	printf("%i:   EC(%i, %i)\n",m,h1,h2);
					if(ps) fprintf( datei,"%i:   EC(%i, %i)\n",m,h1,h2);
				}
				else
				{	printf("%i:   EC(MOD(%i), MOD(%i))\n",m,h1,h2);
					if(ps) fprintf(datei,"%i:   EC(MOD(%i), MOD(%i))\n",m,h1,h2);
				}
			}
			if( avsch )
			{	AVL = lcomp( list2(m,0), AVL );
				if(sch==3)
				{	if(h1) h1=list2(h1,1);
					if(h2) h2=list2(h2,1);
					P = ecrinit(0,0,0,h1,h2);
					P = list2(P,(-1));
					AVL = lcomp( P, AVL );
				}
				else AVL = lcomp( list2(K,(-5)), AVL );
			}
			x=isum(p,1);
			if(L==_0 || !icomp(m,x))
			{ 	if(sch==3 && !avsch) 
				{	if(h1) h1=list2(h1,1);
					if(h2) h2=list2(h2,1);
					L=ecrinit(0,0,0,h1,h2);
					L=list2(L,-1);
				}
				else if( sch==3 ) L = P;
				else L=list2(K,-5);
				break;
			}
		}
		if( avsch )
		{	AVL = linv(AVL);
			av_basad(AVL);
		}
	}
	
		/*** j-Invarianten ***/
	else
	{ 	if( !D ) h = isfp( h );
		else h = D;
                L=iecgnpj(p,m,0,10000,D);
		if(L==(-1))
		{	mistake(46);
			return(ERROR);
		}
		if(L==_0)
		{	mistake(281);
			return(ERROR);
		}
		j=lfirst(L);
			
		/*** elliptische Kurve und Twist ***/

		h2 = isum( p, 1 );
		if( (!j || j==mihom(p,1728)) && icomp( m, h2 ) )
		{	if( mshom(4,h)!=1 ) h = iprod(4,h);
	        	L=iprniqf(p,h);
			if(!L)
			{	mistake(46);
				return(ERROR);
			}
			if(L==_0)
			{	mistake(282);
				return(ERROR);
			}
			while( L != _0 )
			{	pi=lfirst(L);
				L = lred( L );
				e = lfirst( pi );
				h3 = lsecond( pi );
				if( !mihom(4,h) )   /*** h = 0 mod 4 ***/
				{	e = idif( e, 1 );
					e = iprod( e, e );
					h3 = iprod( h3, h3 );
					h3 = iprod( h3, h );
					h3 = rcons( h3, 4 );
					h3 = rnum( h3 );
					h2 = idif( e, h3 );
				}
				else
				{	e = idif( e, 1 );
					h2 = idif( 1, h );
					h2 = rcons( h2, 4 );
					h2 = rnum( h2 );
					h1 = iprod( e, h3 );
					e = iprod( e, e );
					h3 = iprod( h3, h3 );
					h3 = iprod( h2, h3 );	
					h2 = isum( e, h1 );
					h2 = isum( h2, h3 );
				}
				if(!icomp(h2,m)) break;
			}	
			L=iecjtoeqsv(p,j,pi);
		}
		else 
		{	L=iecjtoeq(p,j);
			if(L==_0)
			{	mistake(46);
				return(ERROR);
			}
			h=lfirst(L);
			h2=lsecond(L);
			if( icomp( p, 46337 ) <= 0 )
			{	j=ecmspsnfnp(p,h,h2);
				if(j==ERROR)
				{	mistake(87);
					return(ERROR);
				}
			}
			else if(icomp(p,100000000) <0)
			{       for( ks = 0; ks < 2; ks++ )
				{       j = ecmspsnfsha( p, h, h2 );
					if( j != NULL && j >= 0 )  break;
				}
				if( j == NULL || j < 0 )
				{       mistake( 247 );
					return( ERROR );
				}
			}
			else    
			{	P=ecmpsnffp(p,h,h2);
				P=ecmpsnfmul(p,h,h2,m,P);
				if(!lthird(P)) j=m;
				else j=(-1);
			}
			if(icomp(j,m)) L=lred2(L);
			else  L=list2(h,h2);	
		}
		
		/*** Zus.bau der ellipt. Kurve ***/

		if(sch==3) 
		{	h=lfirst(L);
			if(h) h=list2(h,1);
			h2=lsecond(L);
			if(h2) h2=list2(h2,1);
			L=ecrinit(0,0,0,h,h2);
			L=list2(L,-1);
		}
		else L=list2(L,-5);
	}
	return(L);
# else
	mistake(5);
	return(ERROR);
# endif
}
