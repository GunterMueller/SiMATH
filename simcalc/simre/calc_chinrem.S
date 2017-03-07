/*C
			calc_chinrem( fkeller )

	"calculator chinese remainder".
	obj calc_chinrem( fkeller )  list fkeller;
	A = calc_chinrem( fkeller );
	fkeller ist eine Liste der Form ( a1,m1,...,an,mn ) mit
	mi paarweise prim zueinander, ai Elemente aus Z oder Polynome
	ueber Z. Berechnet wird mit Hilfe des Chinesischen Restsatzes 
	A, fuer das gilt: A = ai mod mi, 1<=i<=n. Ebenfalls wird 
	M = m1...mn ausgegeben. 
	Laeuft calc_chinrem fehlerhaft, so A = ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.08.1991      U.Schneiders
	Version  2      12.07.1994	S.Schmitt
H*/
 
#include <_calc.h>

obj calc_chinrem( fkeller )
list fkeller;
{
	list A, H, J, M, VL, K;
	list AVL;
	int e;
	obj m, a, h, b, a1, b1;
	single sch,spol=0;
	init( A, H, J, M, VL, K, AVL, e, m, a, h, b, a1, b1 );
	bind( fkeller );

	/*** Abfangen von Fehlern ***/

	if( sodd( llength( fkeller ) ) )
	{       mistake1( 34,"chinrem" );
		return( ERROR );
	}
	A=lcopy(fkeller);
	while(A!=_0)
	{	a=lsecond(A);
		A=lred2(A);
		if(lsecond(a) && lsecond(a)!=2)
		{	mistake1(34,"chinrem");
			return(ERROR);
		}
		if(lsecond(a)==2) spol=1;
	}	

	/*** Aufbau der Listen A = ( a1,...,an ) und M = ( m1,...,mn ) ***/

	A = _0; M = _0; VL=_0;
	while( fkeller != _0 )
	{       m = lfirst( fkeller );
		if( lsecond( m ) )
		{       mistake1( 34,"chinrem" );
			return( ERROR );
		}
		m = lfirst( m );
		if( isign( m ) <= 0 )
		{       mistake( 147 );
		        return( ERROR );
		}
		M = lcomp( m, M );
		a = lsecond( fkeller );
		if(!spol)
		{   a = lfirst( a );
		    a = mihom( m, a );
		}
		else
		{	if(!lsecond(a))
			{	a=lfirst(a);
				a=mihom(m,a);
				if(A!=_0 && VL!=_0)
				{	e=llength(VL);
					a=pvinsert(0,a,e);
					a=pitopmi(e,a,m);
				}
			}
			else
			{	a=lfirst(a);
				H=lfirst(a);
				e=llength(H);
				a=lsecond(a);
				a=pitopmi(e,a,m);
				if(A!=_0)
				{  	J=_0;
					a1=_0;
				   	while(A!=_0)
				   	{   b=lfirst(A);
					    A=lred(A);
					    if(VL!=_0)
					    { K=pvmix(H,VL,a,b,&a1,&b1);
					      if(A==_0) H=K;
					    }
					    else
					      b1=pvinsert(0,b,e);
					    J=lcomp(b1,J);
				        }
					A=linv(J);
					VL=H;
					if(a1!=_0) a=a1;
				}
				else VL=lcopy(H);
			}
		}
		A = lcomp( a, A );
		fkeller = lred2( fkeller );
	}

	/*** Testen, ob mi paarweise prim zueinander ***/

	H = M; sch = 0; e = 1;
	while( H != _0 )
	{       m = lfirst( H );
		H = lred( H );
		e = iprod( m, e );
		J = H;
		while( J != _0 )
		{       a = lfirst( J );
			J = lred( J );
			if( igcd( m, a ) != 1 )
			{       sch = 1; break; }
		}
		if( sch ) break;
	}
	if( sch )
	{       mistake( 140 );
		return( ERROR );
	}
	if(avsch) 
	{	AVL=list1(list2(e,0));
		av_basad(AVL);
	}

	/*** eigenliche Berechnung ***/
	m = llength( M );
	if(!spol)
	{	a = micran( m, M, A );
		if(!assch){
		printf( " uniquely determined mod %i:\n", e );
		if( ps ) fprintf( datei, "out: uniquely determined mod %i:\n", e );
		}
		a = list2( a, 0 );
	}
	else
	{	b=llength(VL);
		a=picran(b,m,M,A);
		if(a==ERROR) return(ERROR);
		if(!assch){
		printf(" uniquely determined mod %i:\n",e);
		if(ps) fprintf(datei,"out: uniquely determined mod %i:\n",e);
		}
		a=list2(VL,a);
		a=list2(a,2);
	}
	return(a);
}
